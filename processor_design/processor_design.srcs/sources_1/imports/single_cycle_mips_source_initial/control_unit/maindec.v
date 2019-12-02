module maindec (
        input  wire [5:0] opcode,
        output wire       branch,
        output wire       jump,
        output wire       regdst2,
        output wire       regdst3,
        output wire       we_reg_pre,
        output wire       alu_src,
        output wire       we_dm,
        output wire       memtoreg,
        output wire       jal_mux_sel,
        output wire [1:0] alu_op
    );

    reg [10:0] ctrl;

    assign {branch, jump, regdst2, regdst3, we_reg_pre, alu_src, we_dm, memtoreg, jal_mux_sel, alu_op} = ctrl;

    always @ (opcode) begin
        case (opcode)
            6'b00_0000: ctrl = 11'b0_0_0_0_1_0_0_0_0_10; // R-type
            6'b00_1000: ctrl = 11'b0_0_0_0_1_1_0_0_0_00; // ADDI
            6'b00_0100: ctrl = 11'b1_0_0_0_0_0_0_0_0_01; // BEQ
            6'b00_0010: ctrl = 11'b0_1_0_0_0_0_0_0_0_00; // J
            6'b10_1011: ctrl = 11'b0_0_0_0_0_1_1_0_0_00; // SW
            6'b10_0011: ctrl = 11'b0_0_0_0_1_1_0_1_0_00; // LW
            
            6'b00_0011: ctrl = 11'b0_1_1_0_1_0_0_0_1_00; // JAL
            default:    ctrl = 11'b0_0_0_0_0_0_0_0_0_xx;
        endcase
    end

endmodule