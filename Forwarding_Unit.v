`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2022 12:48:00 PM
// Design Name: 
// Module Name: Forwarding_Unit
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

// remove EX_MEM_Rd and its regwrite: is already solved
module Forwarding_Unit(
input [4:0] ID_EX_Rs1,ID_EX_Rs2, MEM_WB_Rd,
input MEM_WB_RegWrite, output reg ForwardA , ForwardB
    );
    
always@(*)begin
if(MEM_WB_RegWrite &&(MEM_WB_Rd!=5'd0)&&(MEM_WB_Rd==ID_EX_Rs1))
ForwardA = 2'b1;
else 
ForwardA = 2'b0;
if(MEM_WB_RegWrite &&(MEM_WB_Rd!=5'd0)&&(MEM_WB_Rd==ID_EX_Rs2))
ForwardB = 2'b1;
else
ForwardB = 2'b0;
end
endmodule
