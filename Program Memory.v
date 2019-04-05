`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Program Memory
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


module Program_Memory#(parameter integer N = 10)(
    input [N-1:0] PCAddrIn,
    input rst, clk, MemRWPM,
    //input signed [15:0] instructionDataIn,
    output reg [15:0] readDataOutPM
    );
    
    reg [15:0] storage [1023:0];
        
    initial begin
    storage[0] = 16'b1101001001000100; //add 4 to whatever is in R1 GOOD
    storage[1] = 16'b1100001001000000; //sw r1,000000($r1) store whatever is in R1 into memory at the address in 000000($R1) GOOD 
    storage[2] = 16'b1101001000000010; //plusi r0,r1,2 add 2 to whatever value is in register 1 and store it in r0 GOOD
    storage[3] = 16'b1011000001000000; //lw r0,000000($r1) load whatever value of whatever address is in R0 into R1 GOOD 
    storage[4] = 16'b0100001001000000; //plus $r1,$r1,$r0 add whatever is in $r1 to itself and store it in $r0 8 + 8 = 16 GOOD
    storage[5] = 16'b0101000001000000; //min $r0,$r1,$r0 subtract that back out 16 - 8 = 8 GOOD
    storage[6] = 16'b0110000001000000; //and $r0,$r1,$r0 and whatever is in r1 and r0 and store it in r0 8 & 8 = 8 GOOD
    storage[7] = 16'b0111000001000000; //or $r0,$r1,$r0 or whatever is in r1 and r0 and store it in r0 8 | 8 = 8 GOOD
    storage[8] = 16'b0000000001000010; //fkeq $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 and $r1 equal. fork to 11 bc 8 and 8 equal GOOD
    storage[11] = 16'b0001000001000010; //fkne $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 and $r1 equal. don't fork bc 8 and 8 equal GOOD
    storage[12] = 16'b0010000001000010; //fklt $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 < $r1. don't fork bc 8 and 8 equal GOOD
    storage[13] = 16'b0011000001000010; //fkle $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 <= $r1. fork to 16 bc 8 and 8 equal GOOD
    storage[16] = 16'b1000000001000010; //fkgt $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 > $r1. don't fork bc 8 and 8 equal GOOD
    storage[17] = 16'b1001000001000010; //fkge $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 >= $r1. fork to 20 bc 8 and 8 equal GOOD
    storage[20] = 16'b1101001001000001; //plusi $r1,$r0,$r1 add 1 to $r1 and store in $r1 GOOD
    storage[21] = 16'b0000000001000010; //fkeq $r0,$r1,$r0 fork to PC + 1 + 2 if $r0 and $r1 equal. don't fork first time. go to 22. Second time fork to 24 GOOD
    storage[22] = 16'b1101001001111111; //plusi $r1,$r1,$r1 subtract 1 from $r1 to make it equal to $r2 again. GOOD
    storage[23] = 16'b1010000000010101; //jump 0000010101 jump back two instructions to 21. Now $r0 and $r1 are equal again so should fork to storage[24] where the HALT instruction is GOOD
    storage[24] = 16'b1110000000000000; //HALT the program GOOD 
    end
    
    always @(PCAddrIn) begin  
    readDataOutPM <= storage[PCAddrIn];
    end
    
    
endmodule
