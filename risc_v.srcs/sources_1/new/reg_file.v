`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 18:43:24
// Design Name: 
// Module Name: reg_file
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


module reg_file (
    output  [31:0] rs1,
    output  [31:0] rs2,
    input   [4:0] rs1_adds,
    input   [4:0] rs2_adds,
    input   [4:0] rs3_adds,
    input    reg_write ,
    input clk,
    input   [31:0] w_data
    
    
);
   reg [31:0]  regs [31:0] ;
   initial $readmemh ("init_reg.mem",regs);
   
   always @(posedge clk)
   begin
        regs[0] <= 32'h0;
        regs[1] <= 32'h0;
		if (reg_write) regs[rs3_adds] <= w_data;

   end

   assign rs1 =  regs[rs1_adds];
   assign rs2 =  regs[rs2_adds];
    
endmodule