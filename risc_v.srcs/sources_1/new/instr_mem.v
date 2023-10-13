`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 01:57:51
// Design Name: 
// Module Name: instr_mem
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


module instr_mem( 
                  input [31:0] instr_addr,
                  output reg [31:0] instr_data

                  );
                  
  reg [31:0] instr_mem [0:15];

  initial $readmemh ("program.mem",instr_mem);

  always @(instr_addr)
    instr_data= instr_mem[instr_addr>>2];
 
endmodule
