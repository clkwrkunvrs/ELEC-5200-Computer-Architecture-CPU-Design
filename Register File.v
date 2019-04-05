`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2018 11:35:00 PM
// Design Name:
// Module Name: Register File
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



module Register_File #(parameter integer N = 16)(
    input rst,
    input [2:0] Rt, //register address
    input [2:0] Rs,
    input [2:0] Rd,
    input signed [N-1:0] wDataIn,
    input regWrite, clk,
    output reg signed [N-1:0] regOut,
    output reg signed [N-1:0] RFToALU1,
    output reg signed [15:0] outValue,
    input [3:0] inr
    );

reg [N-1:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7;

/*initial begin
#12
reg0 = 2;
reg1 = 2;
reg2 = 2;
reg3 = 2;
reg4 = 2;
reg5 = 2;
reg6 = 2;
reg7 = 2;
end*/

// assign outValue = outValueData;

always @(Rt or Rs or reg0 or reg1 or reg2 or reg3 or reg4 or reg5 or reg6 or reg7) begin
RFToALU1 <= Rt == 0 ? reg0 : //could this be the source of my infinite loop??? does this statement evaluate again if the values of the registers change?
                  Rt == 1 ? reg1 :
                  Rt == 2 ? reg2 :
                  Rt == 3 ? reg3 :
                  Rt == 4 ? reg4 :
                  Rt == 5 ? reg5 :
                  Rt == 6 ? reg6 :
                  Rt == 7 ? reg7 : 0;

regOut <= Rs == 0 ? reg0 :
                Rs == 1 ? reg1 :
                Rs == 2 ? reg2 :
                Rs == 3 ? reg3 :
                Rs == 4 ? reg4 :
                Rs == 5 ? reg5 :
                Rs == 6 ? reg6 :
                Rs == 7 ? reg7 : 0;
end

always@(negedge clk or posedge rst)
begin
if (rst) begin
    reg0 <= 0;
    reg1 <= 0;
    reg2 <= 0;
    reg3 <= 0;
    reg4 <= 0;
    reg5 <= 0;
    reg6 <= 0;
    reg7 <= 0;
    end
else if (regWrite) begin
    case (Rd)
        0: reg0 <= wDataIn;
        1: reg1 <= wDataIn;
        2: reg2 <= wDataIn;
        3: reg3 <= wDataIn;
        4: reg4 <= wDataIn;
        5: reg5 <= wDataIn;
        6: reg6 <= wDataIn;
        7: reg7 <= wDataIn;
    endcase
  end
else begin
reg0 <= reg0;
reg1 <= reg1;
reg2 <= reg2;
reg3 <= reg3;
reg4 <= reg4;
reg5 <= reg5;
reg6 <= reg6;
reg7 <= reg7;
end
  end

always@(reg0 or reg1 or reg2 or reg3 or reg4 or reg5 or reg6 or reg7 or inr) begin
case(inr)
    0: outValue <= reg0;
    1: outValue <= reg1;
    2: outValue <= reg2;
    3: outValue <= reg3;
    4: outValue <= reg4;
    5: outValue <= reg5;
    6: outValue <= reg6;
    7: outValue <= reg7;
    default: outValue <= outValue;
    endcase
end
endmodule
