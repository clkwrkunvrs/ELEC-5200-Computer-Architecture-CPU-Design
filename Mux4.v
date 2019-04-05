`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Mux4
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


module Mux4(
    input rst,
    input memToReg, //control sig
    input clk,
    input signed [15:0] readDatain,
    input signed [15:0] ALU1ToMux4,
    output reg signed [15:0] writeDataOut
    );

always @(memToReg or readDatain or ALU1ToMux4 or rst)
 begin
 if (rst) writeDataOut <= 0;
 else begin
    case (memToReg)
        1'b0 : writeDataOut <= ALU1ToMux4;
        1'b1 : writeDataOut <= readDatain;
        default: writeDataOut <= writeDataOut;
    endcase
 end
 end
endmodule
