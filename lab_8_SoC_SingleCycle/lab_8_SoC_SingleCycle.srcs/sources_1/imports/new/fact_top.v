module fact_top(
     input wire Clk, Rst,
     input wire [1:0] A,
     input wire WE,
     input wire [3:0] WD,
     output wire [31:0] RD
     );

     wire WE1, WE2;
     wire [1:0] RdSel;
     wire go_out;
     wire [3:0] n_out;
     wire GoPulseCmb, GoPulse_out;
     wire Done, Err, ResDone, ResErr;
     wire [31:0] nf, Result;
     
     assign GoPulseCmb = WE2 & WD[0];

     fact_ad fact_ad (
         .A (A),
         .WE (WE),
         .WE1 (WE1),
         .WE2 (WE2),
         .RdSel (RdSel)
     );
    
     fact_reg #(4) n (
         .Clk (Clk),
         .Rst (Rst),
         .D (WD),
         .Load_Reg (WE1),
         .Q (n_out)
     );
    
     fact_reg #(1) Go (
         .Clk (Clk),
         .Rst (Rst),
         .D (WD[0]),
         .Load_Reg (WE2),
         .Q (go_out)
     );
    
    
     dreg #(1) GoPulse (
         .clk (Clk),
         .rst (Rst),
         .d (GoPulseCmb),
         .q (GoPulse_out)
     );
    
     nfactorial fact (
         .clk (Clk),
         .go (GoPulse_out),
         .n (n_out),
         .done (Done),
         .error (Err),
         .out (nf)
     );
    
     fact_res resdone (
         .Clk (Clk),
         .Rst (Rst),
         .S (Done),
         .R (GoPulseCmb),
         .Q (ResDone)
     );
    
     fact_res reserr (
         .Clk (Clk),
         .Rst (Rst),
         .S (Err),
         .R (GoPulseCmb),
         .Q (ResErr)
     );
    
     fact_reg #(32) result (
         .Clk (Clk),
         .Rst (Rst),
         .D (nf),
         .Load_Reg (Done),
         .Q (Result)
     );
    
     mux4 #(32) RD_logic (
         .sel (RdSel),
         .a ({{28{1'b0}}, n_out}),
         .b ({{31{1'b0}}, go_out}),
         .c ({{30{1'b0}}, ResErr, ResDone}),
         .d (Result),
         .y (RD)
     );

endmodule
