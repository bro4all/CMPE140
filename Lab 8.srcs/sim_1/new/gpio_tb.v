module gpio_tb;
    reg Clk, Rst, WE;
    reg [1:0] A;
    reg [31:0] gpI1, gpI2, WD;
    wire [31:0] gpO1, gpO2, RD;
    
    gpio_top DUT (
        .Clk (Clk),
        .Rst (Rst),
        .WE (WE),
        .A (A),
        .gpI1 (gpI1),
        .gpI2 (gpI2),
        .WD (WD),
        .gpO1 (gpO1),
        .gpO2 (gpO2),
        .RD (RD)
    );
    
    always begin
        #50 Clk = ~Clk;
    end
    
    initial begin
        Clk = 0;
        Rst = 1;
        WE = 0;
        gpI1 = 0;
        gpI2 = 0;
        WD = 0;
        A = 2'b00;
        #100;
        
        Rst = 0;
        WE = 1;
        gpI1 = 5;
        WD = 0;
        #100;
        
        gpI2 = 1;
        A = 2'b01;
        WD = 0;
        #100;
        
        A = 2'b10;
        WD = 10;
        #100;
        
        A = 2'b11;
        WD = 8;
        #100;
    end
endmodule
