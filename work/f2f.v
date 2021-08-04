
// according to FV-1
// Delay memory is a floating point type format, 1-bit for sign, 4-bits for exponent and 9-bits mantissa. Expands to a 24-bit 2's comp number for use in the MAC/ALU. Since it is floating point when it is expanded you may need to fill LSBs with 0 to make it 24-bits. In the FV-1 the number is always considered to range from +0.99... to -1.00 so the binary point is always in the same spot so the 24-bit 2's comp number is always S.23.

// here we use 18 bit data to do the floating, so 1 bit for sign, 4-bits for exponent, 13-bit mantissa
// convert to 32bit S.4.27 fixed format

module float2fixed(input [17:0] float, output [31:0] fixed);

wire [3:0] exp = float[17:14];
wire s = float[13];
wire [12:0] frac = float[12:0];

wire [0:0]e0 = {!s};  wire [15:0] z0 = 16'd0;
wire [1:0]e1 = {s,!s};  wire [14:0] z1 = 15'd0;
wire [2:0]e2 = {s,s,!s};  wire [13:0] z2 = 14'd0;
wire [3:0]e3 = {s,s,s,!s};  wire [12:0] z3 = 13'd0;
wire [4:0]e4 = {s,s,s,s,!s};  wire [11:0] z4 = 12'd0;
wire [5:0]e5 = {s,s,s,s,s,!s};  wire [10:0] z5 = 11'd0;
wire [6:0]e6 = {s,s,s,s,s,s,!s};  wire [9:0] z6 = 10'd0;
wire [7:0]e7 = {s,s,s,s,s,s,s,!s};  wire [8:0] z7 = 9'd0;
wire [8:0]e8 = {s,s,s,s,s,s,s,s,!s};  wire [7:0] z8 = 8'd0;
wire [9:0]e9 = {s,s,s,s,s,s,s,s,s,!s};  wire [6:0] z9 = 7'd0;
wire [10:0]e10 = {s,s,s,s,s,s,s,s,s,s,!s};  wire [5:0] z10 = 6'd0;
wire [11:0]e11 = {s,s,s,s,s,s,s,s,s,s,s,!s};  wire [4:0] z11 = 5'd0;
wire [12:0]e12 = {s,s,s,s,s,s,s,s,s,s,s,s,!s};  wire [3:0] z12 = 4'd0;
wire [13:0]e13 = {s,s,s,s,s,s,s,s,s,s,s,s,s,!s};  wire [2:0] z13 = 3'd0;
wire [14:0]e14 = {s,s,s,s,s,s,s,s,s,s,s,s,s,s,!s};  wire [1:0] z14 = 2'd0;
wire [14:0]e15 = {s,s,s,s,s,s,s,s,s,s,s,s,s,s,s};  wire [1:0] z15 = 2'd0;

reg [31:0] r;
assign fixed = r;

always @* case(exp)
    4'd0: r = {s, e0, frac, z0, 1'd0};
    4'd1: r = {s, e1, frac, z1, 1'd0};
    4'd2: r = {s, e2, frac, z2, 1'd0};
    4'd3: r = {s, e3, frac, z3, 1'd0};
    4'd4: r = {s, e4, frac, z4, 1'd0};
    4'd5: r = {s, e5, frac, z5, 1'd0};
    4'd6: r = {s, e6, frac, z6, 1'd0};
    4'd7: r = {s, e7, frac, z7, 1'd0};
    4'd8: r = {s, e8, frac, z8, 1'd0};
    4'd9: r = {s, e9, frac, z9, 1'd0};
    4'd10: r = {s, e10, frac, z10, 1'd0};
    4'd11: r = {s, e11, frac, z11, 1'd0};
    4'd12: r = {s, e12, frac, z12, 1'd0};
    4'd13: r = {s, e13, frac, z13, 1'd0};
    4'd14: r = {s, e14, frac, z14, 1'd0};
    4'd15: r = {s, e15, frac, z15, 1'd0};
    default: r = 32'd0;
    endcase

endmodule

module fixed2float(output [17:0] float, input [31:0] fixed);

wire s = fixed[31];
reg [12:0] frac;
reg [3:0] exp;
assign float = {exp, s, frac};

wire [0:0]e0 = {!s};
wire [1:0]e1 = {s,!s};
wire [2:0]e2 = {s,s,!s};
wire [3:0]e3 = {s,s,s,!s};
wire [4:0]e4 = {s,s,s,s,!s};
wire [5:0]e5 = {s,s,s,s,s,!s};
wire [6:0]e6 = {s,s,s,s,s,s,!s};
wire [7:0]e7 = {s,s,s,s,s,s,s,!s};
wire [8:0]e8 = {s,s,s,s,s,s,s,s,!s};
wire [9:0]e9 = {s,s,s,s,s,s,s,s,s,!s};
wire [10:0]e10 = {s,s,s,s,s,s,s,s,s,s,!s};
wire [11:0]e11 = {s,s,s,s,s,s,s,s,s,s,s,!s};
wire [12:0]e12 = {s,s,s,s,s,s,s,s,s,s,s,s,!s};
wire [13:0]e13 = {s,s,s,s,s,s,s,s,s,s,s,s,s,!s};
wire [14:0]e14 = {s,s,s,s,s,s,s,s,s,s,s,s,s,s,!s};
wire [14:0]e15 = {s,s,s,s,s,s,s,s,s,s,s,s,s,s,s};

always @* begin
    exp = 4'd0; frac = 13'd0;
    if (fixed[30:16] == e15) begin exp = 4'd15; frac = fixed[15:3]; end
    else if (fixed[30:16] == e14) begin exp = 4'd14; frac = fixed[15:3]; end
    else if (fixed[30:17] == e13) begin exp = 4'd13; frac = fixed[16:4]; end
    else if (fixed[30:18] == e12) begin exp = 4'd12; frac = fixed[17:5]; end
    else if (fixed[30:19] == e11) begin exp = 4'd11; frac = fixed[18:6]; end
    else if (fixed[30:20] == e10) begin exp = 4'd10; frac = fixed[19:7]; end
    else if (fixed[30:21] == e9) begin exp = 4'd9; frac = fixed[20:8]; end
    else if (fixed[30:22] == e8) begin exp = 4'd8; frac = fixed[21:9]; end
    else if (fixed[30:23] == e7) begin exp = 4'd7; frac = fixed[22:10]; end
    else if (fixed[30:24] == e6) begin exp = 4'd6; frac = fixed[23:11]; end
    else if (fixed[30:25] == e5) begin exp = 4'd5; frac = fixed[24:12]; end
    else if (fixed[30:26] == e4) begin exp = 4'd4; frac = fixed[25:13]; end
    else if (fixed[30:27] == e3) begin exp = 4'd3; frac = fixed[26:14]; end
    else if (fixed[30:28] == e2) begin exp = 4'd2; frac = fixed[27:15]; end
    else if (fixed[30:29] == e1) begin exp = 4'd1; frac = fixed[28:16]; end
    else if (fixed[30:30] == e0) begin exp = 4'd0; frac = fixed[29:17]; end
    end

endmodule

