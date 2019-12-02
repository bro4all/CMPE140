module gpio_top(
    input wire clk,
    input wire rst,
    input wire we,
    input wire [1:0] a,
    input wire [31:0] gpIn1,
    input wire [31:0] gpIn2,
    input wire [31:0] wd,
    output wire [31:0] RD,
    output wire [31:0] gpOut1,
    output wire [31:0] gpOut2
    );
    
    wire we1, we2;
    wire [1:0] rdsel;
    
    gpio_ad gpio_ad (
        .A (a),
        .WE (we),
        .WE1 (we1),
        .WE2 (we2),
        .RdSel (rdsel)
    );
    
    fact_reg gpO1_reg (
        .Clk (clk),
        .Rst (rst),
        .Load_Reg (we1),
        .D (wd),
        .Q (gpOut1)
    );
    
    fact_reg gpO2_reg (
        .Clk (clk),
        .Rst (rst),
        .Load_Reg (we2),
        .D (wd),
        .Q (gpOut2)
    );
    
    mux4 #(32) gpio_rd (
        .sel (rdsel),
        .a (gpIn1),
        .b (gpIn2),
        .c (gpOut1),
        .d (gpOut2),
        .y (RD)
    );
    
    endmodule