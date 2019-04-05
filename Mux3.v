`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Mux3
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


module Mux3#(parameter integer N = 10)(
    input rst,
    input signed [N-1:0] Mux2ToMux3,
    input [N-1:0] jumpAddr,
    input jump/*control signal*/, clk,
    input [3:0] opCode,
    output reg [N-1:0] Mux3toPC
    );

always @(Mux2ToMux3 or jumpAddr or jump or posedge rst)
begin
if (rst) Mux3toPC <= 0;
else if (opCode == 4'b1110) Mux3toPC <= Mux3toPC;
else begin
case (jump)
1'b0 : Mux3toPC <= Mux2ToMux3;
1'b1 : Mux3toPC <= jumpAddr;
default: Mux3toPC <= Mux3toPC;
endcase
end
end

endmodule
