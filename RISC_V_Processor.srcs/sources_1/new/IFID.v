`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 01:11:01 PM
// Design Name: 
// Module Name: IFID
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


module IFID(input clk, input reset, input [31:0] Instruction, 
input [63:0] PC_out, input IFID_Write,
output reg [63:0] IFID_PC_Out,
output reg [31:0] IFID_Instruction);

always @(posedge clk)
begin
   if(reset == 1) 
   begin
    IFID_PC_Out <= 0;
    IFID_Instruction <= 0;   //IF/ID stage
   end
   else if (~IFID_Write) 
        begin
          IFID_PC_Out <= IFID_PC_Out;
          IFID_Instruction <= IFID_Instruction;
        end
   else 
   begin
    IFID_Instruction <= Instruction;  //IF/ID stage
    IFID_PC_Out <= PC_out;
   end
end

endmodule
