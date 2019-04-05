`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Top;
// Project Name:;;
// Target Devices;:;;
// Tool Versions:;;
// Description:;
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Top(
//required top-level signals
  input rst,
  input clk,
  output [15:0] outValue,
  input [3:0] inr,
  //Data Memory Inputs and Outputs since memory is external
  output [15:0] WriteDataOutDM,
  output MemRWDM,
  output [9:0] addressOutDM,
  input [15:0] readDatainDM,
  //Program Memory Inputs and Outputs since memory is external
  input [15:0] readDatainPM,
  output [15:0] WriteDataOutPM,
  output [9:0] AddrInPM,
  //output MemRWPM,
  output [9:0] PCToProgMem
  );
  
  localparam M = 10;
  wire [1:0] ALU1Cont;
  wire [15:0] Mux1toALU1;
  wire [15:0] RFToALU1;
  wire N,V,Zero;
  wire MemToReg,ALUCont,jump,regWrite,RFMux,RegDst;
  wire [15:0] RFToMux1;
  wire [5:0] SignEToMux1;
  wire XORToMux2;
  wire [M-1:0] ALU2ToMux2;
  wire [M-1:0] AdderToMux2;
  wire [M-1:0] Mux2ToMux3;
  wire [15:0] Mux4ToRF;
  wire [15:0] ALU1ToMux4;
  wire [2:0] WriteReg;
  wire [M-1:0] Mux3toPC;
  wire [M-1:0] PCAddrIn;
  wire [15:0] WriteDataIn;
  wire fkgt,fkle,fklt,fkge,fkne,fkeq;
  
assign WriteDataOutDM = RFToMux1; //this goes to external data memory
assign addressOutDM = ALU1ToMux4[9:0];
assign AddrInPM = PCToProgMem;

Adder Adder(
.rst(rst),.clk(clk),
.PCtoAdder(PCToProgMem),
.AdderToALU2(AdderToMux2)
);

ALU1 ALU1(
  .rst(rst),
  .ALU1Cont(ALU1Cont),
  .Mux1toALU1(Mux1toALU1),
  .RFToALU1(RFToALU1),
  .clk(clk),
  .N(N),
  .V(V),
  .Zero(Zero),
  .AddrToMem(ALU1ToMux4)
  );

  ALU2 ALU2(
    .rst(rst),.clk(clk),
    .branchAddrToALU2(readDatainPM[5:0]),
    .adderToALU2(AdderToMux2),
    .ALU2ToMux2(ALU2ToMux2)
    );

Control Control(
  .controlSig({{MemToReg},{MemRWDM},{jump},{fkgt},{fkle},{fklt},{fkge},{fkeq},{fkne},{ALU1Cont},{RFMux},{regWrite},{RegDst}}),
  .opCode(readDatainPM[15:12]),.rst(rst),.clk(clk)
  );

/*Data_Memory DataMem(
  .Addr(ALU1ToMux4),.WriteData(RFToMux1),.MemRW(MemRW),
  .ReadDataOut(readDatain)
  );*/

Mux1 Mux1(
  .rst(rst),.clk(clk),.RFMux(RFMux),.RFToMux1(RFToMux1),.SignEToMux1(readDatainPM[5:0]),
  .Mux1toALU1(Mux1toALU1)
  );

Mux2 Mux2(
  .rst(rst),.clk(clk),.XORToMux2(XORToMux2),.ALU2ToMux2(ALU2ToMux2),
  .AdderToMux2(AdderToMux2),.Mux2ToMux3(Mux2ToMux3)
  );

Mux3 Mux3(
  .rst(rst),.clk(clk),.Mux2ToMux3(Mux2ToMux3),.jumpAddr(readDatainPM[9:0]),
  .jump(jump),.Mux3toPC(Mux3toPC),.opCode(readDatainPM[15:12])
  );

Mux4 Mux4(
  .rst(rst),.clk(clk),.memToReg(MemToReg),.readDatain(readDatainDM),
  .ALU1ToMux4(ALU1ToMux4),.writeDataOut(Mux4ToRF)
  );

Mux5 Mux5(
  .rst(rst),.clk(clk),.RegDst(RegDst),.Rtype(readDatainPM[5:3]),.Itype(readDatainPM[8:6]),
  .WriteReg(WriteReg)
  );

Program_Counter PC(
  .rst(rst),.clk(clk),.Mux3toPC(Mux3toPC),.opCode(readDatainPM[15:12]),
  .PCToProgMem(PCToProgMem)
  );

/*Program_Memory ProgMem(
  .PCAddrIn(PCToProgMem),.readDatainPM(readDatainPM),.instructionDataIn(WriteDataOutPM),
  .rst(rst),.clk(clk),.MemRWPM(MemRWPM)
  );*/

/*Data_Memory DataMem(
.clk(clk),.MemRWDM(MemRWDM),.dataMemOut(readDatainDM),.Addr(ALU1ToMux4[9:0]),.writeDataIn(RFToMux1)
);*/  

Register_File RF(
  .rst(rst),.clk(clk),.Rt(readDatainPM[11:9]),.Rs(readDatainPM[8:6]),.Rd(WriteReg),
  .wDataIn(Mux4ToRF),.regWrite(regWrite),
  .regOut(RFToMux1),.RFToALU1(RFToALU1),.outValue(outValue),.inr(inr) //define these in top
  );

 Rtype_Logic RBox(
   .rst(rst),.clk(clk),.fkgt(fkgt),.fkle(fkle),.fklt(fklt),
   .fkge(fkge),.fkne(fkne),.fkeq(fkeq),.N(N),.V(V),.zero(Zero),.XORToMux2(XORToMux2)
   );


endmodule
