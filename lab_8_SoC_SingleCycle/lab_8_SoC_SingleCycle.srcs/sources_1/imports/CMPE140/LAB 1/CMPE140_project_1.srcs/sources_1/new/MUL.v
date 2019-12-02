`timescale 1ns / 1ps

module MUL(
        input wire [31:0] X,
        input wire [31:0] Y,
        output reg [31:0] Z
    );
    
    always @(X or Y)
        begin
            Z <= X * Y;
        end
endmodule
