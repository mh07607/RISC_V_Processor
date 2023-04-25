module Control_Unit
(
	input [6:0] Opcode,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, 
	output reg [1:0] ALUOp
);

	always @ (Opcode)
	begin
		case (Opcode)
			7'b0110011: //R type
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 1;
					ALUOp = 2'b10;
				end
			7'b0000011: //ld
				begin
					Branch = 0;
					MemRead = 1;
					MemtoReg = 1;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b00;
				end
			7'b0010011: //addi//slli
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b00;
				end
			7'b0100011: // I type SD
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 1;
					ALUSrc = 1;
					RegWrite = 0;
					ALUOp = 2'b00;
				end
			7'b1100011:  //SB
				begin
					Branch = 1;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 0;
					ALUOp = 2'b01;
				end
		endcase
	end

endmodule 