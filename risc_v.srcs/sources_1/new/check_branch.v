`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2023 15:21:02
// Design Name: 
// Module Name: check_branch
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


module check_branch (
    input wire [31:0] in1,       // Value from source register 1
    input wire [31:0] in2,       // Value from source register 2
    input wire [2:0]  br_sel,    // Branch type selector
    output reg branch_taken_reg    // Output indicating whether to take the branch
);

//    reg branch_taken_reg;       
    
    always @(*) begin
        
        branch_taken_reg = 0;
        
        // Implement branch conditions based on br_sel
        case (br_sel)
            3'b000: branch_taken_reg = ($signed(in1) == $signed(in2)); // BEQ
            3'b001: branch_taken_reg = ($signed(in1) != $signed(in2)); // BNE
            3'b100: branch_taken_reg = ($signed(in1) < $signed(in2)); // BLT
            3'b101: branch_taken_reg = ($signed(in1) >= $signed(in2)); // BGE
            3'b110: branch_taken_reg = (in1 < in2); // BLTU
            3'b111: branch_taken_reg = (in1 >= in2); // BGEU
            
            default: branch_taken_reg = 0;
        endcase
    end


endmodule