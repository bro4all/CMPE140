module shifter(
        input wire          shiftDir,
        input wire [31:0]   in,
        input wire [4:0]    shamt,
        output reg [31:0]   out
    );
    integer i;
    always @ * begin
            case (shiftDir)
                1'b0: out = in << shamt;
                1'b1: out = in >> shamt;
            endcase
        end
endmodule
