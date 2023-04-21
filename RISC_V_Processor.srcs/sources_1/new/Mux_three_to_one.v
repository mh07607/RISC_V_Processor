`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 10:52:24 AM
// Design Name: 
// Module Name: Mux_three_to_one
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


module Mux_three_to_one(input [63:0] a, b, c, 
input [1:0] sel, 
output [63:0] out);

assign out = sel[1] ? (sel[0]? 0: c) : (sel[0] ? b: a);
endmodule
