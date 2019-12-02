module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        input  wire we_reg_pre,
        output wire [2:0] alu_ctrl,

        output wire mf_hi_lo,
        output wire jr,
        output wire MultReg,
        output wire mult_mux_sel,
        output wire regdst,
        output reg  we_reg
    );

    reg [3:0] aluctrl;
    reg [4:0] ctrl;

    assign {alu_ctrl, regdst} = aluctrl;
    assign {mf_hi_lo, jr, MultReg, mult_mux_sel} = ctrl;
    
    
    always @ (alu_op, funct, we_reg_pre) begin
        we_reg = we_reg_pre;
        case (alu_op)
            2'b00: begin
                aluctrl = 4'b010_0;                // ADD
                ctrl    = 4'b0_0_0_0;
                we_reg = we_reg_pre;
                end
            2'b01: begin
                aluctrl = 4'b110_0;                // SUB
                ctrl    = 4'b0_0_0_0;
                we_reg = we_reg_pre;
                end
              
            default: case (funct)
                6'b10_0100: begin
                    aluctrl = 4'b000_1;       // AND
                    we_reg = we_reg_pre;
                    end
                6'b10_0101: begin
                    aluctrl = 4'b001_1;       // OR
                    we_reg = we_reg_pre;
                    end
                6'b10_0000: begin
                    aluctrl = 4'b010_1;       // ADD
                    we_reg = we_reg_pre;
                    end
                6'b10_0010: begin
                    aluctrl = 4'b110_1;       // SUB
                    we_reg = we_reg_pre;
                    end
                6'b10_1010: begin
                    aluctrl = 4'b111_1;       // SLT
                    we_reg = we_reg_pre;
                    end
                
                6'b01_1001: begin                     // MULTU
                    aluctrl         = 4'b011_1; 
                    ctrl            = 4'b0_0_1_0;
                    we_reg = 0;
                    end
                6'b00_0000: begin
                    aluctrl    = 4'b100_1;    // SLL
                    we_reg = we_reg_pre;
                    end
                6'b00_0010: begin
                    aluctrl    = 4'b101_1;    // SRL
                    we_reg = we_reg_pre;
                    end
                6'b01_0000: begin
                    ctrl    = 4'b1_0_0_1;     // MFHI
                    we_reg = we_reg_pre;
                    end
                6'b01_0010: begin
                    ctrl    = 4'b0_0_0_1;     // MFLO   
                    we_reg = we_reg_pre;
                    end             
                6'b00_1000: begin
                    ctrl    = 4'b0_1_0_0;             // JR
                    aluctrl = 4'b000_0;
                    we_reg  = 0;
                    end
              
                default: begin
                    aluctrl = 4'b000_0;
                    ctrl = 4'b0_0_0_0;
                    we_reg = we_reg_pre;
                    end
            endcase
        endcase
    end

endmodule