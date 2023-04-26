`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 01:21:37 PM
// Design Name: 
// Module Name: Hazard_Unit
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

module HazardDetection(ID_EX_RegisterRd, IF_ID_RegisterRs1, IF_ID_RegisterRs2, ID_EX_MemRead, PC_Write, MUX_Write, IFID_Write);
   
   input [4:0] ID_EX_RegisterRd;
   input [4:0] IF_ID_RegisterRs1; 
   input [4:0] IF_ID_RegisterRs2;
   input ID_EX_MemRead;
   output reg PC_Write;
   output reg MUX_Write;
   output reg IFID_Write;
   
  always@(*)
    begin
      if (ID_EX_MemRead && ((ID_EX_RegisterRd ==IF_ID_RegisterRs1) ||(ID_EX_RegisterRd==IF_ID_RegisterRs2)))
        begin
          PC_Write=0;
          MUX_Write=0;
          IFID_Write=0;
        end
      else
        begin
          PC_Write=1;
          MUX_Write=1;
          IFID_Write=1;
        end
    end
endmodule


