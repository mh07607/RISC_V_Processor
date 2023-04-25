module Data_Memory
(
	input [63:0] Mem_Addr,
	input [63:0] Write_Data,
	input clk, MemWrite, MemRead,
	output reg [63:0] Read_Data,
	output [63:0] element_0,
    element_1,
    element_2,
    element_3,
    element_4,
    element_5,
    element_6//array elements
);

	reg [7:0] DataMemory [1023:0];

	initial
	begin
		DataMemory[0] = 8'd2;
		DataMemory[1] = 8'd0;
		DataMemory[2] = 8'd0;
		DataMemory[3] = 8'd0;
		DataMemory[4] = 8'd0;
		DataMemory[5] = 8'd0;
		DataMemory[6] = 8'd0;
		DataMemory[7] = 8'd0;
		DataMemory[8] = 8'd3;
		DataMemory[9] = 8'd0;
		DataMemory[10] = 8'd0;
		DataMemory[11] = 8'd0;
		DataMemory[12] = 8'd0;
		DataMemory[13] = 8'd0;
		DataMemory[14] = 8'd0;
		DataMemory[15] = 8'd0;
		DataMemory[16] = 8'd1;
		DataMemory[17] = 8'd0;
		DataMemory[18] = 8'd0;
		DataMemory[19] = 8'd0;
		DataMemory[20] = 8'd0;
		DataMemory[21] = 8'd0;
		DataMemory[22] = 8'd0;
		DataMemory[23] = 8'd0;
		DataMemory[24] = 8'd12;
		DataMemory[25] = 8'd0;
		DataMemory[26] = 8'd0;
		DataMemory[27] = 8'd0;
		DataMemory[28] = 8'd0;
		DataMemory[29] = 8'd0;
		DataMemory[30] = 8'd0;
		DataMemory[31] = 8'd0;
		DataMemory[32] = 8'd5;
		DataMemory[33] = 8'd0;
		DataMemory[34] = 8'd0;
		DataMemory[35] = 8'd0;
		DataMemory[36] = 8'd0;
		DataMemory[37] = 8'd0;
		DataMemory[38] = 8'd0;
		DataMemory[39] = 8'd0;
		DataMemory[40] = 8'd8;
		DataMemory[41] = 8'd0;
		DataMemory[42] = 8'd0;
		DataMemory[43] = 8'd0;
		DataMemory[44] = 8'd0 ;
		DataMemory[45] = 8'd0;
		DataMemory[46] = 8'd0;
		DataMemory[47] = 8'd0;
		DataMemory[48] = 8'd9;
		DataMemory[49] = 8'd0;
		DataMemory[50] = 8'd0;
		DataMemory[51] = 8'd0;
		DataMemory[52] = 8'd0;
		DataMemory[53] = 8'd0;
		DataMemory[54] = 8'd0;
		DataMemory[55] = 8'd0;
		DataMemory[56] = 8'd0;
		DataMemory[57] = 8'd0;
		DataMemory[58] = 8'd0;
		DataMemory[59] = 8'd0;
		DataMemory[60] = 8'd0;
		DataMemory[61] = 8'd0;
		DataMemory[62] = 8'd0;
		DataMemory[63] = 8'd0;
		//DataMemory[144] = 8'd5;
		//DataMemory[120] = 8'd6;
	end
	
	always @ (*)
	begin
		if (MemRead)
			Read_Data = {DataMemory[Mem_Addr+7],DataMemory[Mem_Addr+6],DataMemory[Mem_Addr+5],DataMemory[Mem_Addr+4],DataMemory[Mem_Addr+3],DataMemory[Mem_Addr+2],DataMemory[Mem_Addr+1],DataMemory[Mem_Addr]};
	end
	
	always @ (posedge clk)
	begin
		if (MemWrite)
		begin
			DataMemory[Mem_Addr] = Write_Data[7:0];
			DataMemory[Mem_Addr+1] = Write_Data[15:8];
			DataMemory[Mem_Addr+2] = Write_Data[23:16];
			DataMemory[Mem_Addr+3] = Write_Data[31:24];
			DataMemory[Mem_Addr+4] = Write_Data[39:32];
			DataMemory[Mem_Addr+5] = Write_Data[47:40];
			DataMemory[Mem_Addr+6] = Write_Data[55:48];
			DataMemory[Mem_Addr+7] = Write_Data[63:56];
		end
	end
	
	// assigning array elements
	assign element_0 = {DataMemory[7], DataMemory[6], DataMemory[5], DataMemory[4], DataMemory[3], DataMemory[2], DataMemory[1], DataMemory[0]};
    assign element_1 = {DataMemory[15], DataMemory[14], DataMemory[13], DataMemory[12], DataMemory[11], DataMemory[10], DataMemory[9], DataMemory[8]};
    assign element_2 = {DataMemory[23], DataMemory[22], DataMemory[21], DataMemory[20], DataMemory[19], DataMemory[18], DataMemory[17], DataMemory[16]};
    assign element_3 = {DataMemory[31], DataMemory[30], DataMemory[29], DataMemory[28], DataMemory[27], DataMemory[26], DataMemory[25], DataMemory[24]};
    assign element_4 = {DataMemory[39], DataMemory[38], DataMemory[37], DataMemory[36], DataMemory[35], DataMemory[34], DataMemory[33], DataMemory[32]};
    assign element_5 = {DataMemory[47], DataMemory[46], DataMemory[45], DataMemory[44], DataMemory[43], DataMemory[42], DataMemory[41], DataMemory[40]};
    assign element_6 = {DataMemory[55], DataMemory[54], DataMemory[53], DataMemory[52], DataMemory[51], DataMemory[50], DataMemory[49], DataMemory[48]};


	
	
endmodule
