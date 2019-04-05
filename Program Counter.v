`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Program Counter
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


module Program_Counter#(parameter integer N = 10)(
    input rst,
    input signed [N-1:0] Mux3toPC,
    input clk,
    input [3:0] opCode,
    output reg signed [N-1:0] PCToProgMem
    );

    always @ (posedge clk) begin
    if (rst) PCToProgMem <= 0;
    else PCToProgMem <= Mux3toPC;
    end

endmodule
