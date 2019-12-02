`timescale 1ns / 1ps

module mf_reg(
    input wire  we,
    input wire [31:0] D,
    output reg [31:0] Q

    );
    
    always @ *
        case(we)
        1'b00: Q <= Q;
        1'b01: Q <= D;
    endcase
endmodule
