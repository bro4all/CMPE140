module gpio_top(
    input wire Clk,
    input wire Rst,
    input wire WE,
    input wire [1:0] A,
    input wire [31:0] gpI1,
    input wire [31:0] gpI2,
    input wire [31:0] WD,
    output wire [31:0] RD,
    output wire [31:0] gpO1,
    output wire [31:0] gpO2
    );
    
    wire WE1, WE2;
    wire [1:0] RdSel;
    
    gpio_ad gpio_ad (
        .A (A),
        .WE (WE),
        .WE1 (WE1),
        .WE2 (WE2),
        .RdSel (RdSel)
    );
    
    fact_reg gpO1_reg (
        .Clk (Clk),
        .Rst (Rst),
        .Load_Reg (WE1),
        .D (WD),
        .Q (gpO1)
    );
    
    fact_reg gpO2_reg (
        .Clk (Clk),
        .Rst (Rst),
        .Load_Reg (WE2),
        .D (WD),
        .Q (gpO2)
    );
    
    mux4 #(32) gpio_rd (
        .sel (RdSel),
        .a (gpI1),
        .b (gpI2),
        .c (gpO1),
        .d (gpO2),
        .y (RD)
    );
    
    endmodule