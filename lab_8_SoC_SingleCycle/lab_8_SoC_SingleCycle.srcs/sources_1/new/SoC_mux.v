`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 07:17:20 PM
// Design Name: 
// Module Name: SoC_mux
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


module SoC_mux(
input [31:0] DataMem , FactData, gpioData,
input [1:0] rdsel,
//input [31:0] nw, 
output reg [31:0] SoC_mux_RD
);

always @ (*) 
begin 
    case(rdsel) 
    2'b00:    SoC_mux_RD = DataMem ; 
    2'b01:    SoC_mux_RD = DataMem ; 
    2'b10:    SoC_mux_RD = FactData;
    2'b11:    SoC_mux_RD = gpioData; 
    default:  SoC_mux_RD = 31'bx;
    endcase   
end 

endmodule
