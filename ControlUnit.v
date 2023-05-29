`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2022 04:38:31 PM
// Design Name: 
// Module Name: control_unit
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


module ControlUnit(
input [4:0] opcode, input Inst20,
output reg branch,
output reg MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, jalr, auipc, jal,lui, isnot_halt,
output reg [1:0] ALUOp
);

 
 always @ (*)
 
 begin
 
  case (opcode)
 
  5'b01100: 
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b10;
          MemWrite = 0;
          ALUSrc = 0;
          RegWrite = 1;
          jalr = 0;
	      auipc = 0;
	      jal = 0;
          lui=0;
          isnot_halt=1;
    end
  5'b00000: 
    begin
          branch = 0;
          MemRead = 1;
          MemtoReg = 1;
          ALUOp = 2'b00;
          MemWrite = 0;
          ALUSrc = 1;
          RegWrite = 1;
          jalr = 0;
	      auipc = 0;
	      jal = 0;
	      lui=0;
	      isnot_halt=1;
    end
  5'b01000:
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00;
          MemWrite = 1;
          ALUSrc = 1;
          RegWrite = 0;
          jalr = 0;
	      auipc = 0;
	      jal = 0;
	      lui=0;
	      isnot_halt=1;
    end
  5'b11000:
    begin
          branch = 1;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b01;
          MemWrite = 0;
          ALUSrc = 0;
          RegWrite = 0;
          jalr = 0;
	      auipc = 0;
	      jal = 0;
	      lui=0;
	      isnot_halt=1;
    end 
  5'b00101: //auipc
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00; // don't care
          MemWrite = 0;
          ALUSrc = 1; //don't care
          RegWrite = 1;
          jalr = 0;
	      auipc = 1;
	      jal = 0;
	      lui=0;
          isnot_halt=1;       
    end
  
  5'b01101: //lui
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00; //don't care bec shift is already done in immGen
          MemWrite = 0;
          ALUSrc = 1; //choose the immediate
          RegWrite = 1;
          jalr = 0;
	      auipc = 0;
	      jal = 0;
	      lui=1;
          isnot_halt=1;         
    end
  5'b11011: //jal
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00; //add
          MemWrite = 0;
          ALUSrc = 1; 
          RegWrite = 1;
          jalr = 1;  //because jal share with jalr everything except the mux in front of the ALU source 1
	      auipc = 0;
	      jal = 1;
          lui=0;   
          isnot_halt=1;          
    end  
  
   5'b11001: //jalr
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00; //do addition
          MemWrite = 0;
          ALUSrc = 1; //choose the immediate
          RegWrite = 1;
          jalr = 1;
	      auipc = 0;
	      jal = 0;
          lui=0; 
          isnot_halt=1;               
    end  
//00100

   5'b00100: //I-type
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b11; //I type aluop
          MemWrite = 0;
          ALUSrc = 1; //choose the immediate
          RegWrite = 1;
          jalr = 0;
	      auipc = 0;
	      jal = 0;
	      lui=0;
	      isnot_halt=1;
    end
   5'b11100: //EBREAK & ECall
    begin
      if (Inst20==1'b1) begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00; 
          MemWrite = 0;
          ALUSrc = 0; 
          RegWrite = 0;
          jalr = 0;
          auipc = 0;
          jal = 0;
          lui=0;
          isnot_halt=0;
          end
      else begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00;
          MemWrite = 0;
          ALUSrc = 0;
          RegWrite = 0;
          jalr = 0;
          auipc = 0;
          jal = 0;
          lui=0;
          isnot_halt=1;    
          end
    end  
   
   default:
    begin
          branch = 0;
          MemRead = 0;
          MemtoReg = 0;
          ALUOp = 2'b00;
          MemWrite = 0;
          ALUSrc = 0;
          RegWrite = 0;
          jalr = 0;
          auipc = 0;
          jal = 0;
          lui=0;
          isnot_halt=1;
     end

 endcase
   end
endmodule
