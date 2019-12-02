module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] wd_rf,
        output wire [31:0] rd3
    );
    
    wire       branch;
    wire       jump;
    wire       regdst;
    wire       regdst2;
    wire       regdst3;
    wire       we_reg;
    wire       alu_src;
    wire       memtoreg;
    wire [2:0] alu_ctrl;
    
    wire       jr;
    wire       mf_hi_lo;
    wire       mult_mux_sel;
    wire       jal_mux_sel;
    wire       MultReg;
    wire [63:0] MultOut;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .jump           (jump),
            .jr             (jr),
            .jal_mux_sel    (jal_mux_sel),
            .mult_mux_sel   (mult_mux_sel),
            .memtoreg       (memtoreg),
            .mf_hi_lo       (mf_hi_lo),
            .regdst         (regdst),
            .regdst2        (regdst2),
            .regdst3        (regdst3),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .MultReg        (MultReg),
            .alu_ctrl       (alu_ctrl),         
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3),
            .wd_rf          (wd_rf),
            .MultOut        (MultOut)
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .branch         (branch),
            .jump           (jump),
            .regdst         (regdst),
            .regdst2        (regdst2),
            .regdst3        (regdst3),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .memtoreg       (memtoreg),
            .jal_mux_sel    (jal_mux_sel),
            .alu_ctrl       (alu_ctrl),
            .mf_hi_lo       (mf_hi_lo),
            .jr             (jr),
            .MultReg        (MultReg),
            .mult_mux_sel   (mult_mux_sel)
        );

endmodule