module control_unit(
    input [31:0] instruction,      // Input instruction
    input branch_taken,            // Signal indicating a branch is taken
    output [3:0] alu_control,      // ALU control signals
    output reg [2:0] store_select, // Store select signals
    output reg [2:0] data_mem_select, // Data memory select signals
    output reg [2:0] imm_select,   // Immediate select signals
    output reg [2:0] branch_select, // Branch select signals
    output  reg_write_ctrl,     // Register write control
    output reg data_mem_write_ctrl,// Data memory write control
    output reg [2:0] write_data_source, // Write data source select
    output reg A_source_select,   // A source select
    output reg B_source_select,   // B source select
    output reg [1:0] pc_source_select, // PC source select
    output [4:0] destination_reg,  // Destination register address
    output [4:0] source_reg_1,     // Source register 1 address
    output [4:0] source_reg_2,     // Source register 2 address
    output reg halt_signal        // Halt signal
);

    wire [6:0] funct7;
    wire [6:0] opcode;
    wire [2:0] funct3;
    
    // Extract opcode, funct7, source_reg_2, source_reg_1, funct3, and destination_reg from the instruction
    assign opcode = instruction[6:0];
    assign funct7 = instruction[31:25];
    assign source_reg_2 = instruction[24:20];
    assign source_reg_1 = instruction[19:15];
    assign funct3 = instruction[14:12];
    assign destination_reg = instruction[11:7];
    
    wire is_alu_reg, is_alu_imm, is_branch, is_jalr, is_jal, is_auipc, is_lui, is_load, is_store, is_system;
    
    // Instruction decode based on opcode
    assign is_alu_reg = (opcode == 7'b0110011); // rd <- rs1 OP rs2
    assign is_alu_imm = (opcode == 7'b0010011); // rd <- rs1 OP Iimm
    assign is_branch = (opcode == 7'b1100011); // if (rs1 OP rs2) PC <- PC + Bimm
    assign is_jalr   = (opcode == 7'b1100111);   // rd <- PC + 4; PC <- rs1 + Iimm
    assign is_jal    = (opcode == 7'b1101111);    // rd <- PC + 4; PC <- PC + Jimm
    assign is_auipc  = (opcode == 7'b0010111);  // rd <- PC + Uimm
    assign is_lui    = (opcode == 7'b0110111);    // rd <- Uimm
    assign is_load   = (opcode == 7'b0000011);   // rd <- mem[rs1 + Iimm]
    assign is_store  = (opcode == 7'b0100011);  // mem[rs1 + Simm] <- rs2
    assign is_system = (opcode == 7'b1110011); // special
    
    // Determine if a register write is needed
    assign reg_write_ctrl = is_alu_reg || is_alu_imm || is_load || is_lui || is_auipc || is_jal || is_jalr;
    // Select ALU operation based on ALU control signals
    assign alu_control = {funct7[5], funct3};
    
    // Branch select signals based on funct3
    always @(*) begin
        if (is_branch) begin
            case (funct3)
                3'b000: branch_select = 3'b000; // beq
                3'b001: branch_select = 3'b001; // bne
                3'b100: branch_select = 3'b011; // blt
                3'b101: branch_select = 3'b010; // bge
                3'b110: branch_select = 3'b100; // bltu
                3'b111: branch_select = 3'b101; // bgeu
                default: branch_select = 3'b111; 
            endcase
        end else if (is_jal || is_jalr) begin
            branch_select = 3'b110; // Jump instructions
        end else begin
            branch_select = 3'b111; // Default to not taken
        end
    end

    // Data memory select signals based on funct3 for load instructions
    always @(*) begin
        if (is_load) begin
            case (funct3)
                3'b000: data_mem_select = 3'b000; // lb
                3'b001: data_mem_select = 3'b001; // lh
                3'b010: data_mem_select = 3'b010; // lw
                3'b100: data_mem_select = 3'b100; // lbu
                3'b101: data_mem_select = 3'b101; // lhu
                default: data_mem_select = 3'b111; // Default to no data memory access
            endcase
        end else begin
            data_mem_select = 3'b111; // Default to no data memory access
        end
    end

    // Store select signals based on funct3 for store instructions
    always @(*) begin
        if (is_store) begin
            case (funct3[1:0])
                2'b00: store_select = 2'b00; // sb
                2'b01: store_select = 2'b01; // sh
                2'b10: store_select = 2'b10; // sw
                default: store_select = 2'b11; // Default to no data memory access
            endcase
        end else begin
            store_select = 2'b11; // Default to no data memory access
        end
    end

    // Immediate select signals based on instruction type
    always @(*) begin
        if (is_alu_imm || is_load) begin
            imm_select = 3'b000; // I-type and load instructions
        end else if (is_branch) begin
            imm_select = 3'b010; // B-type instructions
        end else if (is_store) begin
            imm_select = 3'b001; // S-type instructions
        end else if (is_jal || is_jalr) begin
            imm_select = 3'b100; // J-type instructions
        end else if (is_lui || is_auipc) begin
            imm_select = 3'b011; // U-type instructions
        end else begin
            imm_select = 3'b111; // Default to no immediate value
        end
    end

    // Data memory write control signal for store instructions
    always @(*) begin
        if (is_store) begin
            data_mem_write_ctrl = 1'b1;
        end else begin
            data_mem_write_ctrl = 1'b0;
        end
    end

    // A and B source select signals
    always @(*) begin
        if (is_alu_reg) begin
            A_source_select = 1'b0; // A source is source_reg_1
            B_source_select = 1'b0; // B source is source_reg_2
        end else if (is_branch || is_auipc || is_jal) begin
            A_source_select = 1'b1; // A source is PC
            B_source_select = 1'b1; // B source is immediate
        end else if (is_jalr || is_alu_imm || is_load || is_store) begin
            A_source_select = 1'b0; // A source is source_reg_1
            B_source_select = 1'b1; // B source is immediate
        end else begin
            A_source_select = 1'b0; // Default to source_reg_1 for A source
            B_source_select = 1'b0; // Default to source_reg_2 for B source
        end
    end

    // Write data source select signal
    always @(*) begin
        if (is_alu_reg || is_alu_imm) begin
            write_data_source = 2'b00; // ALU result
        end else if (is_load) begin
            write_data_source = 2'b01; // Load data
        end else if (is_jal || is_jalr) begin
            write_data_source = 2'b10; // PC + 4
        end else if (is_lui) begin
            write_data_source = 2'b11; // immediate
        end else if (is_auipc) begin
            write_data_source = 3'b100; // PC + U-type immediate
        end else begin
            write_data_source = 3'b111; // Default to no write data source
        end
    end

    // PC source select signal
    always @(*) begin
        if (is_jalr) begin
            pc_source_select = 2'b01;  // Load ALU result to PC
        end else if (is_jal || branch_taken) begin
            pc_source_select = 2'b10;  // Load PC + immediate to PC
        end else begin
            pc_source_select = 2'b00;  // PC = PC + 4
        end
    end

    // Halt signal
    always @(*) begin
        if (is_system) begin
            halt_signal = 1'b1;
        end else begin
            halt_signal = 1'b0;
        end
    end

endmodule