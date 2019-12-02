module fa_tb;
    reg Clk, Rst, WE;
    reg [1:0] A;
    reg [3:0] WD;
    wire [31:0] RD;
    
    fact_top DUT (
        .Clk (Clk),
        .Rst (Rst),
        .WE (WE),
        .A (A),
        .WD (WD),
        .RD (RD)
    );
    
    always begin
        #50 Clk = ~Clk;
    end
    
    integer i, j, expected;
    integer error = 0;
    
    initial begin
        Rst = 1;
        Clk = 0;
        WE = 0;
        A = 2'b00;
        WD = 0;
        #100;
        
        Rst = 0;
        
        for (i = 0; i < 14; i = i + 1) begin
            expected = 0;
            // load n
            WD = i;
            WE = 1;
            A = 2'b00;
            #100;
            
            // send go signal
            WD = 1;
            A = 2'b01;
            #100;
            
            // wait for done flag
            WE = 0;
            A = 2'b10;
            WD = 0;
            #100;
            while (RD != 1'b1) begin
                #100;
            end
        
            //show result
            WE = 0;
            A = 2'b11;
            WD = 0;
            expected = i;
            for (j = i - 1; j > 0; j = j - 1) begin
                expected = expected * j;
            end
            #50;
            if(i == 0) expected = 1;
            if(expected != RD) begin
                error = error + 1;
                $display("Error at i = %d", i);
            end
            #50;
        end
        if(error > 0) $display("There are %d errors", error);
        else $display("No errors found");
        $finish;
    end
endmodule