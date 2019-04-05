`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Control
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


module Control(
    input rst,
    input [3:0] opCode,
    input clk,
    output reg [13:0] controlSig
    );

always @(opCode or posedge rst)
begin
if (rst) controlSig <= 14'bZZZZZZZZZZZZZZ;
else begin

//NEW CONTROL SIGNAL ARRANGEMENT
if(opCode === 4'b0000) controlSig <= 14'bx0000001001101; //fkeq
else if(opCode === 4'b0001) controlSig <= 14'bx0000000101101; //fkne
else if(opCode === 4'b0010) controlSig <= 14'bx0000100001101; //fklt
else if(opCode === 4'b0011) controlSig <= 14'bx0001000001101; //fkle
else if(opCode === 4'b0100) controlSig <= 14'b00000000000111; //plus
else if(opCode === 4'b0101) controlSig <= 14'b00000000001111; //min
else if(opCode === 4'b0110) controlSig <= 14'b00000000010111; //and
else if(opCode === 4'b0111) controlSig <= 14'b00000000011111; //or
else if(opCode === 4'b1000) controlSig <= 14'bx0010000001101; //fkgt
else if(opCode === 4'b1001) controlSig <= 14'bx0000010001101; //fkge
else if(opCode === 4'b1010) controlSig <= 14'bx01xxxxxxxxx0x; //jump
else if(opCode === 4'b1011) controlSig <= 14'b10000000000010; //ldw
else if(opCode === 4'b1100) controlSig <= 14'bx100000000000x; //stw
else if(opCode === 4'b1101) controlSig <= 14'b00000000000010; //plusi
else if(opCode === 4'b1110) controlSig <= 14'bx00xxxxxxXXxxx; //stop //what do i do with this???
else controlSig <= controlSig; //default
end
end

endmodule
