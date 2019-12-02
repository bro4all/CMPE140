module imem (
        input  wire [5:0]  a,
        output wire [31:0] y
    );

    reg [31:0] rom [0:63];

    initial begin
        $readmemh ("C:/Users/camer/OneDrive/Documents/CMPE_140/Lab7/mem.dat", rom);
    end

    assign y = rom[a];
    
endmodule