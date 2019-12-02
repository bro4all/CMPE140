`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 07:28:26 PM
// Design Name: 
// Module Name: SoC_ad
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SoC_ad(
    input  wire [31:0] A,
    input  wire WE,
    output reg WE1, 
    output reg WE2,
    output reg WEM, 
    output reg [1:0] RdSel 
    );
    
    always @ (*)
    begin
    if(A >= 32'h0 && A <= 32'hfc)
    begin
        WE1 = 1'b0; 
        WE2 = 1'b0;
        WEM = WE;
        RdSel = 2'b00;
    end      
    if(A >= 32'h800 && A <= 32'h80c)
    begin
        WE1 = WE;
        WE2 = 1'b0; 
        WEM = 1'b0;
        RdSel = 2'b10;
    end
    if(A >= 32'h900 && A <= 32'h90c)
    begin
        WE1 = 1'b0;
        WE2 = WE;
        WEM = 1'b0;
        RdSel = 2'b11;
    end       
    //        else
    //        begin
    //            WE1 = 1'b0;
    //            WE2 = 1'b0;
    //            WEM = 1'b0;
    //            RdSel = 2'bxx;
    //        end
    end
endmodule
