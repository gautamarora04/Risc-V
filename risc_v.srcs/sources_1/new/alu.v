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


module alu(A,B,ALUControl,Result);

input [31:0]A,B;
input [3:0]ALUControl;
output [31:0] Result;

assign Result = (ALUControl[3:0]==4'b0000) ?A+B: 
               (ALUControl[3:0]==4'b0001)?A-B: 
               (ALUControl[3:0]==4'b0010)?A&B:
               (ALUControl[3:0]==4'b0011)?A|B:
               (ALUControl[3:0]==4'b0100)?A^B:
               (ALUControl[3:0]==4'b0101)?A>>1:
               (ALUControl[3:0]==4'b0110)?A<<1:
               (ALUControl[3:0]==4'b0111)?A>>>1:
               (ALUControl[3:0]==4'b1000)?($signed(A)<$signed(B))?1:0:
               (ALUControl[3:0]==4'b1001)?(A<B)?1:0:0;
            //    (ALUControl[3:0]==4'b1010)?B:0;


endmodule