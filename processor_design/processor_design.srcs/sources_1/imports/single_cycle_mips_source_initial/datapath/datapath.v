module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire        jr,
        input  wire        jal_mux_sel,
        input  wire        mult_mux_sel,
        input  wire        memtoreg,
        input  wire        mf_hi_lo,
        input  wire        regdst,
        input  wire        regdst2,
        input  wire        regdst3,
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire        MultReg,
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3,
        output wire [31:0] wd_rf,
        output wire [63:0] MultOut
    );

    wire [4:0]  rf_wa;
    wire [4:0]  reg_write1;
    wire [4:0]  reg_write2;
    wire        pc_src;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_pre2;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] ja;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire        zero;
    wire [31:0] HiRegToMux;
    wire [31:0] LoRegToMux;
    wire [31:0] MultMuxOut;
    wire [31:0] shift_to_mux;
    wire [31:0] to_jal;
    wire [31:0] to_shift;
    wire [31:0] to_mult;
       
    
    assign pc_src = branch & zero;
    assign ba = {sext_imm[29:0], 2'b00};
    //add shift left 2 for jump address
    assign ja = {instr[25:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //

    
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );
        
    mf_reg  HiReg (
            .we             (MultReg),
            .D              (MultOut[63:32]),
            .Q              (HiRegToMux)
        );
        
    mf_reg  LoReg (
            .we             (MultReg),
            .D              (MultOut[31:0]),
            .Q              (LoRegToMux)
        );
        
    mux2 #(32) mf_mux (
            .sel            (mf_hi_lo),
            .a              (LoRegToMux),
            .b              (HiRegToMux),
            .y              (MultMuxOut)
        );
            
    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre),
            .b              ({pc_plus4[31:28],ja[27:0]}),
            .y              (pc_pre2)
        );
        
    mux2 #(32) jr_mux (
            .sel            (jr),
            .a              (pc_pre2),
            .b              (alu_pa),
            .y              (pc_next)
       );
       


    // --- RF Logic --- //
    mux2 #(5) reg_dst1 (
            .sel            (regdst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .y              (reg_write1)
        );
    
    mux2 #(32) reg_dst2 (
            .sel            (regdst2),
            .a              (reg_write1),
            .b              (5'b11111),
            .y              (reg_write2)
        );
    mux2 #(32) reg_dst3 (
            .sel            (regdst3),
            .a              (reg_write2),
            .b              (0),
            .y              (rf_wa)
        );
        
    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (rf_wa),
            .wd             (wd_rf),
            .rd1            (alu_pa),
            .rd2            (wd_dm),
            .rd3            (rd3)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );
        
   

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            .a              (wd_dm),
            .b              (sext_imm),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrl),
            .shamt          (instr[10:6]),
            .a              (alu_pa),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out),
            .y_mult         (MultOut)
        );
        

    // --- MEM Logic --- //
    mux2 #(32) mem_mux (
            .sel            (memtoreg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (to_jal)
        );

    mux2 #(32) jal_mux (
            .sel            (jal_mux_sel),
            .a              (to_jal),
            .b              (pc_plus4),
            .y              (to_mult)
        );
      
    mux2 #(32) mult_mux (
            .sel            (mult_mux_sel),
            .a              (to_mult),
            .b              (MultMuxOut),
            .y              (wd_rf)
        );

endmodule