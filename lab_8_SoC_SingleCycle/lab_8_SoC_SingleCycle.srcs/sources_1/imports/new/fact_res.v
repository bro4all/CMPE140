module fact_res(
    input wire Clk,
    input wire Rst,
    input wire S,
    input wire R,
    output reg Q
    );

    always@(posedge Clk, posedge Rst) begin
        if(Rst) Q <= 1'b0;
        else Q <= (~R) & (S | Q);
    end

endmodule