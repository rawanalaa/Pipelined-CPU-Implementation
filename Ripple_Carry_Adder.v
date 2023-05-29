`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2022 02:54:35 PM
// Design Name: 
// Module Name: Ripple_Carry_Adder
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


module Ripple_Carry_Adder(A,B,cin,sum,cout);
    input [31:0] A, B;
    input cin;
    output [31:0] sum;
    output cout;
    
    wire [31:0] out;
    
    FullAdder addz(.A(A[0]),.B(B[0]),.cin(cin),.sum(sum[0]),.cout(out[0]));
    
    genvar i;
    generate 
    for(i=1 ; i<32 ;i=i+1) begin
    FullAdder add(.A(A[i]),.B(B[i]),.cin(out[i-1]),.sum(sum[i]),.cout(out[i]));
    end
    endgenerate
    assign cout=out[31];
endmodule

