`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Adder
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


module Adder#(parameter integer N = 10)(
    input rst,
    input signed [N-1:0] PCtoAdder,
    input clk,
    output reg signed [N-1:0] AdderToALU2
    );

always @(negedge clk or posedge rst)
begin
if(rst) AdderToALU2 <= 0;
else AdderToALU2 <= PCtoAdder + 1;
end
endmodule
