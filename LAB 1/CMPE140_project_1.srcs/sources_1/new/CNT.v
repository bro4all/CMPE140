`timescale 1ns / 1ps

module CNT(
        input [3:0] D,
        input EN, CLK, Load_cnt,
        output reg [3:0] Q
    );
    
    always @(posedge CLK)
    begin
        if(EN)
        begin
            if(Load_cnt) Q <= D;
            else Q <= Q - 1'b1;
        end
    end
endmodule
