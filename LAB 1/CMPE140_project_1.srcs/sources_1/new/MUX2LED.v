`timescale 1ns / 1ps

module MUX2LED(
    input sel,
    input [7:0] in0, in1, in2, in3, in4, in5, in6, in7,
    output [7:0] out0, out1, out2, out3
    );
    
    assign out0 = (sel == 1'b0)? in0:in4;
    assign out1 = (sel == 1'b0)? in1:in5;
    assign out2 = (sel == 1'b0)? in2:in6;
    assign out3 = (sel == 1'b0)? in3:in7;
endmodule