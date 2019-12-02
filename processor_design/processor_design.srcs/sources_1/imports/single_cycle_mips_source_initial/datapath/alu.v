module alu (
        input  wire [2:0]  op,
        input  wire [4:0]  shamt,
        input  wire [31:0] a,
        input  wire [31:0] b,
        output wire        zero,
        output reg  [31:0] y,
        output reg  [63:0] y_mult
    );

    assign zero = (y==0);

    always @ (op, a, b) begin
        case (op)
            3'b000: y = a & b;
            3'b001: y = a | b;
            3'b010: y = a + b;
            3'b110: y = a - b;
            3'b111: y = (a < b) ? 1 : 0;       
            
            3'b011: y_mult = a * b;
            3'b100: y = b << shamt;
            3'b101: y = b >> shamt;
        endcase
    end
    
    

endmodule