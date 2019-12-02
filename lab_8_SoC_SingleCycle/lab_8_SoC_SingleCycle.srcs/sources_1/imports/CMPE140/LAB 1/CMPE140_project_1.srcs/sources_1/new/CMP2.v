`timescale 1ns / 1ps

module CMP2(
        input [3:0] A, B,
        output reg GT_Twelve
    );
    
    always @(A or B)
    begin
        if(A > B) GT_Twelve = 1;
        else GT_Twelve = 0;
    end
endmodule
