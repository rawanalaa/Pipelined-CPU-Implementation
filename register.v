`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2022 02:59:37 PM
// Design Name: 
// Module Name: register
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


module  register #(parameter n=32) (input clk, input rst, input load, input [n-1:0] D , output [n-1:0] Q );
 wire [n-1:0] DM;
 genvar i;
generate 
 for(i=0 ; i<n ;i=i+1) begin:dflip
 MUX2to1 mux(.A(D[i]),.B(Q[i]),.load(load),.Q(DM[i]));
 FlipFlop FF (.clk(clk), .rst(rst), .D(DM[i]), .Q(Q[i]));
 end
endgenerate 

endmodule
