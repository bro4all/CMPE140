module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire        jump,
        output wire        regdst,
        output wire        regdst2,
        output wire        regdst3,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        memtoreg,
        output wire        jal_mux_sel,
        output wire [2:0]  alu_ctrl,
        
        // auxdec
        output wire mf_hi_lo,
        output wire jr,
        output wire MultReg,
        output wire mult_mux_sel
        
        
    );
    
    wire [1:0] alu_op;
    wire we_reg_to_ad;

    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .regdst2        (regdst2),
        .regdst3        (regdst3), 
        .we_reg_pre     (we_reg_to_ad),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .memtoreg       (memtoreg),
        .jal_mux_sel    (jal_mux_sel),
        .alu_op         (alu_op)
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .we_reg_pre     (we_reg_to_ad),
        .alu_ctrl       (alu_ctrl),
        .mf_hi_lo       (mf_hi_lo),
        .jr             (jr),
        .MultReg        (MultReg),
        .mult_mux_sel   (mult_mux_sel),
        .regdst         (regdst),
        .we_reg         (we_reg)
    );

endmodule