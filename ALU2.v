`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: ALU2
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


module ALU2#(parameter integer N = 10)(
input rst,
    input signed [5:0] branchAddrToALU2,
    input signed [N-1:0] adderToALU2,
    input clk,
    output reg signed [N-1:0] ALU2ToMux2
    );

always @(branchAddrToALU2 or adderToALU2 or ALU2ToMux2 or rst)
begin
if (rst) begin
ALU2ToMux2 <= 0;
end
else begin
ALU2ToMux2 <= {{4{branchAddrToALU2[5]}},branchAddrToALU2}/* *2 */ + adderToALU2; //sign extend and shift left 1 BATA, then add to ATA
end
end
endmodule
