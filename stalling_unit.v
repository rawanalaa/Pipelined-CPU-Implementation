`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2022 02:43:33 PM
// Design Name: 
// Module Name: stalling_unit
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


module stalling_unit(
input [4:0] IF_ID_Rs1,IF_ID_Rs2, ID_EX_Rd,input ID_EX_MemRead ,output reg stall
    );
    
always@(*) begin
if ( ((IF_ID_Rs1==ID_EX_Rd) || (IF_ID_Rs2==ID_EX_Rd) ) &&(ID_EX_MemRead && (ID_EX_Rd != 5'd0 )))
stall=1'b1;
else
stall =1'b0;
end
    
endmodule
