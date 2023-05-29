`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2022 02:57:14 PM
// Design Name: 
// Module Name: Single_Cycle
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


module Single_Cycle(input clk, input rst);
 wire RegWrite,MemRead,MemWrite,cout, ALUSrc, branch, MemtoReg , jalr, auipc, jal, lui, isnot_halt;
 
 wire [31:0] Pc_in, Pc_out, Instruction, 
 writeData ,readData1 , readData2 , 
  pc_adder_ou,tar_adder_ou, ALU_in, ALU_in1, ALU_OUT, 
  data_out , imm_out ,mux_ou, mux_ou1;
  
wire [3:0] ALUSelection;
wire [1:0] ALUOp;
 
 
register PC (clk, rst, isnot_halt, Pc_in ,Pc_out );
Ripple_Carry_Adder normal_adder (32'd4,Pc_out,1'b0, pc_adder_ou,cout);
Ripple_Carry_Adder tar_adder (imm_out,Pc_out,1'b0, tar_adder_ou,cout);
Mux32_3inputs new_pc (pc_adder_ou,tar_adder_ou,ALU_OUT, {jalr,isb_ou}, Pc_in);
InstMem instruction_memory (Pc_out[7:2],Instruction);

nbit2by1mux mux2 (data_out,ALU_OUT, MemtoReg,mux_ou);
Mux32_3inputs M321 (mux_ou,tar_adder_ou,pc_adder_ou, {jalr,auipc}, mux_ou1);
nbit2by1mux mux4 (imm_out, mux_ou1, lui, writeData);
RegisterFile register_file(clk ,rst ,RegWrite ,Instruction [19:15] , Instruction [24:20], Instruction [11:7], writeData ,readData1 , readData2);
nbit2by1mux mux3 (Pc_out, readData1, jal, ALU_in1);
rv32_ImmGen  immed(Instruction,imm_out);
nbit2by1mux mux1 (imm_out,readData2, ALUSrc, ALU_in);


DataMem data_memory ( clk, MemRead, MemWrite, ALU_OUT[7:2], readData2, Instruction[14:12] , data_out);
prv32_ALU alu (ALU_in1, ALU_in,Instruction [24:20], ALUSrc,ALU_OUT, carry_f, zero_f, overflow_f, sign_f, ALUSelection);
ALUcontrolunit ALUcontrol(Instruction , ALUOp ,ALUSelection);
ControlUnit CU(Instruction [6:2], Instruction[20], branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, jalr, auipc, jal, lui, isnot_halt, ALUOp); //Instruction [20] is added to detect EBREAK


isbranch isb (branch,  zero_f,  sign_f,  carry_f,  overflow_f, Instruction [14:12], isb_ou);

endmodule
