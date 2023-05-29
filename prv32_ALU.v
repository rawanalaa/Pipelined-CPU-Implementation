`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2022 02:51:25 PM
// Design Name: 
// Module Name: prv32_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module prv32_ALU(
	input   wire [31:0] a, b,
	input   wire [4:0]  shamt,
	input ALUsrc,
	output  reg  [31:0] r,
	output  wire        cf, zf, vf, sf,
	input   wire [4:0]  alufn             //////////bonus make it 5 instead of 4
);

    wire [31:0] add, sub, op_b;
    wire cfa, cfs;
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    shifter shifter0(a, b, shamt, ALUsrc, alufn[1:0],  sh);
    
    always @ * begin
        r = 0;
        (* parallel_case *) // to avoid default
        case (alufn)
            // arithmetic
            5'b000_00 : r = add; //+           //make it 5 instaed of 4
            5'b000_01 : r = add; //-
            5'b000_11 : r = b; 
            // logic
            5'b001_00:  r = a | b;
            5'b001_01:  r = a & b;
            5'b001_11:  r = a ^ b;
            // shift
            5'b010_00:  r=sh; //shift left 
            5'b010_01:  r=sh; //shift right  
            5'b010_10:  r=sh; // arithmetic shift right
            // slt & sltu
            5'b011_01:  r = {31'b0,(sf != vf)}; 
            5'b011_11:  r = {31'b0,(~cf)}; 
            //MUL
            5'b00010:   r=$signed(a)*$signed(b);
            //MULH        
            5'b00011:   r=$signed(a)*$signed(b);
            //MULHSU      
            5'b00110:   r=$signed(a)*$unsigned(b);
            //MULHU     
            5'b01011:   r=$unsigned(a)*$unsigned(b);
            //DIV       
            5'b01100:   r=$signed(a)/$signed(b);
            //DIVU       
            5'b10000:   r=$unsigned(a)/$unsigned(b);
            //REM      
            5'b10001:   r=$signed(a)% $signed(b);
            //REMU      
            5'b10010:  r=$unsigned(a)% $unsigned(b);               	
        endcase
    end
endmodule
