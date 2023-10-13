`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 23:19:22
// Design Name: 
// Module Name: pc_input
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


module pc_input(output reg [31:0] pc_mux_out,input [31:0] pc_add_4, input [31:0] imm_out_addr,input [31:0]alu_out,input [1:0] PC_src);

always @(*) begin
case(PC_src)
'b00: pc_mux_out = alu_out;
'b01: pc_mux_out = imm_out_addr;
'b10: pc_mux_out = pc_add_4;
default : pc_mux_out = 'b0;
endcase
end
endmodule
