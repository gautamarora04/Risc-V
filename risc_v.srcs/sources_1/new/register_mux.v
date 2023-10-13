`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2023 01:58:59
// Design Name: 
// Module Name: register_mux
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


module register_mux(
    input wire[31:0] pc_plus_4,
    input wire[31:0] alu_out,
    input wire[31:0] store_block_out,
    input wire[31:0] immediate_out,
    input wire[1:0]  select_line,
    output reg [31:0]  output_reg
);
always@(*)begin
     case(select_line)
     2'b00  : output_reg=pc_plus_4;
     2'b01  : output_reg=alu_out;
     2'b10  : output_reg=store_block_out;
     2'b11  : output_reg=immediate_out;
    
     default: output_reg=32'd0;
    endcase
    
end
 endmodule
