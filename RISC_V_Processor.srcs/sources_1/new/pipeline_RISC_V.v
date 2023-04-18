`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 04:45:25 PM
// Design Name: 
// Module Name: pipeline_RISC_V
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


module pipeline_RISC_V(
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
output [6:0] opcode
);
    
    //wire [63:0] PC_In;
    wire [63:0] PC_Out; 
    //wire [31:0] Instruction;
    
    wire [3:0] Operation;
    wire [63:0] adderOut;
    //wire [63:0] WriteData;
    //wire [63:0] ReadData1, ReadData2;
    //wire [63:0] imm_data;
    wire [63:0] muxOut;
    //wire [63:0] result;
    //wire [63:0] ReadData;
    //wire []
    wire [95:0] IFID;
    wire [277:0] IDEX;
    
    Program_Counter PC(clk, reset, PC_In, PC_Out);
    
    Instruction_Memory im(PC_Out, Instruction);
    
    Adder a1(PC_Out, 4, adderOut);
    
    assign IFID[31:0] = Instruction;  //IF/ID stage
    assign IFID[95:32] = PC_Out;
    
    InsParser ip(IFID[31:0], opcode, rd, funct3, rs1, rs2, funct7);
    
    Control_Unit cu(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
    
    ImmGen ig(IFID[31:0], imm_data);
    
    registerFile rf(WriteData, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
    
    assign IDEX[63:0] = IFID[95:32];  //ID/EX stage
    assign IDEX[127:64] = ReadData1;
    assign IDEX[191:128] = ReadData2;
    assign IDEX[255:192] = ReadData1;
    
    Adder a2(PC_Out, imm_data*2, adder2Out);
    
    ALU_Control ac(ALUOp, {Instruction[30], funct3}, Operation);
    
    Mux m1(ReadData2, imm_data, ALUSrc, muxOut);
    
    ALU_64_bit alu64(ReadData1, muxOut, Operation, result, zero);
    
    Mux m2(adderOut, adder2Out, (Branch & zero), PC_In);
    
    Data_Memory dm(result, Read_Data2, clk, MemWrite, MemRead, ReadData);
    
    Mux m3(ReadData, result, MemtoReg, WriteData);
    
endmodule

