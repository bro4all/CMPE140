`timescale 1ns / 1ps

module REG(
        input CLK, Load_reg,
        input [31:0] D,
        output reg [31:0] Q
    );
    
    always@ (posedge CLK)
    begin
        if(Load_reg) Q <= D;
    end
endmodule
