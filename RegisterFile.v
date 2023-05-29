`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2022 01:17:09 PM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(input clk ,rst ,RegWrite ,
input [4:0] readReg1 , readReg2 , writeReg ,
input [31:0] writeData ,
output [31:0] readData1 , readData2);

wire [31:0] Q[31:0];
reg [31:0] loads;

always@(*) begin 
if(RegWrite)
begin
loads=32'd0;
loads[writeReg] =1'b1;
end
else loads=32'd0;
 end
  register test0 ( clk, rst, 0, writeData , Q[0] );

genvar i;
generate 
 for(i=1;i<32;i=i+1) begin: loop1
 register test ( clk, rst, loads[i], writeData , Q[i] );
 end
endgenerate 


assign readData1=Q[readReg1];
assign readData2=Q[readReg2];
endmodule
