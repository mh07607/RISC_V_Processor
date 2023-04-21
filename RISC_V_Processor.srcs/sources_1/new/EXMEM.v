`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 02:58:27 PM
// Design Name: 
// Module Name: EXMEM
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


module EXMEM( input clk, reset, 
input [63:0] PC_addr, ALU_out, ALU_input2,
input [4:0] rd, 
input branch,
 input [1:0] write_back, Mem, 
 output reg [63:0] PC_ADD, ALU_output, ALU_second,
 output reg [4:0] dest_res,
 output reg [1:0] WB,
 output reg MemRead, MemWrite,Branch);
 
 //trigerring the lopp over positive edge of clock
 always @ (posedge clk)
 begin

//assaigns 0 to all signals if reset is high 
if (reset==1)
begin
    PC_ADD=0;
    ALU_output=0;
    ALU_second=0;
    dest_res=0;
    WB=0;
    MemRead=0;
    MemWrite=0;
    Branch=0;
end
//else assigns the required values to the outputs
else  
 begin
 WB= write_back;
 MemWrite= Mem[0];
 MemRead= Mem[1];
 PC_ADD= PC_addr;
 ALU_output= ALU_out;
 ALU_second= ALU_input2; 
 dest_res= rd;
 Branch= branch;
 end
 
end
endmodule
