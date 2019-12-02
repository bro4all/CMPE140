`timescale 1ns / 1ps

module TB_Factorial;
    reg go_tb, clk_tb;
    reg [3:0] n_tb;
    wire Done_tb, Err_tb;
    wire [31:0] out_tb;
    reg [31:0] out_exp;
    
    Factorial_TOP DUT (
        .n (n_tb),
        .go (go_tb), 
        .CLK (clk_tb),
        .Done (Done_tb), 
        .Err (Err_tb), 
        .out (out_tb)
    );
    
    integer i, error_count, enn;
    
    task tick;
    begin
        clk_tb <= 1'b0;
        #50;
        clk_tb <= 1'b1;
        #50;
    end
    endtask
    
    initial begin
        $display("Begin test");
        clk_tb = 0;
        n_tb = 0;
        tick;
        error_count = 0;
        
        //Cycle through numbers 0-13, 13 should return an error
        for (i = 0; i < 14; i = i + 1)
            begin
                n_tb = i;
                go_tb = 1;
                clk_tb = 0;
                tick;
                
                //Cycle until Done or Error flag is set
                while(!(Done_tb || Err_tb))
                begin
                    tick;
                end
                
                //Calculate expected value
                //enn is basically just the variable n but is used for calculating the expected value. 
                enn = i;
                out_exp = 1;
                while(enn > 1)
                begin
                    out_exp = out_exp * enn;
                    enn = enn - 1;
                end
                //Expected value is stored in out_exp
                
                $display("Testing %d factorial", n_tb);
                //Display expected result if n is less than 13
                if(n_tb < 13)$display("Expected result: %d", out_exp);
                //Display it is expecting an error since n is greater than 12
                else $display("Value is greater than 12, expecting error");
                if(Done_tb)
                begin
                    if(out_tb != out_exp) 
                    begin
                        $display("Error at n = %d", n_tb);
                        error_count = error_count + 1;
                    end
                    else $display("Expected matches actual, %d good", n_tb);

                end
                
                else if (Err_tb)
                begin
                    $display("Error has been found at n = %d", n_tb);
                    if(n_tb > 12) $display("Error is expected, %d good", n_tb);
                end
            end
            //Final error check, should be 0
            if(error_count == 0) $display("No errors found, test run successful.");
            else $display("There are %d errors", error_count);
    end
endmodule

