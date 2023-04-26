`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:46:41 AM
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
input clk, reset,
input [63:0] ReadData,
EXMEM_MemAddr, 
input [4:0] EXMEM_rd,
input[1:0] EXMEM_WB,
output reg [63:0] MEMWB_ReadData,
MEMWB_MemAddr, 
output reg [4:0] MEMWB_rd,
output reg MEMWB_MemtoReg, MEMWB_RegWrite 
);

always @(posedge clk)
begin
if(reset == 1)
begin
MEMWB_ReadData = 0;
MEMWB_MemAddr = 0;
MEMWB_rd = 0;
MEMWB_MemtoReg = 0; 
MEMWB_RegWrite = 0; 
end
else
begin
MEMWB_ReadData = ReadData;
MEMWB_MemAddr = EXMEM_MemAddr;
MEMWB_rd = EXMEM_rd;
MEMWB_MemtoReg = EXMEM_WB[0]; 
MEMWB_RegWrite = EXMEM_WB[1]; 
end
end
endmodule
