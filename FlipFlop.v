`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2022 03:12:09 PM
// Design Name: 
// Module Name: FlipFlop
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

module FlipFlop(input clk, input rst, input D, output reg Q);
always @(posedge clk or posedge rst)
if (rst) begin 
Q <= 1'b0; end 
else begin 
Q<=D; 
end
endmodule