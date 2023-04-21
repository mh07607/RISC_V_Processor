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
    wire [63:0] mux4out, mux5out;
    //wire [63:0] result;
    //wire [63:0] ReadData;
    //wire []
    wire [63:0] IFID_PC_Out; //IFID registers
    wire [31:0] IFID_Instruction;
    
    wire [63:0] IDEX_PC_Out, //IDEX registers
    IDEX_ReadData1,
    IDEX_ReadData2, 
    IDEX_imm_data;
    wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd;
    wire [3:0] IDEX_funct;
    wire [1:0] IDEX_WB;
    wire [1:0] IDEX_M;
    wire [2:0] IDEX_EX;
    
    wire [63:0] EXMEM_adder2out;    //EXMEM registers
    
    
    
    Program_Counter PC(clk, reset, PC_In, PC_Out);
    
    Instruction_Memory im(PC_Out, Instruction);
    
    Adder a1(PC_Out, 4, adderOut);
    
    IFID ifid(clk, reset, Instruction, PC_Out, IFID_PC_Out, IFID_Instruction);
    
    InsParser ip(IFID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);
    
    Control_Unit cu(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
    
    ImmGen ig(IFID_Instruction, imm_data);
    
    registerFile rf(WriteData, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
    
    IDEX idex(clk, reset,
    PC_Out, 
    ReadData1, 
    ReadData2, 
    imm_data,
    rs1,
    rs2, 
    rd,
   {Instruction[30], funct3},
   {RegWrite, MemtoReg},
   {Branch, MemWrite, MemRead},
   {ALUOp, ALUSrc},
    IDEX_PC_Out, 
    IDEX_ReadData1,
    IDEX_ReadData2, 
    IDEX_imm_data,
    IDEX_rs1, IDEX_rs2, IDEX_rd,
    IDEX_funct, IDEX_WB, IDEX_M, IDEX_EX);
    
    Adder a2(IDEX_PC_Out, IDEX_imm_data*2, adder2Out);
    
    ALU_Control ac(IDEX_EX[1:0], IDEX_funct, Operation);
    
    Mux m1(IDEX_ReadData2, IDEX_imm_data, IDEX_EX[2], muxOut);
    
    ALU_64_bit alu64(IDEX_ReadData1, muxOut, Operation, result, zero);
    
    Mux_three_to_one m4(mux4out);
    
    Mux_three_to_one m5(mux5out);
    
    EXMEM exmem(clk, reset, 
    adder2Out,
    result,
    v);
    
    Mux m2(adderOut, adder2Out, (Branch & zero), PC_In);
    
    Data_Memory dm(result, Read_Data2, clk, MemWrite, MemRead, ReadData);
    
    Mux m3(ReadData, result, MemtoReg, WriteData);
    
endmodule

