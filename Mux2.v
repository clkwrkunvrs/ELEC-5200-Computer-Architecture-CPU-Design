`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Mux2
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


module Mux2#(parameter integer N = 10)(
    input rst,
    input XORToMux2, //control signal
    input clk,
    input signed [N-1:0] ALU2ToMux2,
    input signed [N-1:0] AdderToMux2,
    output reg signed [N-1:0] Mux2ToMux3
    );

always @(XORToMux2 or ALU2ToMux2 or AdderToMux2 or rst)
  begin
  if (rst) Mux2ToMux3 <= 0;
  else begin
  case (XORToMux2)
    1'b0 : Mux2ToMux3 <= AdderToMux2;
    1'b1 : Mux2ToMux3 <= ALU2ToMux2;  
    default: Mux2ToMux3 <= Mux2ToMux3;
  endcase
 end
 end
endmodule
