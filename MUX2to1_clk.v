`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 07:52:51 PM
// Design Name: 
// Module Name: MUX2to1_clk
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


module MUX2to1_clk(input A, input B, input load, input clk, output reg Q);

always @(posedge clk)
begin
Q=(load==1'b1)? A:B;
end
endmodule
