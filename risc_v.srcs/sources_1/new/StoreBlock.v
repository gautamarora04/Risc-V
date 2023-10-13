`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 23:13:15
// Design Name: 
// Module Name: StoreBlock
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


module StoreBlock(
   source_2_in,
   store_select,
   out_mux
);
   input [31:0] source_2_in;
   input [2:0] store_select;
   output reg [31:0] out_mux;
    assign sw=source_2_in[31:0];
    assign sh={ 16'b0 ,source_2_in[15:0]};
    assign sb={ 24'b0 ,source_2_in[7:0]};
       always @(*) begin
        case (store_select)
            3'b000: out_mux = sw; // Select sw
            3'b001: out_mux = sh; // Select sh
            3'b010: out_mux = sb; // Select sb
            default: out_mux = 32'b0; // Default case 
        endcase
    end
  

endmodule
