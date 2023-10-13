`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 01:50:17
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input wire [31:25] func7,
    input wire [14:12]func3,
    // input wire [6:0] aluOp,
    output reg [3:0]ALUControl
    );
always@ (func7,func3) begin
    //  if(aluOp==7'b0110011 || aluOp==7'b0010011)
     case({func7[30],func3})
     4'b0000  : ALUControl=4'b0000; //sum
     4'b1000  : ALUControl=4'b0001; //sub
     4'b0100  : ALUControl=4'b0100; //xor
     4'b0110  : ALUControl=4'b0011; //or
     4'b0111  : ALUControl=4'b0010; //and
     4'b0001  : ALUControl=4'b0110; //Logical left
     4'b0101  : ALUControl=4'b0101; //logical right
     4'b1101  : ALUControl=4'b0111; //arithmatic right shift
     4'b0010  : ALUControl=4'b1000; //less than signed
     4'b0011  : ALUControl=4'b1001; //less than unsigned
     default: ALUControl=4'b0000;
    endcase
    // else ALUControl=4'b1010;
end

    endmodule