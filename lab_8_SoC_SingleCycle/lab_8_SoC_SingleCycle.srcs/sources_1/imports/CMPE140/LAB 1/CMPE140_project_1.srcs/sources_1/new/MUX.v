`timescale 1ns / 1ps

module MUX(
        input sel, 
        input [31:0] in0,
        input [31:0] in1,
        output reg [31:0] out
    );
    
    always@(in0, in1, sel)
    begin
        if(sel) out <= in1;
        else
            begin
                out <= in0;
            end
    end
endmodule
