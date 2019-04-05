`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Mux1
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


module Mux1(
    input rst,
    input RFMux, //control signal
    input signed [15:0] RFToMux1,
    input signed [5:0] SignEToMux1,
    input clk,
    output reg signed [15:0] Mux1toALU1
    );

always @(RFToMux1 or SignEToMux1 or RFMux or posedge rst)
begin
if (rst) Mux1toALU1 <= 0;
else begin
case (RFMux)
1'b0 : Mux1toALU1 <= {{10{SignEToMux1[5]}},SignEToMux1}; //sign extension
1'b1 : Mux1toALU1 <= RFToMux1;
default: Mux1toALU1 <= Mux1toALU1;
endcase
end
end

endmodule
