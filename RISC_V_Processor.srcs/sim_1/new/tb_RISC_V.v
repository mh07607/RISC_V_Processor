`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2023 03:04:57 PM
// Design Name: 
// Module Name: tb_RISC_V
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


module tb_RISC_V(

    );
    reg clk, reset;
    wire [63:0] PC_In; 
    wire [31:0] Instruction;
    wire [4:0] rs1, rs2, rd;
    wire [63:0] ReadData1, ReadData2, WriteData,
    imm_data, 
    result,
    ReadData;
    wire Branch, zero;
    wire [6:0] opcode;
    wire ALUSrc, MemRead, MemtoReg, MemWrite, RegWrite;
    wire [1:0] ALUOp;
    
RISC_V_Processor risk(clk, reset, PC_In, 
Instruction,
rs1, rs2, rd,
ReadData1, ReadData2, WriteData,
imm_data, 
result,
ReadData,
Branch,
zero,ALUSrc, MemRead, MemtoReg, MemWrite, RegWrite, ALUSrc, 
opcode);
    
    initial 
    begin 
        clk = 0; reset = 1;
        #200 reset = 0;
        
    end
    
    always #100 clk = ~clk;
endmodule
