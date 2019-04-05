`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Data Memory
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


module Data_Memory(
    input clk,
    input [9:0] Addr,
    input [15:0] writeDataInDM,
    input MemRWDM,
    output reg [15:0] dataMemOut
    );
    
  reg [15:0] data_storage [1023:0];

initial begin
   data_storage[6] = 16'd8;
   data_storage[8] = 16'd5;
   data_storage[10] = 16'd3;
  end
    
    always@(Addr) begin
    dataMemOut <= data_storage[Addr];
    end
    
    always@(negedge clk) begin
    if(MemRWDM) data_storage[Addr] <= writeDataInDM;
    end
      
endmodule
    
