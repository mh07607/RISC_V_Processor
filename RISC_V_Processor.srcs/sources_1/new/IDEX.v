`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 01:43:28 PM
// Design Name: 
// Module Name: IDEX
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


module IDEX(input clk, 
reset,                                      
input [63:0] PC_Out,
input [63:0] ReadData1, 
input [63:0] ReadData2, 
input [63:0] imm_data,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input [3:0] funct,
input [1:0] WB,
input [2:0] M,
input [2:0] EX,
output reg [63:0] IDEX_PC_Out,
output reg [63:0] IDEX_ReadData1, 
output reg [63:0] IDEX_ReadData2, 
output reg [63:0] IDEX_imm_data,
output reg [4:0] IDEX_rs1,
output reg [4:0] IDEX_rs2,
output reg [4:0] IDEX_rd,
output reg [3:0] IDEX_funct,
output reg [1:0] IDEX_WB,
output reg [2:0] IDEX_M,
output reg [2:0] IDEX_EX);



always @(posedge clk)
begin
   if(reset == 1) 
   begin //IF/ID stage
    IDEX_PC_Out <= 0;  //ID/EX stage
    IDEX_ReadData1 <= 0;
    IDEX_ReadData2 <= 0;
    IDEX_imm_data <= 0;
    IDEX_rs1 <= 0;
    IDEX_rs2 <= 0;
    IDEX_rd <= 0;
    IDEX_funct <= 0;
    IDEX_WB <= 0;
    IDEX_M <= 0;
    IDEX_EX <= 0;
   end
   else 
   begin
    IDEX_PC_Out <= PC_Out;  //ID/EX stage
    IDEX_ReadData1 <= ReadData1;
    IDEX_ReadData2 <= ReadData2;
    IDEX_imm_data <= imm_data;
    IDEX_rs1 <= rs1;
    IDEX_rs2 <= rs2;
    IDEX_rd <= rd;
    IDEX_funct <= funct;
    IDEX_WB <= WB;
    IDEX_M <= M;
    IDEX_EX <= EX;
    
   end
end

endmodule
