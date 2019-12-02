module datapath_TB;

        reg        clk_tb;
        reg        rst_tb;
        reg        branch_tb;
        reg        jump_tb;
        reg        jr_tb;
        reg        jal_mux_sel_tb;
        reg        mult_mux_sel_tb;
        reg        memtoreg_tb;
        reg        mf_hi_lo_tb;
        reg        regdst_tb;
        reg        regdst2_tb;
        reg        regdst3_tb;
        reg        we_reg_tb;
        reg        alu_src_tb;
        reg        MultReg_tb;
        reg [2:0]  alu_ctrl_tb;
        reg [4:0]  ra3_tb;
        reg [31:0] instr_tb;
        reg [31:0] rd_dm_tb;
        wire [31:0] pc_current_tb;
        wire [31:0] alu_out_tb;
        wire [31:0] wd_dm_tb;
        wire [31:0] rd3_tb;
        wire [31:0] wd_rf_tb;
        wire [63:0] MultOut_tb;
        
        
endmodule
