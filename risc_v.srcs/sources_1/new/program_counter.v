`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2023 23:25:14
// Design Name: 
// Module Name: program_counter
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

module program_counter(clk, rst, pc_next, pc);
    
    input [31:0] pc_next;
    input clk,rst;

    output reg[31:0] pc;
    
    initial pc <= 32'd0;
    always @(posedge clk) begin
        begin
            pc <= pc_next;
        end

    end
endmodule