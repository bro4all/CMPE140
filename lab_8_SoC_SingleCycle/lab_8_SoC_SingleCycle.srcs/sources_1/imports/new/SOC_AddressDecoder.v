`timescale 1ns / 1ps
module SoC_AddressDecoder(
    input clk,
    input rst,
    input [31:0] a,
    input we, 
    output reg wem,
    output reg we1,
    output reg  we2,
    output reg [1:0] rdsel
    );
    
always @ (*)
    case(a)
    32'h0000_08xx:
    begin
        wem <= 0;
        we1 <= 1;
        we2 <= 0;
        rdsel =2'b10;
    end
    
    32'h0000_09xx:
    begin
        wem <= 0;
        we1 <= 0;
        we2 <= 1;
        rdsel = 2'b11;
    end
    
    default:
    begin
        wem <= 1;
        we1 <= 0;
        we2 <= 0;
        rdsel = 2'b00;
    end
    endcase


endmodule
