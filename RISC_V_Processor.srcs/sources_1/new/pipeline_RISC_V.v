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
output [6:0] opcode,
output [2:0] funct3,
output [6:0] funct7,
output [3:0] Operation,
output [63:0] muxOut,
output [63:0] element_0,
element_1,
element_2,
element_3,
element_4,
element_5,
element_6, //array elements
ith_address, //address of array[i], array[j] 
jth_address,
i,
j,
array_j,
array_j_1, 
EXMEM_MemAddr);
    //wire [63:0] PC_In;
    wire [63:0] PC_Out; 
    //wire [31:0] Instruction;
    wire [63:0] adderOut, adder2Out;
    //wire [63:0] WriteData;
    //wire [63:0] ReadData1, ReadData2;
    //wire [63:0] imm_data;
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
    wire EXMEM_RegWrite; 
    wire [4:0] EXMEM_rd;
    //wire [63:0] EXMEM_MemAddr; 
    wire [63:0] EXMEM_WriteData;
    wire [1:0] EXMEM_WB;
    wire EXMEM_MemRead, EXMEM_MemWrite, EXMEM_Branch;
    
    //MEMWB  registers
    wire [4:0] MEMWB_rd;
    wire [63:0] MEMWB_ReadData, MEMWB_MemAddr;
    wire MEMWB_MemtoReg, MEMWB_RegWrite;
    
    wire [1:0] ForwardA, ForwardB;
    wire [63:0] muxOut_ForwardA, muxOut_ForwardB;
    
    
    Forwarding_Unit forwarding_unit(
    EXMEM_RegWrite, 
    EXMEM_rd, IDEX_rs1, IDEX_rs2,
    MEMWB_RegWrite,
    MEMWB_rd,
    ForwardA, ForwardB
    );
    
    
    Program_Counter PC(clk, reset, PC_In, PC_Out);
    
    Instruction_Memory im(PC_Out, Instruction);
    
    Adder a1(PC_Out, 4, adderOut);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    IFID ifid(clk, reset, Instruction, PC_Out, IFID_PC_Out, IFID_Instruction);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    InsParser ip(IFID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);
    
    Control_Unit cu(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
    
    ImmGen ig(IFID_Instruction, imm_data);
    
    registerFile rf(WriteData, rs1, rs2, MEMWB_rd, MEMWB_RegWrite, clk, reset, ReadData1, ReadData2, 
    ith_address, //address of array[i], array[j] 
    jth_address,
    i,j,
    array_j, array_j_1);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
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
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    Adder a2(IDEX_PC_Out, IDEX_imm_data*2, adder2Out);
    
    ALU_Control ac(IDEX_EX[1:0], IDEX_funct, Operation);
    
    Mux_three_to_one m4(IDEX_ReadData1, WriteData, EXMEM_MemAddr, ForwardA, muxOut_ForwardA);
    
    Mux_three_to_one m5(IDEX_ReadData2, WriteData, EXMEM_MemAddr, ForwardB, muxOut_ForwardB);
    
    Mux m1(muxOut_ForwardB, IDEX_imm_data, IDEX_EX[2], muxOut);
    
    ALU_64_bit alu64(muxOut_ForwardA, muxOut, Operation, result, zero);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    EXMEM exmem(clk, reset, 
     adder2Out, result, muxOut_ForwardB,
     IDEX_rd, 
     IDEX_M[2],
     IDEX_WB, IDEX_M[1:0],
     zero, 
     EXMEM_adder2Out, EXMEM_MemAddr, EXMEM_WriteData,
     EXMEM_rd,
     EXMEM_WB,
     EXMEM_MemRead, EXMEM_MemWrite, EXMEM_Branch,
     EXMEM_zero);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    Data_Memory dm(EXMEM_MemAddr, EXMEM_WriteData, clk, EXMEM_MemWrite, EXMEM_MemRead, ReadData,
    element_0,
    element_1,
    element_2,
    element_3,
    element_4,
    element_5,
    element_6);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    MEMWB memwb(clk, reset,
    ReadData,
    EXMEM_MemAddr, 
    EXMEM_rd,
    EXMEM_WB,
    MEMWB_ReadData,
    MEMWB_MemAddr, 
    MEMWB_rd,
    MEMWB_MemtoReg, MEMWB_RegWrite );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Mux m2(adderOut, EXMEM_adder2Out, (EXMEM_Branch & EXMEM_zero), PC_In);
    
    Mux m3(MEMWB_MemAddr, MEMWB_ReadData, MEMWB_MemtoReg, WriteData);
    
endmodule

