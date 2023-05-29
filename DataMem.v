`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 12:12:39 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem(input clk, input MemRead, input MemWrite, input [5:0] addr, input [31:0] data_in, input [2:0] inst1214, output reg [31:0] data_out);
 reg [7:0] mem [0:255];
//assign data_out = MemRead ? mem[addr] : 32'd0; 
always @(*)
if (MemRead) begin
case (inst1214)
3'b010: begin //lw
data_out [7:0]  = mem [addr*4];
data_out [15:8]  = mem [(addr*4)+1];
data_out [23:16]  = mem [(addr*4)+2];
data_out [31:24]  = mem [(addr*4)+3];
end
3'b001: begin  //lh
data_out [7:0]  = mem [addr*4];
data_out [15:8]  = mem [(addr*4)+1];
data_out [31:16]  = {16{data_out[15]}};
end
3'b101: begin  //lhu
data_out [7:0]  = mem [addr*4];
data_out [15:8]  = mem [(addr*4)+1];
data_out [31:16]  = 16'd0;
end
3'b000: begin  //lb
data_out [7:0]  = mem [addr*4];
data_out [31:8]  = {24{data_out[7]}};
end
3'b100: begin  //lbu
data_out [7:0]  = mem [addr*4];
data_out [31:8]  = 24'd0;
end
endcase
end
else
data_out = 32'd0;

always @(posedge clk) begin
if(MemWrite)begin
//mem[addr]=data_in;
case (inst1214)
3'b010: begin//sw
mem [addr*4]=     data_in[7:0];
mem [(addr*4)+1]= data_in[15:8];
mem [(addr*4)+2]= data_in[23:16];
mem [(addr*4)+3]= data_in[31:24];
end
3'b001: begin//sh
mem [addr*4]= data_in[7:0];
mem [(addr*4)+1]= data_in[15:8];
end
3'b000: begin//sb
mem [addr*4]= data_in[7:0];
end
endcase
end
end

initial begin
 mem[0]=8'd17;
 mem[1]=8'd0;
 mem[2]=8'd0;
 mem[3]=8'd0;
 mem[4]=8'd9;
 mem[5]=8'd0;
 mem[6]=8'd0;
 mem[7]=8'd0;
 mem[8]=8'd25;
 mem[9]=8'd0;
 mem[10]=8'd0;
 mem[11]=8'd0;
 end 

endmodule
