`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2023 14:52:31
// Design Name: 
// Module Name: alu
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


module alu(a,b,alucontrol,out);
input [31:0] a, b;
input [2:0] alucontrol;
output [31:0] out;

wire [31:0] a_and_b;
wire [31:0] a_or_b;
wire [31:0] b_not;

wire [31:0] alu_mux;

wire [31:0] sum;

wire [31:0] out_mux;
// logical design : and, or, not 
assign a_and_b = a&b;
assign a_or_b  = a|b;
assign b_not = ~b;

// terneray operator

assign alu_mux = (alucontrol[0] == 1'b0) ? b : b_not;

// addition or subtraction 

assign sum = a + alu_mux + alucontrol[0];

assign out_mux = (alucontrol[1:0] == 2'b00) ? sum :
                 (alucontrol[1:0] == 2'b01) ? sum :
                 (alucontrol[1:0] == 2'b10) ? a_and_b : a_or_b;
                  
assign out = out_mux;

endmodule
