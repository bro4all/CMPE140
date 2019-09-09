`timescale 1ns / 1ps

module Factorial_TOP(
        input [31:0] n,
        input go, CLK, rst,
        output Done, Err, 
        output [31:0] out
    );
    
    wire Sel, Load_Reg, Load_Cnt, OE, EN, GT_One, GT_Twelve;
    
    Factorial_DP DP (
        .n (n),
        .Sel (Sel),
        .Load_Reg (Load_Reg),
        .Load_Cnt (Load_Cnt),
        .OE (OE),
        .EN (EN),
        .CLK (CLK),
        .GT_One (GT_One),
        .GT_Twelve (GT_Twelve),
        .out (out)
    );
    
    Factorial_CU CU (
        .go (go), 
        .rst (rst),
        .Sel (Sel),
        .Load_Reg (Load_Reg),
        .Load_Cnt (Load_Cnt),
        .OE (OE),
        .EN (EN),
        .GT_One (GT_One),
        .GT_Twelve (GT_Twelve),
        .Done (Done),
        .Err (Err),
        .CLK (CLK)
    );
endmodule
