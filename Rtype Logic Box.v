`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:36:54 PM
// Design Name:
// Module Name: Rtype Logic Box
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


module Rtype_Logic(
  input rst,
  input fkgt,
  input fkle,
  input fklt,
  input fkge,
  input fkne,
  input fkeq,
  input N,
  input V,
  input zero,
  input clk,
  output reg XORToMux2
  );
  wire a,b,c,d,e,f;
  

  assign a = (~(zero | (N ^ V))) & fkgt; //fkgt
  assign b = (zero | (N ^ V)) & fkle; //fkle
  assign c = (N ^ V) & fklt; //fklt
  assign d = (~(N ^ V)) & fkge; //fkge
  assign e = ~zero & fkne; //fkne
  assign f = zero & fkeq; //fkeq


  always@ (fkgt or fkle or fklt or fkge or fkne or fkeq or N or V or zero or rst)
  begin
  if (rst) XORToMux2 <= 0;
  else XORToMux2 <= (^{a,b,c,d,e,f});
  end
  endmodule
