`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Mux5
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


module Mux5(
    input rst,
    input RegDst,
    input clk,
    input [2:0] Rtype,
    input [2:0] Itype,
    output reg [2:0] WriteReg
    );

always @(RegDst or Rtype or Itype or WriteReg or rst)
begin
if (rst) WriteReg <= 0;
else begin
    case (RegDst)
        1'b0 : WriteReg <= Itype;
        1'b1 : WriteReg <= Rtype;
        default: WriteReg <= WriteReg;
    endcase
end
end

endmodule
