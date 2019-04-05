`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: ALU1
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


module ALU1(
    input rst,
    input [1:0] ALU1Cont,
    input signed [15:0] Mux1toALU1,
    input signed[15:0] RFToALU1,
    input clk,
    output reg N, //negative flag
    output reg V, //overflow flag
    output reg Zero, //zero flag
    output reg signed [15:0] AddrToMem
    );
reg signed [15:0] addrOut;
reg [15:0] overflowRes;
reg carry;


//****I need both inputs to ALU1 to be ready before I do the calculation(/
always@(ALU1Cont or Mux1toALU1 or RFToALU1 or rst)
begin
if (rst) begin
AddrToMem <= 0;
end

else begin
case (ALU1Cont)
2'b00 : AddrToMem <= RFToALU1 + Mux1toALU1; //plus
2'b01 : AddrToMem <=  RFToALU1 - Mux1toALU1; //minus
2'b10 : AddrToMem <= (Mux1toALU1)&(RFToALU1); //and
2'b11 : AddrToMem <= (Mux1toALU1)|(RFToALU1); //or
default : AddrToMem <= AddrToMem;
endcase
end

end

always@(AddrToMem or rst) //status register signals
begin
if (rst) begin N = 0; V = 0; Zero = 0; end
else begin
{carry, overflowRes} = {Mux1toALU1[15],Mux1toALU1} + {RFToALU1[15],RFToALU1};
V <= (^({carry,overflowRes[15]}));
Zero <= ~(|AddrToMem);
N <= (AddrToMem[15]);
end
end

endmodule
