`timescale 1ns / 1ps

module Factorial_CU(
        input go, CLK, rst,
        input GT_One, GT_Twelve,
        output reg Sel, Load_Reg, Load_Cnt, OE, EN,
        output Done, Err
    );
    
    reg [2:0] CS = 0, NS;
    reg CU_Err = 0, CU_Done = 0;
    
    assign Err = GT_Twelve;
    assign Done = CU_Done;
    
    parameter 
    S0 = 3'd0,
    S1 = 3'd1, 
    S2 = 3'd2,
    S3 = 3'd3,
    S4 = 3'd4;
    
    always @(posedge CLK, posedge rst)
    begin
        if(rst) CS <= S0;
        else CS <= NS;
    end
    
    always @ (CS, go)
    begin
        case (CS)
            S0: 
            case ({go, GT_Twelve})
                2'b11: {NS, CU_Err} <= {S0, 1'b1};
                2'b10: {NS, CU_Err} <= {S1, 1'b0};
                //2'b0?:  {NS, CU_Err} <= {S0,1'b0};
                default: NS = S0;
            endcase
            S1: NS <= S2;
            S2: NS <= GT_One ? S4 : S3;
            S3: NS <= S0;
            S4: NS <= S2;
        endcase
    end
    
    //always @ (posedge CLK)
    //    CS = NS;
        
    always @ (CS)
    begin
        case (CS)
            S0: {Sel, Load_Reg, Load_Cnt, OE, EN, CU_Done} <= 6'b101010;
            S1: {Sel, Load_Reg, Load_Cnt, OE, EN, CU_Done} <= 6'b111010;
            S2: {Sel, Load_Reg, Load_Cnt, OE, EN, CU_Done} <= 6'b000000;
            S3: {Sel, Load_Reg, Load_Cnt, OE, EN, CU_Done} <= 6'b000101;
            S4: {Sel, Load_Reg, Load_Cnt, OE, EN, CU_Done} <= 6'b010010;
        endcase
    end
endmodule
