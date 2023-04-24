`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2023 01:48:21 PM
// Design Name: 
// Module Name: RISC_V_Processor
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


module RISC_V_Processor(
input clk, reset,
output [63:0] PC_In , 
output[31:0] Instruction,
output [4:0] rs1, rs2, rd,
output [63:0] ReadData1, ReadData2, WriteData,
imm_data, 
result,
ReadData, 
output Branch, zero, ALUSrc, MemRead, MemtoReg, MemWrite, RegWrite,
output[1:0] ALUOp,
output [6:0] opcode,
output [2:0] funct3,
output [6:0] funct7,
output [3:0] Operation
);
    
    //wire [63:0] PC_In;
    wire [63:0] PC_Out; 
    //wire [31:0] Instruction;
    wire [63:0] adderOut, adder2Out;
    //wire [63:0] WriteData;
    //wire [63:0] ReadData1, ReadData2;
    //wire [63:0] imm_data;
    wire [63:0] muxOut;
    //wire [63:0] result;
    //wire [63:0] ReadData;
   
    //wire []
    
    
    Program_Counter PC(clk, reset, PC_In, PC_Out);
    
    Instruction_Memory im(PC_Out, Instruction);
    
    Adder a1(PC_Out, 4, adderOut);
    
    InsParser ip(Instruction, opcode, rd, funct3, rs1, rs2, funct7);
    
    Control_Unit cu(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
    
    ImmGen ig(Instruction, imm_data);
    
    Adder a2(PC_Out, imm_data<<1, adder2Out); //imm_data * 2
    
    ALU_Control ac(ALUOp, {Instruction[30], funct3}, Operation);
    
    registerFile rf(WriteData, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
    
    Mux m1(ReadData2, imm_data, ALUSrc, muxOut);
    
    ALU_64_bit alu64(ReadData1, muxOut, Operation, result, zero);
    
    Mux m2(adderOut, adder2Out, (Branch && zero), PC_In); //
    
    Data_Memory dm(result, ReadData2, clk, MemWrite, MemRead, ReadData);
    
    Mux m3(ReadData, result, MemtoReg, WriteData);
    
endmodule
