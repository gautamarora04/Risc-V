`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2023 17:22:11
// Design Name: 
// Module Name: cpu
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
module riscv_cpu(
    input clk,
    input rst,
    output [31:0] result
);

    wire [31:0] instr;
    wire [4:0] rs1, rs2, rd;
    wire [3:0] alu_control;
    wire [2:0] wd_src, dm_sel, store_sel, imm_sel, br_sel;
    wire [1:0] pc_src;
    wire br_taken;

    // Instantiate the control unit (CU) and connect its inputs and outputs
    control_unit ControlUnit (
        .instruction(instr),
        .branch_taken(br_taken),
        .alu_control(alu_control),
        .store_select(store_sel),
        .data_mem_select(dm_sel),
        .imm_select(imm_sel),
        .reg_write_ctrl(reg_write), // This signal is missing in your code, make sure it's defined
        .data_mem_write_ctrl(dm_write),   // This signal is missing in your code, make sure it's defined
        .write_data_source(wd_src),
        .branch_select(br_sel),
        .A_source_select(A_sel),
        .B_source_select(B_sel),
        .pc_source_select(pc_src),
        .destination_reg(rd),
        .source_reg_1(rs1),
        .source_reg_2(rs2),
        .halt_signal(hlt)              // This signal is missing in your code, make sure it's defined
    );

    // Instantiate the data path (DU) and connect its inputs and outputs
    datapath DataPath (
        .clk(clk),
//        .hlt(hlt),             // This signal is missing in your code, make sure it's defined
//        .preset(preset),
        .rst(rst),
        .alu_control(alu_control),
        .rs1_addr(rs1),
        .rs2_addr(rs2),
        .rd_addr(rd),
        .br_sel(br_sel),
        .store_sel(store_sel),
        .dm_sel(dm_sel),
        .imm_sel(imm_sel),
        .reg_write(reg_write), 
        .dm_write(dm_write),   // This signal is missing in your code, make sure it's defined
        .wd_src(wd_src),
        .A_sel(A_sel),
        .B_sel(B_sel),
        .pc_src(pc_src),
//        .start_addr(32'h0),
        .instr(instr),
        .result(result),
        .br_taken(br_taken)
    );

endmodule
