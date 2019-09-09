`timescale 1ns / 1ps

module factorial_FPGA#(parameter DATA_WIDTH=32)(
	input GO, clk_IN, rst_IN, button_IN, sel_LEDmux,
	input [3:0] n,
	
	output wire [3:0] LEDSEL,
	output wire [7:0] LEDOUT,
	output DoneLED, ErrorLED
	);
	
	wire clk_internal, button_internal;
	wire [DATA_WIDTH-1:0] product_F;
	wire [3:0] out_BCD_0,out_BCD_1,out_BCD_2,out_BCD_3,out_BCD_4,out_BCD_5,out_BCD_6,out_BCD_7;
	wire [7:0] out_SEG_0,out_SEG_1,out_SEG_2,out_SEG_3,out_SEG_4,out_SEG_5,out_SEG_6,out_SEG_7, out_LEDmux_0, out_LEDmux_1, out_LEDmux_2, out_LEDmux_3;
	supply0[27:0] nZero;
	wire [DATA_WIDTH-1:0]nModified = {nZero,n};
	
	clk_gen CLK(
    	.clk100MHz(clk_IN),
    	.rst (rst_IN),
    	.clk_5KHz (clk_internal),
    	.clk_4sec()
	);
	
	button_debouncer button(
    	.clk (clk_internal),
    	.button (button_IN),
    	.debounced_button(button_internal)
	);
	
	Factorial_TOP fact(
    	.CLK (button_internal),
    	//.RST (rst_IN),
    	.go (GO),
    	.n(nModified),
    	.Done (DoneLED),
    	.Err (ErrorLED),
    	.out (product_F)
	);
	
	bin2bcd32 BCD(
    	.value (product_F),
    	.dig0(out_BCD_0),
    	.dig1(out_BCD_1),
    	.dig2(out_BCD_2),
    	.dig3(out_BCD_3),
    	.dig4(out_BCD_4),
    	.dig5(out_BCD_5),
    	.dig6(out_BCD_6),
    	.dig7(out_BCD_7)
	);
	
	hex_to_7seg SEG0(
    	.HEX (out_BCD_0),
    	.s(out_SEG_0)
	);
	
	hex_to_7seg SEG1(
    	.HEX (out_BCD_1),
    	.s(out_SEG_1)
	);
	
	hex_to_7seg SEG2(
    	.HEX (out_BCD_2),
    	.s(out_SEG_2)
	);
	
	hex_to_7seg SEG3(
    	.HEX (out_BCD_3),
    	.s(out_SEG_3)
	);
	
	hex_to_7seg SEG4(
    	.HEX (out_BCD_4),
    	.s(out_SEG_4)
	);
	
	hex_to_7seg SEG5(
    	.HEX (out_BCD_5),
    	.s(out_SEG_5)
	);
	
	hex_to_7seg SEG6(
    	.HEX (out_BCD_6),
    	.s(out_SEG_6)
	);
	
	hex_to_7seg SEG7(
    	.HEX (out_BCD_7),
    	.s(out_SEG_7)
	);
	
	led_mux LED (
    	.clk        	(clk_internal),
    	.rst        	(rst_IN),
    	.LED0       	(out_LEDmux_0),
    	.LED1       	(out_LEDmux_1),
    	.LED2       	(out_LEDmux_2),
    	.LED3       	(out_LEDmux_3),
    	.LEDSEL     	(LEDSEL),
    	.LEDOUT     	(LEDOUT)
	);
	
	MUX2LED LEDmux(
    	.in0(out_SEG_0),
    	.in1(out_SEG_1),
    	.in2(out_SEG_2),
    	.in3(out_SEG_3),
    	.in4(out_SEG_4),
    	.in5(out_SEG_5),
    	.in6(out_SEG_6),
    	.in7(out_SEG_7),
    	.out0(out_LEDmux_0),
    	.out1(out_LEDmux_1),
    	.out2(out_LEDmux_2),
    	.out3(out_LEDmux_3),
    	.sel (sel_LEDmux)
	);
	
	
endmodule
