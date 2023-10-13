`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 23:07:49
// Design Name: 
// Module Name: datapath
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


module datapath( // 
                input clk,
                 input rst,
                 // control signal (ctrl -> data path)
                 input [3:0] alu_control,
                 input [4:0] rs1_addr,
                 input [4:0] rs2_addr,
                 input [4:0] rd_addr,
                 input [2:0] store_sel,
                 input [2:0] dm_sel,
                 input [2:0] imm_sel,
                 input[1:0] wd_src,
                 input [2:0] br_sel,
                 input reg_write,
                 input dm_write,
                 input A_sel,
                 input B_sel,
                 input [1:0] pc_src,
                
                 // control signal (ctrl <- data path)
                 output [31:0] instr,
                 output [31:0] result,
                 output br_taken
               );

              wire [31:0] current_addr;
            
              wire [31:0] pc_plus4,imm_out_addr,alu_out;
              //
              wire [31:0] load_in; // output from load block
              wire [31:0] load_out; // wire for data mem
              assign load_in=load_out;
              wire [31:0] pc_next;
                
              pc_input pcmux(.pc_mux_out(pc_next),.pc_add_4(pc_plus4),.imm_out_addr(imm_out_addr),.alu_out(alu_out),.PC_src(pc_src));
            // prog counter
              program_counter pc(.clk(clk),.rst(rst),.pc_next(pc_next),.pc(current_addr)); 

            // pc adder
              assign pc_plus4 = current_addr + 4;

            //   instruction memory
             instr_mem ins_mem(.instr_addr(current_addr),.instr_data(instr));
            
              wire [31:0]  instr_fetched;
              wire [31:0]Imm_out;
              assign instr_fetched=instr;

//             wire [31:0] imm_out_addr;
//////////////////////////////////////load in should be changed ////////////////////////////
              sign_extension sign_ext(.out_mux(Imm_out),.out_b(imm_out_addr),.instr(instr_fetched),.imm_select(imm_sel),.pc_4(pc_plus4));
              
              wire [31:0] reg_in;
             register_mux reg_mux(.output_reg(reg_in),.pc_plus_4(pc_plus4),.alu_out(alu_out),.store_block_out(load_in),.immediate_out(Imm_out),.select_line(wd_src));

            wire [31:0] A,B;

            // reg file
             reg_file registerfile(.rs1(A),.rs2(B),.rs1_adds(rs1_addr),.rs2_adds(rs2_addr),.rs3_adds(rd_addr),.reg_write(reg_write),.clk(clk),.w_data(result));

            wire [31:0] alu_A,alu_B;
            assign alu_A= (A_sel)? current_addr:A;
            assign alu_B= (B_sel)?Imm_out:B; 
    
            wire [31:0] store_out;
  
            alu alu(.A(alu_A),.B(alu_B),.ALUControl(alu_control),.Result(alu_out));

            assign result=alu_out;
              
 
            wire [31:0] dm_out;
            data_mem data_memory(.RD(dm_out),.WD3(store_out),.A(alu_out),.clk(clk),.WE(dm_write));

            loadblock load_unit(.data_memory(dm_out),.block_output(load_out),.dm_select(dm_sel));
// source_2_in,
   //store_select,
   //out_mux
            StoreBlock store_unit (.source_2_in(B),.out_mux(store_out),.store_select(store_sel));
            
            
            check_branch branch_unit (.in1(A),.in2(A),.br_sel(br_sel),.branch_taken_reg(br_taken));




endmodule