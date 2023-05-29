`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2022 07:56:00 PM
// Design Name: 
// Module Name: RISCV_pipelined
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


module RISCV_pipelined(input clk, input rst);
 wire RegWrite,MemRead,MemWrite,cout, ALUSrc, branch, MemtoReg , jalr, auipc, jal, lui, isnot_halt,isb_ou, 
 branch_final, MemtoReg_final, MemRead_final, MemWrite_final, ALUSrc_final, RegWrite_final, jalr_final, auipc_final, jal_final, lui_final, isnot_halt_final, 
 ID_EX_branch_final, ID_EX_MemtoReg_final, ID_EX_MemRead_final, ID_EX_MemWrite_final, ID_EX_RegWrite_final, ID_EX_jalr_final, ID_EX_auipc_final, ID_EX_lui_final;
 
wire [31:0] Pc_in, Pc_out, Instruction, 
writeData ,readData1 , readData2 , 
 pc_adder_ou,tar_adder_ou, ALU_in2, ALU_in1, ALU_OUT, 
 data_out , imm_out ,mux_ou, mux_ou1;
wire [4:0] ALUSelection;//////////bonus make it 5 instead of 4
wire [1:0] ALUOp, ALUOp_final;
wire [31:0] IF_ID_PC, IF_ID_Inst ,IF_ID_PC_Adder_Out;
wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm,ID_EX_PC_Adder_Out;
wire ID_EX_branch, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite, ID_EX_jalr, ID_EX_auipc, ID_EX_jal, ID_EX_lui, ID_EX_isnot_halt;
wire [1:0] ID_EX_ALUOp;
wire [31:0] ID_EX_Func;
wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;
wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2,EX_MEM_PC_Adder_Out ,EX_MEM_Imm;
wire EX_MEM_branch, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_jalr, EX_MEM_auipc, EX_MEM_jal, EX_MEM_lui, EX_MEM_isnot_halt;
wire MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_jalr, MEM_WB_auipc, MEM_WB_jal, MEM_WB_lui;
wire [31:0] MEM_WB_PC_Adder_Out, MEM_WB_BranchAddOut,MEM_WB_Imm;
wire [4:0] EX_MEM_Rd, MEM_WB_Rd;
wire EX_MEM_carry_f, EX_MEM_zero_f, EX_MEM_overflow_f, EX_MEM_sign_f;
wire[2:0]EX_MEM_Func1214;
wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out ,ForwardA_out,ForwardB_out, chosen_Inst;
wire ForwardA , ForwardB;
wire carry_f, zero_f, overflow_f, sign_f;
wire [23:0] zeros_EXflush;
wire [18:0] zeros_IDflush;
//wire ID_EX_isnot_halt, EX_MEM_isnot_halt, MEM_WB_isnot_halt;

//stage IF
register PC (clk, rst, isnot_halt_final, Pc_in ,Pc_out );
Memory singleMem (~clk, EX_MEM_MemRead,  EX_MEM_MemWrite,  Pc_out[7:2],  EX_MEM_ALU_out[7:2],
EX_MEM_RegR2, EX_MEM_Func1214, data_out ,Instruction);

Ripple_Carry_Adder normal_adder (32'd4,Pc_out,1'b0, pc_adder_ou,cout);
nbit2by1mux IFflush (32'h00000033, Instruction, isb_ou, chosen_Inst);

register #(96) IF_ID (~clk,rst,1'b1, {Pc_out ,chosen_Inst ,pc_adder_ou}, {IF_ID_PC, IF_ID_Inst, IF_ID_PC_Adder_Out } );
Mux32_3inputs new_pc (pc_adder_ou, EX_MEM_BranchAddOut, EX_MEM_ALU_out, {EX_MEM_jalr,isb_ou}, Pc_in); ///////////////////////////////////////////////
//stage ID
ControlUnit CU(IF_ID_Inst[6:2], IF_ID_Inst[20], branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, jalr, auipc, jal, lui, isnot_halt, ALUOp);

nbit2by1mux IDflush (32'd4, {19'd0, branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, jalr, auipc, jal, lui, isnot_halt, ALUOp}, isb_ou,
 {zeros_IDflush, branch_final, MemtoReg_final, MemRead_final, MemWrite_final, ALUSrc_final, RegWrite_final, jalr_final, auipc_final, jal_final, lui_final, isnot_halt_final,
  ALUOp_final});   

RegisterFile register_file(~clk ,rst ,MEM_WB_RegWrite ,IF_ID_Inst [19:15] , IF_ID_Inst[24:20], MEM_WB_Rd, writeData ,readData1 , readData2);
rv32_ImmGen  immed(IF_ID_Inst,imm_out);
register #(220) ID_EX (clk,rst,1'b1,{branch_final, MemtoReg_final, MemRead_final, MemWrite_final, ALUSrc, RegWrite_final, jalr_final, auipc_final, jal_final, lui_final, isnot_halt_final, ALUOp_final, IF_ID_PC, readData1, readData2,imm_out,IF_ID_Inst,IF_ID_Inst[19:15],IF_ID_Inst[24:20],IF_ID_Inst[11:7],IF_ID_PC_Adder_Out},
 {ID_EX_branch, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite, ID_EX_jalr, ID_EX_auipc, ID_EX_jal, ID_EX_lui, ID_EX_isnot_halt, ID_EX_ALUOp, ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd,ID_EX_PC_Adder_Out} );
/////////////////////////////////////////ALUSRC is now here instead of ALUSRC_final
//stage EX


Forwarding_Unit RAW(ID_EX_Rs1,ID_EX_Rs2, MEM_WB_Rd,MEM_WB_RegWrite, ForwardA , ForwardB);
nbit2by1mux ForA ( writeData,ID_EX_RegR1, ForwardA,ForwardA_out);
nbit2by1mux ForB (writeData,ID_EX_RegR2,  ForwardB,ForwardB_out);

Ripple_Carry_Adder tar_adder (ID_EX_Imm,ID_EX_PC,1'b0, tar_adder_ou,cout);
nbit2by1mux mux3 (ID_EX_PC,ForwardA_out,ID_EX_jal||ID_EX_auipc, ALU_in1);
nbit2by1mux mux1 (ID_EX_Imm,ForwardB_out,ID_EX_ALUSrc, ALU_in2);
ALUcontrolunit ALUcontrol( ID_EX_Func ,ID_EX_ALUOp ,ALUSelection);
prv32_ALU alu (ALU_in1, ALU_in2,ID_EX_Func [24:20], ID_EX_ALUSrc,ALU_OUT, carry_f, zero_f, overflow_f, sign_f, ALUSelection);

nbit2by1mux EXflush (32'd0, {24'd0, ID_EX_branch, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite,ID_EX_RegWrite, ID_EX_jalr, 
ID_EX_auipc, ID_EX_lui}, isb_ou,
{zeros_EXflush, ID_EX_branch_final, ID_EX_MemtoReg_final, ID_EX_MemRead_final, ID_EX_MemWrite_final, ID_EX_RegWrite_final, ID_EX_jalr_final, ID_EX_auipc_final, ID_EX_lui_final});   

register #(180) EX_MEM (~clk,rst,1'b1,{ID_EX_branch_final, ID_EX_MemtoReg_final, ID_EX_MemRead_final, ID_EX_MemWrite_final, ID_EX_RegWrite_final, ID_EX_jalr_final, ID_EX_auipc_final, ID_EX_lui_final
,tar_adder_ou,carry_f, zero_f, overflow_f, sign_f,ALU_OUT, ForwardB_out, ID_EX_Rd,ID_EX_Func[14:12],ID_EX_PC_Adder_Out,ID_EX_Imm},
 {EX_MEM_branch, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_jalr, EX_MEM_auipc, 
 EX_MEM_lui, EX_MEM_BranchAddOut, EX_MEM_carry_f, EX_MEM_zero_f, EX_MEM_overflow_f, EX_MEM_sign_f, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd,EX_MEM_Func1214,EX_MEM_PC_Adder_Out,EX_MEM_Imm} ); 


 //stage MEM
 //Memory data (~clk,EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_ALU_out[7:2],EX_MEM_RegR2,EX_MEM_Func1214, data_out );
 
// isbranch isb (EX_MEM_branch,  EX_MEM_zero_f,  EX_MEM_sign_f, EX_MEM_carry_f, EX_MEM_overflow_f,EX_MEM_Func1214, isb_ou);//////////////////////////////////////////////
 isbranch isb (ID_EX_branch, zero_f,  sign_f, carry_f, overflow_f, ID_EX_Func[14:12], isb_ou); /////////////////////////
 
 register #(170) MEM_WB (clk,rst,1'b1,{EX_MEM_MemtoReg, EX_MEM_RegWrite, EX_MEM_jalr, EX_MEM_auipc, EX_MEM_lui, data_out,EX_MEM_ALU_out,EX_MEM_Rd,EX_MEM_PC_Adder_Out,EX_MEM_BranchAddOut,EX_MEM_Imm },
  {MEM_WB_MemtoReg,MEM_WB_RegWrite,MEM_WB_jalr, MEM_WB_auipc, MEM_WB_lui,MEM_WB_Mem_out, MEM_WB_ALU_out,MEM_WB_Rd,MEM_WB_PC_Adder_Out, MEM_WB_BranchAddOut,MEM_WB_Imm} );
 //stage WB
 nbit2by1mux mux2 (MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_MemtoReg,mux_ou);
 Mux32_3inputs M321 (mux_ou,MEM_WB_BranchAddOut,MEM_WB_PC_Adder_Out, {MEM_WB_jalr,MEM_WB_auipc}, mux_ou1);
 nbit2by1mux mux4 (MEM_WB_Imm, mux_ou1, MEM_WB_lui, writeData);
 
endmodule
