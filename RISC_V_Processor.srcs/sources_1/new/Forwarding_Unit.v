`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2023 03:41:10 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    input Ex_Mem_RegWrite, 
    input [4:0] Ex_Mem_RD, ID_Ex_RS1, ID_Ex_Rs2,
    input Mem_WB_RegWrite,
    input [4:0] Mem_WB_RD,
    output[1:0] ForwardA, ForwardB
    );
    
    //For EX Hazard 
    //checks for Ex conditions in the first line and fr MEmWB hazard in the second line
    assign ForwardA= ((Ex_Mem_RegWrite == 1) && (Ex_Mem_RD !=0) && ( Ex_Mem_RD== ID_Ex_RS1))? 2'b10:
                 ((Mem_WB_RegWrite==1) && ( Mem_WB_RD !=0) && !((Ex_Mem_RegWrite==1) && (Ex_Mem_RD != 0)
                  && (Ex_Mem_RD == ID_Ex_RS1)) && (Mem_WB_RD == ID_Ex_RS1))? 2'b01 : 2'b00;
    
    //checks for Ex conditions in the first line and fr MEmWB hazard in the second line             
    assign ForwardB= ((Ex_Mem_RegWrite == 1) && (Ex_Mem_RD !=0) && ( Ex_Mem_RD== ID_Ex_Rs2))? 2'b10:
                 ((Mem_WB_RegWrite==1) && ( Mem_WB_RD !=0) && !((Ex_Mem_RegWrite==1) && (Ex_Mem_RD != 0)
                  && (Ex_Mem_RD == ID_Ex_Rs2)) && (Mem_WB_RD == ID_Ex_Rs2))? 2'b01 : 2'b00;
endmodule   


