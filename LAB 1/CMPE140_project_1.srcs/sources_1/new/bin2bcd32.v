module bin2bcd32(
    input wire sel,
    input wire [31:0] value,
    output wire [3:0] dig0,
    output wire [3:0] dig1,
    output wire [3:0] dig2,
    output wire [3:0] dig3,
    output wire [3:0] dig4,
    output wire [3:0] dig5,
    output wire [3:0] dig6,
    output wire [3:0] dig7
    );
    
    assign dig0 = (sel==1)?value % 10:value[3:0];
    assign dig1 = (sel==1)?(value / 10) % 10:value[7:4];
    assign dig2 = (sel==1)?(value / 100) % 10:value[11:8];
    assign dig3 = (sel==1)?(value / 1000) % 10:value[15:12];
    assign dig4 = (sel==1)?(value / 10000) % 10:value[19:16];
    assign dig5 = (sel==1)?(value / 100000) % 10:value[23:20];
    assign dig6 = (sel==1)?(value / 1000000) % 10:value[27:24];
    assign dig7 = (sel==1)?(value / 10000000) % 10:value[31:28];
    
endmodule    