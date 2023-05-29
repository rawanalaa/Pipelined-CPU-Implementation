`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2022 03:05:24 PM
// Design Name: 
// Module Name: InstMem
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

module InstMem (input [5:0] addr, output [31:0] data_out);
reg [31:0] mem [0:63];
integer i;

assign data_out = mem[addr];
initial begin

// test case 0
mem[0]=32'h00000073 ; //ECALL
mem[1]=32'h00100073; //EBREAK
mem[2]=32'h0000000F; //FENCE
mem[3]=32'h00400293;//ADDI x5,x0,4  x5=4

//test Case 1
 /*mem[0]=32'h00400293;//ADDI x5,x0,4  x5=4
 mem[1]=32'hFFA00313; //ADDI x6,x0, -6  x6=-6
 mem[2]=32'h0062A3B3; //SLT x7,x5,x6  x7=0
 mem[3]=32'h0062BE33; //SLTU x28,x5,x6 x28=1
 mem[4]=32'h00529EB3; //SLL x29,x5,x5 x29=64
 mem[5]=32'h00100213; // ADDI x4, x0, 1 x4=1
 mem[6]=32'h0042DF33; //SRL x30,x5,x4 x30=2
 mem[7]=32'h40435FB3; //SRA x31,x6,x4 x31=-3
 mem[8]=32'hFFF34313; //XORI x6,x6,-1 x6=5
 mem[9]=32'h00536293; //ORI x5,x6,5  x5=5
 mem[10]=32'h0092F393; //ANDI x7,x5,9  x7=1
 mem[11]=32'hFFF3AE13; //SLTI x28,x7,-1  x28=0
 mem[12]=32'h0023DE93; //SRLI x29,x7,2   x29=0
 mem[13]=32'h4023DF13; //SRAI x30,x7,2  x30=0 */
  
  //test Case 2
   /*mem[0]=32'h01400113;//ADDI x2,x0,20  x2=20
   mem[1]=32'h3E800513; //ADDI x10,x0,1000  x10=1000
   mem[2]=32'h00800593; //ADDI x11,x0,8  x11=8
   mem[3]=32'h01C000EF; //jal x1 28  //x1=pc+4 //Pc_in = Pc_out+(28*2)
   mem[4]=32'h00050433; //add x8 x10 x0 // x8=1000
   mem[5]=32'h40B402B3; //SUB x5,x8,x11 
   mem[6]=32'h00547333; //AND x6,x8,x5
   mem[7]=32'h005463B3; //OR x7,x8,x5
   mem[8]=32'h00734E33; //XOR x28,x6,x7
   mem[9]=32'h00000493; //ADDI x9,x0,0 //x9=0
   mem[10]=32'hFFC10113; //ADDI x2,x2,-4
   mem[11]=32'h00000913;  //ADDI x18,x0,0
   mem[12]=32'h02B90063 ; //beq x18 x11 32 
   mem[13]=32'h00291993 ; //slli x19 x18 2
   mem[14]=32'h01350A33 ; //add x20 x10 x19
   mem[15]=32'h009AC863; //blt x21 x9 16
   mem[16]=32'h000A8493 ; //ADDI x9,x21,0
   mem[17]=32'h00190913 ; //ADDI x18,x18,1
   mem[18]=32'hFE0002E3 ; //beq x0 x0 -28     
   mem[19]=32'h00048513 ; //ADDI x10,x9,0            
   mem[20]=32'h00410113 ; //ADDI x2,x2,4         
   mem[21]=32'h00008067 ; //JALR x0,0(x1) */
    
    
    //test Case 3
       /*mem[0]=32'h00F00293;//ADDI x5,x0,15    x5=15
       mem[1]=32'h00500313; //ADDI x6,x0,5    x6=5
       mem[2]=32'h006283B3; //ADD x7,x5,x6    x7=20
       mem[3]=32'h40628E33; //SUB x28,x5,x6   x28=10
       mem[4]=32'h0062FEB3; //AND x29,x5,x6   x29=5
       mem[5]=32'h0062EF33; //OR x30,x5,x6    x30=15
       mem[6]=32'h0062CFB3; //XOR x31,x5,x6   x31=10
       mem[7]=32'hFFFF4393; //XORI x7,x30,-1  x7=-16
       mem[8]=32'hFEC3F293; //ANDI x5,x7,-20  x5=-32
       mem[9]=32'h3E836313; //ORI x6,x6,1000  x6=1005
       mem[10]=32'h01A00F93; //ADDI x31,x0,26 x31=26
       mem[11]=32'h0000EA17 ; //AUIPC x20,14 x20=57404
       mem[12]=32'h00009AB7 ; //LUI x21,9  x21=36864
       mem[13]=32'h00700293 ; //ADDI x5,x0,7
       mem[14]=32'hFF72B313 ; //SLTIU x6,x5,-9
       mem[15]=32'h00031463 ; //bne x6 x0 8
       mem[16]=32'h0062D463 ; //bge x5 x6 8
       mem[17]=32'hFE536EE3 ; //bltu x6 x5 -4
       mem[18]=32'h0062F463 ; //bgeu x5 x6 8
       mem[19]=32'h00A00393 ; //ADDI x7,x0,10
       mem[20]=32'h00B00393 ; //ADDI x7,x0,11 */
   // test case 4
   /*mem[0]=32'h00200113 ; //addi x2, x0, 2
   mem[1]=32'h00300093 ; //addi x1, x0, 3
   mem[2]=32'h00112023 ; //sw x1, 0(x2)
   mem[3]=32'h00012183 ; //lw x3, 0(x2)
   mem[4]=32'h00400093 ; //addi x1, x0, 4
   mem[5]=32'h00111023 ; // sh x1, 0(x2)
   mem[6]=32'h00011183 ;//lh x3, 0(x2)
   mem[6]=32'hFFFFF0B7 ; //lui x1,1048575
   mem[7]=32'h40008093 ; //addi x1, x1, 1024 
   mem[8]=32'h00110023 ;  //sb x1, 0(x2)
   mem[9]=32'h00010183 ; //lb x3, 0(x2)*/

 end 
endmodule
