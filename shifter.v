`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2022 10:26:06 AM
// Design Name: 
// Module Name: shifter
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


module shifter ( input [31:0] a, input [31:0] b, input [4:0] shamt, input ALUsrc, input [1:0] type, output reg [31:0] r);

always@(*) begin
    
    case(type)
    2'b00: begin
    if (ALUsrc==1)
    r = a << shamt;  //shift left immediate
    else
    r = a << b;   //shift left
    end
    2'b01: begin
    if (ALUsrc==1)
    r = a >> shamt;  //shift right immediate
    else
    r = a >> b;  //shift right
    end
    2'b10: begin 
    if (ALUsrc==1)
    r = $signed(a) >>> shamt; //arithmetic shift right immediate
    else 
    r = $signed(a) >>> b; //arithmetic shift right
    end
    endcase
end
endmodule
