`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2023 16:46:01
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
// inputs 
reg [31:0] a, b;
reg [2:0] alucontrol;

//outputs
wire [31:0] out;
integer i;

alu test_unit(a, b, alucontrol, out);

initial begin
    // hold reset state for 100 ns.
      a = 8'h0A;
      b = 4'h02;
      alucontrol = 3'h0;
      for (i=0;i<=7;i=i+1)
      begin
      #10;
       alucontrol = alucontrol + 3'h01;
      end;
      a = 8'h06;
      b = 8'h0A;

end
endmodule
