`timescale 1ns / 1ps

module Factorial_FPGA(
	input go, clk100MHz, rst, button, bit_sel,
	input [3:0] n,
	
	output wire [3:0] LEDSEL,
	output wire [7:0] LEDOUT,
	output Done, Err
	);
	
	wire clk_5KHz, CLK;
	wire [31:0] out;
	wire [3:0] BCD_0, BCD_1, BCD_2, BCD_3, BCD_4, BCD_5, BCD_6, BCD_7;
	wire [7:0] SEG_0, SEG_1, SEG_2, SEG_3, SEG_4, SEG_5, SEG_6, SEG_7, LEDmux_0, LEDmux_1, LEDmux_2, LEDmux_3;
	wire [31:0]Padded_n = {28'b0,n};
	
	Factorial_TOP Fact(
    	.CLK (CLK),
    	.rst (rst),
    	.go (go),
    	.n(Padded_n),
    	.Done (Done),
    	.Err (Err),
    	.out (out)
	);
	
	clk_gen clk(
    	.clk100MHz(clk100MHz),
    	.rst (rst),
    	.clk_5KHz (clk_5KHz)
	);
	
	button_debouncer debouncer(
    	.clk (clk_5KHz),
    	.button (button),
    	.debounced_button(CLK)
	);
	
	bin2bcd32 BCD(
    	.value (out),
    	.dig0(BCD_0),
    	.dig1(BCD_1),
    	.dig2(BCD_2),
    	.dig3(BCD_3),
    	.dig4(BCD_4),
    	.dig5(BCD_5),
    	.dig6(BCD_6),
    	.dig7(BCD_7)
	);
	
	hex_to_7seg SEG0(
    	.HEX (BCD_0),
    	.s(SEG_0)
	);
	
	hex_to_7seg SEG1(
    	.HEX (BCD_1),
    	.s(SEG_1)
	);
	
	hex_to_7seg SEG2(
    	.HEX (BCD_2),
    	.s(SEG_2)
	);
	
	hex_to_7seg SEG3(
    	.HEX (BCD_3),
    	.s(SEG_3)
	);
	
	hex_to_7seg SEG4(
    	.HEX (BCD_4),
    	.s(SEG_4)
	);
	
	hex_to_7seg SEG5(
    	.HEX (BCD_5),
    	.s(SEG_5)
	);
	
	hex_to_7seg SEG6(
    	.HEX (BCD_6),
    	.s(SEG_6)
	);
	
	hex_to_7seg SEG7(
    	.HEX (BCD_7),
    	.s(SEG_7)
	);
	
	led_mux LED (
    	.clk        	(clk_5KHz),
    	.rst        	(rst),
    	.LED0       	(LEDmux_0),
    	.LED1       	(LEDmux_1),
    	.LED2       	(LEDmux_2),
    	.LED3       	(LEDmux_3),
    	.LEDSEL     	(LEDSEL),
    	.LEDOUT     	(LEDOUT)
	);
	
	MUX2LED LEDmux(
    	.in0(SEG_0),
    	.in1(SEG_1),
    	.in2(SEG_2),
    	.in3(SEG_3),
    	.in4(SEG_4),
    	.in5(SEG_5),
    	.in6(SEG_6),
    	.in7(SEG_7),
    	.out0(LEDmux_0),
    	.out1(LEDmux_1),
    	.out2(LEDmux_2),
    	.out3(LEDmux_3),
    	.sel (bit_sel)
	);
	
	
endmodule
