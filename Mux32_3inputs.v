`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2022 02:05:31 PM
// Design Name: 
// Module Name: Mux32_3inputs
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


module Mux32_3inputs(input [31:0] A, input [31:0] B, input [31:0] C, input [1:0] s, output reg [31:0] ou);

always@(*)
begin

    case (s)
    
        2'b00: ou = A;
        2'b01: ou = B;
        2'b10: ou = C;
    
    default: ou = 2'b00;
    endcase
end

endmodule
