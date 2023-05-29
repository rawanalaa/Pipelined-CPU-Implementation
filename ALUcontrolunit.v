`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2022 03:56:23 PM
// Design Name: 
// Module Name: ALUcontrolunit
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


module ALUcontrolunit(input [31:0] inst , input [1:0]ALUOp ,output reg [4:0] ALUSelection);
always @(*)begin
case(ALUOp)
2'b00: ALUSelection =5'b000_00;

2'b01: ALUSelection =5'b000_01;

2'b10:begin
if (inst[31:25]==7'd1)   ////////bonus
begin
case(inst[14:12])
3'b000: ALUSelection= 5'b00010;     //MUL
3'b001: ALUSelection= 5'b00011;     //MULH
3'b010: ALUSelection= 5'b00110;     //MULHSU
3'b011: ALUSelection= 5'b01011;     //MULHU
3'b100: ALUSelection= 5'b01100;     //DIV
3'b101: ALUSelection= 5'b10000;     //DIVU
3'b110: ALUSelection= 5'b10001;     //REM
3'b111: ALUSelection= 5'b10010;     //REMU
endcase
end    ///end of bonus
else
begin
if(inst[14:12]==3'b000)   
if(inst[30]==1'b0) ALUSelection =4'b000_00; //add
else  ALUSelection =5'b000_01; //sub

else if(inst[14:12]==3'b111 && inst[30]==1'b0) 
ALUSelection =5'b001_01; // and
else if(inst[14:12]==3'b110 && inst[30]==1'b0)  
ALUSelection =5'b001_00; // or
else if (inst[14:12] ==3'b001)
ALUSelection = 5'b010_00; //sll
else if (inst[14:12] ==3'b010)
ALUSelection = 5'b011_01; //slt
else if (inst[14:12] ==3'b011)
ALUSelection = 5'b011_11; //sltu
else if (inst[14:12] ==3'b100)
ALUSelection = 5'b001_11; //xor
else if (inst[14:12] ==3'b101 && inst[30]==1'b0)
ALUSelection = 5'b010_01; //srl
else if (inst[14:12] ==3'b101 && inst[30]==1'b1)
ALUSelection = 5'b010_10; // sra

end
end

2'b11:begin

	case(inst[14:12])
	3'b000: ALUSelection =5'b000_00; //addi
	3'b010: ALUSelection =5'b011_01; //slti
	3'b011: ALUSelection =5'b011_11; //sltu
	3'b100: ALUSelection =5'b001_11; //xori
	3'b110: ALUSelection =5'b001_00; //ori
	3'b111: ALUSelection =5'b001_01; //andi
	3'b001: ALUSelection =5'b010_00; //slli
	3'b101: begin
	if (inst[30]==1'b0)
	ALUSelection =4'b010_01; //srli
	else
	ALUSelection =4'b10_10; //srai
	end
	endcase
end
endcase
end
endmodule
