`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 07:50:16 PM
// Design Name: 
// Module Name: nbit2by1mux_clk
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


module nbit2by1mux_clk#(parameter n=32)(input [n-1:0] A, input [n-1:0] B, input clk, input load, output [n-1:0] Q);
 genvar i;
generate 
for(i=0 ; i<n ;i=i+1) begin:f1
MUX2to1_clk mux(A[i],B[i],load,clk,Q[i]);
end
endgenerate 
endmodule
