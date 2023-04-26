`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 01:39:21 PM
// Design Name: 
// Module Name: mux_control
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

module mux_control(Mux_Write,iBranch, iMemRead, iMemtoReg, iMemWrite, iALUSrc, iRegWrite, iALUOp,
 Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
  
  input Mux_Write;
  input iBranch, iMemRead, iMemtoReg, iMemWrite, iALUSrc, iRegWrite;
  input [1:0] iALUOp;
  output reg Branch;
  output reg MemRead;
  output reg MemtoReg; 
  output reg MemWrite;
  output reg ALUSrc;
  output reg RegWrite;
  output reg [1:0] ALUOp;
  
  always@(*)
    begin
      if (~Mux_Write)
        begin
          Branch=0;
          MemRead=0;
          MemtoReg=0;
          MemWrite=0;
          ALUSrc=0;
          RegWrite=0;
          ALUOp=0;
        end
      else
        begin
          Branch=iBranch;
          MemRead=iMemRead;
          MemtoReg=iMemtoReg;
          MemWrite=iMemWrite;
          ALUSrc=iALUSrc;
          RegWrite=iRegWrite;
          ALUOp=iALUOp;
        end
    end
endmodule