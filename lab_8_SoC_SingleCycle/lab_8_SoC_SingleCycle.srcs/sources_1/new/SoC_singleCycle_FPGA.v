`timescale 1ns / 1ps

module SoC_singleCycle_FPGA(
    input wire clk,
    input wire button,
    input wire clk100MHz,
    input wire rst,
    input wire [3:0] n,
    input wire Sel,
    output [3:0] an,
    output [7:0] sseg,
    output wire fact_err,
    output wire fact_err2,
    output wire fact_err3,
    output wire fact_err4,
   // input  wire [7:0] switches,
    output wire dispSe
    );
    
    reg [15:0] reg_hex;
   
    wire [31:0] gpIn1;
    wire [31:0] gpOut1;
    wire [31:0] gpOut2;
    wire clk_5KHz;
    wire [15:0] hex;
    supply1 [7:0] Vcc;
    wire clk_sec;
    wire clk_pb;
    wire [7:0] digit3;
    wire [7:0] digit2;
    wire [7:0] digit1;
    wire [7:0] digit0;
//    wire digit4;
//    wire digit5;
//    wire digit6;
//    wire digit7;
    
//    wire [31:0] pc_current;
//    wire [31:0] instr;
//    wire [31:0] alu_out;
//    wire [31:0] wd_dm;
//    wire [31:0] rd_dm;
//    wire [31:0] dispData;

    assign fact_err = gpOut1[0];
        assign fact_err2 = gpOut1[0];
        assign fact_err3 = gpOut1[0];
        assign fact_err4 = gpOut1[0];
        assign dispSe   = gpOut1[4];   
    
    clk_gen clk_gen(
        .clk100MHz          (clk),
        .rst                (rst),
        .clk_4sec           (clk_sec),
        .clk_5KHz           (clk_5KHz)
        );
        
    button_debouncer bd (
        .clk                (clk_5KHz),
        .button             (button),
        .debounced_button   (clk_pb)
        );        
        
    SoC_singleCycle_top system(
        .rst                (rst),
        .clk                (clk_pb),
        .gpIn1              ({{(27){1'b0}}, Sel, n}),
        .gpIn2              (gpOut1),
        .gpOut1             (gpOut1),
        .gpOut2             (gpOut2)
        );
        
    mux2 #(16) mux_gpO(
        .sel                (gpOut1[4]),
        .a                  (gpOut2[15:0]),
        .b                  (gpOut2[31:16]),
        .y                  (hex)
        );
        
    
        
    hex_to_7seg hex0(
        .HEX                (hex[3:0]), 
        .s                  (digit0)
        );

    hex_to_7seg hex1(
        .HEX                (hex[7:4]), 
        .s                  (digit1)
        );
        
     hex_to_7seg hex2(
        .HEX                (hex[11:8]), 
        .s                  (digit2)
        );
            
    hex_to_7seg hex3(
        .HEX                (hex[15:12]), 
        .s                  (digit3)
        );
        
        
    led_mux SoC_led_mux(
        .clk                (clk_5KHz), 
        .rst                (rst),
        .LED3               (digit3), 
        .LED2               (digit2), 
        .LED1               (digit1), 
        .LED0               (digit0), 
        .LEDSEL             (an), 
        .LEDOUT             (sseg)
        );      
                                 
        
        
endmodule
