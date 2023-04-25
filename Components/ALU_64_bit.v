`timescale 1ns / 1ps
module ALU_64_bit
(
	input [63:0]a, b,
	input [3:0] ALUOp,
	
	output reg [63:0] Result,
	output ZERO
);

localparam [5:0]
AND = 4'b0000,
OR	= 4'b0001,
ADD	= 4'b0010,
Sub	= 4'b0110,
NOR = 4'b1100,
BLT = 4'b1110,     //case for BLT operation
SLLI = 4'b1111;

assign ZERO = (Result == 0);

always @ (ALUOp, a, b)
begin
	case (ALUOp)
		AND: Result = a & b;
		OR:	 Result = a | b;
		ADD: Result = a + b;
		Sub: Result = a - b;
		NOR: Result = ~(a | b);
		SLLI: Result = a << b;
		BLT: Result = (a < b)? 0: -1; //if a < b, result = 0 meaning ZERO is set to 1 which will trigger PC to shift to immediate address
		default: Result = 0;
	endcase
end

endmodule 