`timescale 1ns / 1ps

module SoC_singleCycle_top(        
    input  wire        clk,
    input  wire        rst,
    input  wire [4:0]  ra3,
    
    input wire [31:0] gpIn1,
    input wire [31:0] gpIn2,
    
    //output wire [31:0] rd_dm
    output wire [31:0] rd3,
    output wire [31:0] instr,
    output wire [31:0] pc_current,
    output wire        we_dm,
    output wire [31:0] wd_dm,
    output wire [31:0] alu_out,
    output wire [31:0] gpOut1,
    output wire [31:0] gpOut2,
    output wire [31:0] rd_dm
);

//SoC Mux
wire [31:0] DONT_USE;
wire [31:0] DataMem; // Output data from the data memory module
wire [31:0] FactData; // Output data from the factorial module
wire [31:0] gpioData; // Output data from the gpio module
//wire [31:0] SoC_mux_RD;
//wire [31:0] rd_dm;

//Decoder
wire we1;
wire we2;
wire wem;
wire [1:0] rdsel;

//wire [31:0] instr;
//wire [31:0] pc_current;
//wire        we_dm;
//wire [31:0] wd_dm;
//wire [31:0] alu_out;


mips mips (
        .clk            (clk),
        .rst            (rst),
        .ra3            (ra3),
        .instr          (instr),
        .rd_dm          (rd_dm),
        .we_dm          (we_dm),
        .pc_current     (pc_current),
        .alu_out        (alu_out),
        .wd_dm          (wd_dm),
        .rd3            (rd3)
        
        /*
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
              */
    );

imem imem (
        .a              (pc_current[7:2]),
        .y              (instr)
    );

dmem dmem (
        .clk            (clk),
        .we             (wem),
        .a              (alu_out[7:2]),
        .d              (wd_dm),
        .q              (DataMem)
    );
    
SoC_mux SoC_mux(
        .DataMem        (DataMem),
        .FactData       (FactData),
        .gpioData       (gpioData),
        .rdsel          (rdsel),
        .SoC_mux_RD     (rd_dm)
    );
    
fact_top factorial(
        .A              (alu_out[3:2]),
        .WD             (wd_dm[3:0]),
        .we             (we1),
        .rst            (rst),
        .clk            (clk),
        .RD             (FactData)
    );    
    
 gpio_top gpio(
        .clk            (clk),
        .rst            (rst),
        .wd             (wd_dm),
        .gpIn1          (gpIn1),
        .gpIn2          (gpIn2),
        .we             (we2),
        .a              (alu_out[3:2]),
        .RD             (gpioData),
        .gpOut1         (gpOut1),
        .gpOut2         (gpOut2)
    );   
    
 SoC_AddressDecoder SoC_AddressDecoder(
        .clk            (clk),
        .rst            (rst),
        .we             (we_dm),
        .a              (alu_out),
        .we2            (we2),
        .we1            (we1),
        .wem            (wem),
        .rdsel          (rdsel)
        
        /*    input clock,
        input reset,
        input [31:0] a,
        input we, 
        output reg wem,
        output reg we1,
        output reg  we2,
        output reg [1:0] rdsel*/
    );
endmodule
