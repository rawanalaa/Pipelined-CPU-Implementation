`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2022 12:50:44 PM
// Design Name: 
// Module Name: nbit2by1mux
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


module nbit2by1mux #(parameter n=32)(input [n-1:0] A, input [n-1:0] B, input load, output [n-1:0] Q);
 genvar i;
generate 
for(i=0 ; i<n ;i=i+1) begin:f1
MUX2to1 mux(.A(A[i]),.B(B[i]),.load(load),.Q(Q[i]));
end
endgenerate 

endmodule
