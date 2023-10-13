`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2023 00:10:11
// Design Name: 
// Module Name: data_mem
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



module data_mem(A,WD3,clk,WE,RD);
//input Address,write enble
//if we high then it will store at Adress A
// if we is low then at adress data mem will be show at rd
    input [31:0] A,WD3;
    input clk,WE;
    output [31:0] RD;
    reg [31:0] data_MEM[1023:0];
    //read
    assign RD=(WE==1'b0)?data_MEM[A]:32'h00000000;
    //write so at positive edge of clk and wE is on to use data apni memo ki adress pe 
    always @(posedge clk ) 
    begin
      if(WE)
       data_MEM[A]<= WD3;
    end
    
    
    endmodule


