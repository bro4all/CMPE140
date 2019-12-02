`timescale 1ns / 1ps

module Factorial_DP(
        input [3:0] n,
        input Sel, Load_Reg, Load_Cnt, OE, EN, CLK,
        output GT_One, GT_Twelve,
        output [31:0] out
    );
    
    wire [3:0] CNT_out;
    wire [31:0] MUX_out;
    wire [31:0] REG_out;
    wire [31:0] MUL_out;
    
    MUX MUX (
        .sel (Sel),
        .in1 (32'b1),
        .in0 (MUL_out),
        .out (MUX_out)
    );
    
    REG REG (
        .D (MUX_out),
        .Load_reg (Load_Reg),
        .CLK (CLK),
        .Q (REG_out)
    );
    
    MUL MUL (
        .X (REG_out),
        .Y ({28'b0, CNT_out}),
        .Z (MUL_out)
    );
    
    CMP1 CMP1 (
        .A (CNT_out),
        .B (4'b0001),
        .GT_One (GT_One)
    );
    
    CMP2 CMP2 (
        .A (n),
        .B (4'b1100),
        .GT_Twelve (GT_Twelve)
    );
    
    CNT CNT (
        .D (n),
        .Load_cnt (Load_Cnt),
        .EN (EN), 
        .CLK (CLK),
        .Q (CNT_out)
    );
    
    MUX BUF (
        .in0 (32'b0),
        .in1 (REG_out),
        .sel(OE),
        .out (out)
    );
endmodule
