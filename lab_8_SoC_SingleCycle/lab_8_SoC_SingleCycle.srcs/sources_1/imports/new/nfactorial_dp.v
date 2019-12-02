`timescale 1ns / 1ps
module nfactorial_dp(
    input clk,
    input sel, ld_cnt,en,ld_reg,oe,done,
    input [3:0] n,
    output gt, 
    output error,
    //outputs used for verification
    output [3:0] q_cnt,
    output [31:0] q_reg,
    output [31:0] d_reg,
    output [31:0] p,
    output [31:0] out
    );
    
    parameter WIDTH = 4;
    assign p = q_cnt * q_reg;

    
    counter CNT(
        .clk (clk),
        .en (en),
        .ld (ld_cnt),
        .d (n),
        .q (q_cnt)
    );
    
    comp CMPERR(
        .a (n),
        .b (12),
        .gt (error)
    );
    
    comp CMP(
        .a (q_cnt),
        .b (1),
        .gt (gt)
    );
    
    mux2 #(32) MUX(
        .sel (sel),
        .a (p),
        .b (1),
        .y (d_reg)
    );
    
    register #(32)REG(
        .ld (ld_reg),
        .clk (clk),
        .d (d_reg),
        .q (q_reg)
    );
        
    buff #(32)BUF(
        .oe (oe),
        .d (q_reg),
        .out (out)
    );

endmodule