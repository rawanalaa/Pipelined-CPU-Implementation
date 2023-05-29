
module Memory (input clk,input MemRead, input MemWrite, input [5:0] insta_addr, input [5:0] data_addr,
input [31:0] data_in, input [2:0] inst1214, output reg [31:0]  data_out ,output reg [31:0] Instruction);

parameter memSize=1024;
parameter offset=memSize/2;
reg [7:0] mem [0:memSize];





//data memory

always @(*)
if (MemRead) begin
case (inst1214)
3'b010: begin //lw
data_out [7:0]  = mem [(data_addr*4)+offset];
data_out [15:8]  = mem [(data_addr*4)+offset+1];
data_out [23:16]  = mem [(data_addr*4)+offset+2];
data_out [31:24]  = mem [(data_addr*4)+offset+3];
end
3'b001: begin  //lh
data_out [7:0]  = mem [(data_addr*4)+offset];
data_out [15:8]  = mem [(data_addr*4)+offset+1];
data_out [31:16]  = {16{data_out[15]}};
end
3'b101: begin  //lhu
data_out [7:0]  = mem [(data_addr*4)+offset];
data_out [15:8]  = mem [(data_addr*4)+offset+1];
data_out [31:16]  = 16'd0;
end
3'b000: begin  //lb
data_out [7:0]  = mem [(data_addr*4)+offset];
data_out [31:8]  = {24{data_out[7]}};
end
3'b100: begin  //lbu
data_out [7:0]  = mem [(data_addr*4)+offset];
data_out [31:8]  = 24'd0;
end
default: data_out = 32'd0;

endcase
end
else 
//data_out = 32'd0; 
begin
Instruction[7:0] = mem[insta_addr*4];
Instruction[15:8] = mem[(insta_addr*4)+1];
Instruction[23:16] = mem[(insta_addr*4)+2];
Instruction[31:24] = mem[(insta_addr*4)+3];
end

always @(posedge clk) begin
if(MemWrite)begin
case (inst1214)
3'b010: begin//sw
mem [(data_addr*4)+32]= data_in[7:0];
mem [(data_addr*4)+32+1]= data_in[15:8];
mem [(data_addr*4)+32+2]= data_in[23:16];
mem [(data_addr*4)+32+3]= data_in[31:24];
end
3'b001: begin//sh
mem [(data_addr*4)+32]= data_in[7:0];
mem [(data_addr*4)+32+1]= data_in[15:8];
end
3'b000: begin//sb
mem [(data_addr*4)+32]= data_in[7:0];
end
endcase
end
end




initial begin

//////Test case 0

////32'h00000073 ; //ECALL
//{mem[3], mem[2], mem[1], mem[0]} = 32'h00000073;
////32'h00100073; //EBREAK
//{mem[7], mem[6], mem[5], mem[4]} = 32'h00100073;
////32'h0000000F; //FENCE
//{mem[11], mem[10], mem[9], mem[8]} = 32'h0000000F;

//////Test case 1
////32'h00000033; //add x0, x0, x0
//{mem[3], mem[2], mem[1], mem[0]} = 32'h00000033;
////32'h00400293;//ADDI x5,x0,4           x5=4
//{mem[7], mem[6], mem[5], mem[4]} = 32'h00400293;
////32'hFFA00313; //ADDI x6,x0, -6      x6=-6
//{mem[11], mem[10], mem[9], mem[8]} = 32'hFFA00313;
////32'h0062A3B3; //SLT x7,x5,x6         x7=0
//{mem[15], mem[14], mem[13], mem[12]} = 32'h0062A3B3;
////32'h0062BE33; //SLTU x28,x5,x6     x28=1
//{mem[19], mem[18], mem[17], mem[16]} = 32'h0062BE33;
////32'h00529EB3; //SLL x29,x5,x5       x29=64
//{mem[23], mem[22], mem[21], mem[20]} = 32'h00529EB3;
////32'h00100213; // ADDI x4, x0, 1      x4=1
//{mem[27], mem[26], mem[25], mem[24]} = 32'h00100213;
////32'h0042DF33; //SRL x30,x5,x4      x30=2
//{mem[31], mem[30], mem[29], mem[28]} = 32'h0042DF33;
////32'h40435FB3; //SRA x31,x6,x4      x31=-3
//{mem[35], mem[34], mem[33], mem[32]} = 32'h40435FB3;
////32'hFFF34313; //XORI x6,x6,-1       x6=5
//{mem[39], mem[38], mem[37], mem[36]} = 32'hFFF34313;
////32'h00536293; //ORI x5,x6,5            x5=5
//{mem[43], mem[42], mem[41], mem[40]} = 32'h00536293;
////32'h0092F393; //ANDI x7,x5,9       x7=1
//{mem[47], mem[46], mem[45], mem[44]} = 32'h0092F393;
////32'hFFF3AE13; //SLTI x28,x7,-1    x28=0
//{mem[51], mem[50], mem[49], mem[48]} = 32'hFFF3AE13;
////32'h0023DE93; //SRLI x29,x7,2     x29=0
//{mem[55], mem[54], mem[53], mem[52]} = 32'h0023DE93;
////32'h4023DF13; //SRAI x30,x7,2    x30=0
//{mem[59], mem[58], mem[57], mem[56]} = 32'h4023DF13;


//////Test case 2

////32'h01400113;//ADDI x2,x0,20                 x2=20
//{mem[68], mem[69], mem[70], mem[71]} = 32'h01400113;
////32'h3E800513; //ADDI x10,x0,1000         x10=1000
//{mem[72], mem[73], mem[74], mem[75]} = 32'h3E800513;
////32'h00800593; //ADDI x11,x0,8  x11=8
//{mem[76], mem[77], mem[78], mem[79]} = 32'h00800593;
////32'h01C000EF; //jal x1 28  //x1=pc+4 //Pc_in = Pc_out+(28*2)
//{mem[80], mem[81], mem[82], mem[83]} = 32'h01C000EF;
////32'h00050433; //add x8 x10 x0 // x8=1000
//{mem[84], mem[85], mem[86], mem[87]} = 32'h00050433;
////32'h40B402B3; //SUB x5,x8,x11
//{mem[88], mem[89], mem[90], mem[91]} = 32'h40B402B3;
////32'h00547333; //AND x6,x8,x5
//{mem[92], mem[93], mem[94], mem[95]} = 32'h00547333;
////32'h005463B3; //OR x7,x8,x5
//{mem[96], mem[97], mem[98], mem[99]} = 32'h005463B3;
////32'h00734E33; //XOR x28,x6,x7
//{mem[100], mem[101], mem[102], mem[103]} = 32'h00734E33;
////32'h00000493; //ADDI x9,x0,0 //x9=0
//{mem[104], mem[105], mem[106], mem[107]} = 32'h00000493;
////32'hFFC10113; //ADDI x2,x2,-4
//{mem[108], mem[109], mem[110], mem[111]} = 32'hFFC10113;
////32'h00000913;  //ADDI x18,x0,0
//{mem[112], mem[113], mem[114], mem[115]} = 32'h00000913;
////32'h02B90063 ; //beq x18 x11 32
//{mem[116], mem[117], mem[118], mem[119]} = 32'h02B90063;
////32'h00291993 ; //slli x19 x18 2
//{mem[120], mem[121], mem[122], mem[123]} = 32'h00291993;
////32'h01350A33 ; //add x20 x10 x19
//{mem[124], mem[125], mem[126], mem[127]} = 32'h01350A33;
////32'h009AC863; //blt x21 x9 16
//{mem[128], mem[129], mem[130], mem[131]} = 32'h009AC863;
////32'h000A8493 ; //ADDI x9,x21,0
//{mem[132], mem[133], mem[134], mem[135]} = 32'h000A8493;
////32'h00190913 ; //ADDI x18,x18,1
//{mem[136], mem[137], mem[138], mem[139]} = 32'h00190913;
////32'hFE0002E3 ; //beq x0 x0 -28
//{mem[140], mem[141], mem[142], mem[143]} = 32'hFE0002E3;
////32'h00048513 ; //ADDI x10,x9,0 
//{mem[144], mem[145], mem[146], mem[147]} = 32'h00048513;
////32'h00410113 ; //ADDI x2,x2,4
//{mem[148], mem[149], mem[150], mem[151]} = 32'h00410113;
////32'h00008067 ; //JALR x0,0(x1)
//{mem[152], mem[153], mem[154], mem[155]} = 32'h00008067;


//////Test case 3

////32'h00000033; //add x0, x0, x0
//{mem[3], mem[2], mem[1], mem[0]} = 32'h00000033;
////32'h00F00293;//ADDI x5,x0,15    x5=15
//{mem[7], mem[6], mem[5], mem[4]} = 32'h00F00293;
////32'h00500313; //ADDI x6,x0,5    x6=5
//{mem[11], mem[10], mem[9], mem[8]} = 32'h00500313;
////32'h006283B3; //ADD x7,x5,x6    x7=20
//{mem[15], mem[14], mem[13], mem[12]} = 32'h006283B3;
////32'h40628E33; //SUB x28,x5,x6   x28=10
//{mem[19], mem[18], mem[17], mem[16]} = 32'h40628E33;
////32'h0062FEB3; //AND x29,x5,x6   x29=5
//{mem[23], mem[22], mem[21], mem[20]} = 32'h0062FEB3;
////32'h0062EF33; //OR x30,x5,x6    x30=15
//{mem[27], mem[26], mem[25], mem[24]} = 32'h0062EF33;
////32'h0062CFB3; //XOR x31,x5,x6   x31=10
//{mem[31], mem[30], mem[29], mem[28]} = 32'h0062CFB3;
////32'hFFFF4393; //XORI x7,x30,-1  x7=-16
//{mem[35], mem[34], mem[33], mem[32]} = 32'hFFFF4393;
////32'hFEC3F293; //ANDI x5,x7,-20  x5=-32
//{mem[39], mem[38], mem[37], mem[36]} = 32'hFEC3F293;
////32'h3E836313; //ORI x6,x6,1000  x6=1005
//{mem[43], mem[42], mem[41], mem[40]} = 32'h3E836313;
////32'h01A00F93; //ADDI x31,x0,26 x31=26
//{mem[47], mem[46], mem[45], mem[44]} = 32'h01A00F93;
////32'h0000EA17 ; //AUIPC x20,14 x20=57344
//{mem[51], mem[50], mem[49], mem[48]} = 32'h0000EA17;
////32'h00009AB7 ; //LUI x21,9  x21=36864
//{mem[55], mem[54], mem[53], mem[52]} = 32'h00009AB7;
////32'h00700293 ; //ADDI x5,x0,7
//{mem[59], mem[58], mem[57], mem[56]} = 32'h00700293;
////32'hFF72B313 ; //SLTIU x6,x5,-9
//{mem[63], mem[62], mem[61], mem[60]} = 32'hFF72B313;
////32'h00031463 ; //bne x6 x0 8
//{mem[67], mem[66], mem[65], mem[64]} = 32'h00031463;
////32'h0062D463 ; //bge x5 x6 8
//{mem[71], mem[70], mem[69], mem[68]} = 32'h0062D463;
////32'hFE536EE3 ; //bltu x6 x5 -4
//{mem[75], mem[74], mem[73], mem[72]} = 32'hFE536EE3;
////32'h0062F463 ; //bgeu x5 x6 8
//{mem[79], mem[78], mem[77], mem[76]} = 32'h0062F463;
////32'h00A00393 ; //ADDI x7,x0,10
//{mem[83], mem[82], mem[81], mem[80]} = 32'h00A00393;
////32'h00B00393 ; //ADDI x7,x0,11
//{mem[87], mem[86], mem[85], mem[84]} = 32'h00B00393;
////32'h00100073; //EBREAK
//{mem[91], mem[90], mem[89], mem[88]} = 32'h00100073;

{mem[3], mem[2], mem[1], mem[0]} = 32'h13;
{mem[7], mem[6], mem[5], mem[4]} = 32'h3e700013;
{mem[11], mem[10], mem[9], mem[8]} = 32'h00100093;
{mem[15], mem[14], mem[13], mem[12]} = 32'h00200113;
{mem[19], mem[18], mem[17], mem[16]} = 32'h00300193;
{mem[23], mem[22], mem[21], mem[20]} = 32'h00400213;
{mem[27], mem[26], mem[25], mem[24]} = 32'h00500293;
{mem[31], mem[30], mem[29], mem[28]} = 32'h00600313;
{mem[35], mem[34], mem[33], mem[32]} = 32'h00700393;
{mem[39], mem[38], mem[37], mem[36]} = 32'h00800413;
{mem[43], mem[42], mem[41], mem[40]} = 32'h00900493;
{mem[47], mem[46], mem[45], mem[44]} = 32'h00a00513;
{mem[51], mem[50], mem[49], mem[48]} = 32'h00b00593;
{mem[55], mem[54], mem[53], mem[52]} = 32'h00c00613;
{mem[59], mem[58], mem[57], mem[56]} = 32'h00d00693;
{mem[63], mem[62], mem[61], mem[60]} = 32'h00e00713;
{mem[67], mem[66], mem[65], mem[64]} = 32'h00f00793;
{mem[71], mem[70], mem[69], mem[68]} = 32'h01000813;
{mem[75], mem[74], mem[73], mem[72]} = 32'h01100893;
{mem[79], mem[78], mem[77], mem[76]} = 32'h01200913;
{mem[83], mem[82], mem[81], mem[80]} = 32'h01300993;
{mem[87], mem[86], mem[85], mem[84]} = 32'h01400a13;
{mem[91], mem[90], mem[89], mem[88]} = 32'h01500a93;
{mem[95], mem[94], mem[93], mem[92]} = 32'h01600b13;
{mem[99], mem[98], mem[97], mem[96]} = 32'h01700b93;
{mem[103], mem[102], mem[101], mem[100]} = 32'h01800c13;
{mem[107], mem[106], mem[105], mem[104]} = 32'h01900c93;
{mem[111], mem[110], mem[109], mem[108]} = 32'h01a00d13;
{mem[115], mem[114], mem[113], mem[112]} = 32'h01b00d93;
{mem[119], mem[118], mem[117], mem[116]} = 32'h01c00e13;
{mem[123], mem[122], mem[121], mem[120]} = 32'h01d00e93;
{mem[127], mem[126], mem[125], mem[124]} = 32'h01e00f13;
{mem[131], mem[130], mem[129], mem[128]} = 32'h01f00f93;
{mem[135], mem[134], mem[133], mem[132]} = 32'h00000663;
{mem[139], mem[138], mem[137], mem[136]} = 32'hfff00093;
{mem[143], mem[142], mem[141], mem[140]} = 32'h00100073;
{mem[147], mem[146], mem[145], mem[144]} = 32'h00210113;
{mem[151], mem[150], mem[149], mem[148]} = 32'hffe10113;
{mem[155], mem[154], mem[153], mem[152]} = 32'h00208463;
{mem[159], mem[158], mem[157], mem[156]} = 32'h00d68663;
{mem[163], mem[162], mem[161], mem[160]} = 32'hfff00093;
{mem[167], mem[166], mem[165], mem[164]} = 32'h00100073;
{mem[171], mem[170], mem[169], mem[168]} = 32'h00d68693;
{mem[175], mem[174], mem[173], mem[172]} = 32'hff368693;
{mem[179], mem[178], mem[177], mem[176]} = 32'h00101463;
{mem[183], mem[182], mem[181], mem[180]} = 32'hffe00093;
{mem[187], mem[186], mem[185], mem[184]} = 32'h00078793;
{mem[191], mem[190], mem[189], mem[188]} = 32'h00001663;
{mem[195], mem[194], mem[193], mem[192]} = 32'h00d69863;
{mem[199], mem[198], mem[197], mem[196]} = 32'h01ff1a63;
{mem[203], mem[202], mem[201], mem[200]} = 32'hffe00093;
{mem[207], mem[206], mem[205], mem[204]} = 32'h00100073;
{mem[211], mem[210], mem[209], mem[208]} = 32'hffe00093;
{mem[215], mem[214], mem[213], mem[212]} = 32'h00100073;
{mem[219], mem[218], mem[217], mem[216]} = 32'hff150513;
{mem[223], mem[222], mem[221], mem[220]} = 32'h01e54663;
{mem[227], mem[226], mem[225], mem[224]} = 32'hffd00093;
{mem[231], mem[230], mem[229], mem[228]} = 32'h00100073;
{mem[235], mem[234], mem[233], mem[232]} = 32'h00af4a63;
{mem[239], mem[238], mem[237], mem[236]} = 32'h0073c863;
{mem[243], mem[242], mem[241], mem[240]} = 32'h00004663;
{mem[247], mem[246], mem[245], mem[244]} = 32'h00a50513;
{mem[251], mem[250], mem[249], mem[248]} = 32'h01ff4663;
{mem[255], mem[254], mem[253], mem[252]} = 32'hffd00093;
{mem[259], mem[258], mem[257], mem[256]} = 32'h00100073;
{mem[263], mem[262], mem[261], mem[260]} = 32'hff100513;
{mem[267], mem[266], mem[265], mem[264]} = 32'h02756263;
{mem[271], mem[270], mem[269], mem[268]} = 32'h03ffe063;
{mem[275], mem[274], mem[273], mem[272]} = 32'hfe600513;
{mem[279], mem[278], mem[277], mem[276]} = 32'h01e56c63;
{mem[283], mem[282], mem[281], mem[280]} = 32'hfe500593;
{mem[287], mem[286], mem[285], mem[284]} = 32'h00b56863;
{mem[291], mem[290], mem[289], mem[288]} = 32'h00b00593;
{mem[295], mem[294], mem[293], mem[292]} = 32'h00a00513;
{mem[299], mem[298], mem[297], mem[296]} = 32'h00b56663;
{mem[303], mem[302], mem[301], mem[300]} = 32'hffc00093;
{mem[307], mem[306], mem[305], mem[304]} = 32'h00100073;
{mem[311], mem[310], mem[309], mem[308]} = 32'h0062da63;
{mem[315], mem[314], mem[313], mem[312]} = 32'hfe700513;
{mem[319], mem[318], mem[317], mem[316]} = 32'h00555663;
{mem[323], mem[322], mem[321], mem[320]} = 32'h00005263;
{mem[327], mem[326], mem[325], mem[324]} = 32'h00a8d663;
{mem[331], mem[330], mem[329], mem[328]} = 32'hffb00093;
{mem[335], mem[334], mem[333], mem[332]} = 32'h00100073;
{mem[339], mem[338], mem[337], mem[336]} = 32'h00a00513;
{mem[343], mem[342], mem[341], mem[340]} = 32'h0062fa63;
{mem[347], mem[346], mem[345], mem[344]} = 32'hfe700513;
{mem[351], mem[350], mem[349], mem[348]} = 32'h00a2f663;
{mem[355], mem[354], mem[353], mem[352]} = 32'h00af7463;
{mem[359], mem[358], mem[357], mem[356]} = 32'h00a57a63;
{mem[363], mem[362], mem[361], mem[360]} = 32'hffa00093;
{mem[367], mem[366], mem[365], mem[364]} = 32'h00100073;
{mem[371], mem[370], mem[369], mem[368]} = 32'hff900093;
{mem[375], mem[374], mem[373], mem[372]} = 32'h00100073;
{mem[379], mem[378], mem[377], mem[376]} = 32'h00a00513;
{mem[383], mem[382], mem[381], mem[380]} = 32'h02a00093;
{mem[387], mem[386], mem[385], mem[384]} = 32'h00100073;












//////Test case 4

////32'h00200113 ; //addi x2, x0, 2
//{mem[240], mem[241], mem[242], mem[243]} = 32'h00200113;
////32'h00300093 ; //addi x1, x0, 3
//{mem[244], mem[245], mem[246], mem[247]} = 32'h00300093;
////32'h00112023 ; //sw x1, 0(x2)
//{mem[248], mem[249], mem[250], mem[251]} = 32'h00112023;
////32'h00012183 ; //lw x3, 0(x2)
//{mem[252], mem[253], mem[254], mem[255]} = 32'h00012183;
////32'h00400093 ; //addi x1, x0, 4
//{mem[256], mem[257], mem[258], mem[259]} = 32'h00400093;
////32'h00111023 ; // sh x1, 0(x2)
//{mem[260], mem[261], mem[262], mem[263]} = 32'h00111023;
////32'h00011183 ;//lh x3, 0(x2)
//{mem[264], mem[265], mem[266], mem[267]} = 32'h00011183;
////32'hFFFFF0B7 ; //lui x1,1048575
//{mem[268], mem[269], mem[270], mem[271]} = 32'hFFFFF0B7;
////32'h40008093 ; //addi x1, x1, 1024
//{mem[272], mem[273], mem[274], mem[275]} = 32'h40008093;
////32'h00110023 ;  //sb x1, 0(x2)
//{mem[276], mem[277], mem[278], mem[279]} = 32'h00110023;
////32'h00010183 ; //lb x3, 0(x2)
//{mem[280], mem[281], mem[282], mem[283]} = 32'h00110023;



//data memory start 
 /*mem[200]=8'd17;
 mem[201]=8'd0;
 mem[202]=8'd0;
 mem[203]=8'd0;
 mem[204]=8'd9;
 mem[205]=8'd0;
 mem[206]=8'd0;
 mem[207]=8'd0;
 mem[208]=8'd25;
 mem[209]=8'd0;
 mem[210]=8'd0;
 mem[211]=8'd0; */

 end 

endmodule

