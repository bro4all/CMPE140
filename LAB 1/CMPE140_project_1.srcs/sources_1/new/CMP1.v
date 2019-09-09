//Comparator to see if current count is greater than 1
`timescale 1ns / 1ps

module CMP1(
        input [31:0] A, B,
        output reg GT_One
    );
    
    always @(A or B)
    begin
        if(A > B) GT_One = 1;
        else GT_One = 0;
    end
endmodule

