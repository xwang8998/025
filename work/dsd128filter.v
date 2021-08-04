
// filter design:
// AT1201: passband ripple 0.015 STOP band -117
// AK5397EQ: passband ripple 0.0001 - -0.00015 stopband 100 or 0.05 / 93dB optional mini phase
// sample clock: DSD128 ===> 44100x128
// AK5394: passband/stop 0.001/120dB linear only
// CS5381: passband/stop 0.1/-97
// AK5572: passband/stop +/-0.03/-88
// desimation by 8==>705.6
// by16 ==> 352.8
// by32 ==> 176.4

// we allow max tap number to be 256 for 32 decemation, 128 for 16, 64 for 8
// ...
// to design module deci_rom
// we could hard wire the taps and -taps using C program
// or save the taps in Igloo2's flash and load it to LSRAM
// 256 x 32bit takes 1K byte

// finally, we can do 2 channels with 1 set of taps
// or, if we have plenty of memory
// we could turn t0 + t1 + t2 + t3 + t4 + t5 + t6 + t7 into pre-calculated lookup table
//

// 2 channel decimation by 32
// DSD128 / 32 ==> 176.4

module dsd128_176(
input bck,
input data_l,
input data_r,
input reset_n,
output [31:0] pcm_left,
output [31:0] pcm_right);

parameter DEC_FACTOR = 32;
parameter ADDER_COUNT = 10;
parameter NTAP = 320;     // = DEC_FACTOR * ADDER_COUNT

reg [DEC_FACTOR-1:0] sample_shift_l, n_sample_shift_l, sample_shift_r, n_sample_shift_r;
reg [NTAP-1:0] sample_l, n_sample_l, sample_r, n_sample_r;

reg  [4:0] i, n_i;

wire x0 = sample_l[0];
wire x1 = sample_l[1];
wire x2 = sample_l[2];
wire x3 = sample_l[3];
wire x4 = sample_l[4];
wire x5 = sample_l[5];
wire x6 = sample_l[6];
wire x7 = sample_l[7];
wire x8 = sample_l[8];
wire x9 = sample_l[9];

wire y0 = sample_r[0];
wire y1 = sample_r[1];
wire y2 = sample_r[2];
wire y3 = sample_r[3];
wire y4 = sample_r[4];
wire y5 = sample_r[5];
wire y6 = sample_r[6];
wire y7 = sample_r[7];
wire y8 = sample_r[8];
wire y9 = sample_r[9];


wire signed [31:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9;   //tap_left
wire signed [31:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;   //tap_right
reg signed [31:0] sum_l, sum_r, n_sum_l, n_sum_r;
reg signed [31:0] dout_l, dout_r, n_dout_l, n_dout_r;

assign pcm_left = dout_l;
assign pcm_right = dout_r;


dsd128_rom UROM(.addr(i), 
.x0(x0), .x1(x1), .x2(x2), .x3(x3), .x4(x4), .x5(x5), .x6(x6), .x7(x7), .x8(x8), .x9(x9),
.y0(y0), .y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5), .y6(y6), .y7(y7), .y8(y8), .y9(y9),
.tap_left0(s0), .tap_left1(s1), .tap_left2(s2), .tap_left3(s3),
.tap_left4(s4), .tap_left5(s5), .tap_left6(s6), .tap_left7(s7),
.tap_left8(s8), .tap_left9(s9),
.tap_right0(t0), .tap_right1(t1), .tap_right2(t2), .tap_right3(t3), 
.tap_right4(t4), .tap_right5(t5), .tap_right6(t6), .tap_right7(t7),
.tap_right8(t8), .tap_right9(t9));


always @(posedge bck or negedge reset_n)
    if (1'b0 == reset_n) begin
        i <= 0;
        sample_l <= 320'd0; 
        sample_r <= 320'd0;
        sample_shift_l <= 32'd0; 
        sample_shift_r <= 32'd0;
        dout_l <= 0; dout_r <= 0;
        sum_l <= 0; sum_r <= 0;
        end
    else begin
        sample_shift_l <= #10 {data_l, sample_shift_l[DEC_FACTOR-1:1]};
        sample_shift_r <= #10 {data_r, sample_shift_r[DEC_FACTOR-1:1]};

//        #100 if (data_l) 
//                 $display("@@@@=%d",  32000);   //must delay to allow logic settle
//            else
//                 $display("@@@@=%d",  -32000);   //must delay to allow logic settle

        if (i == 2) $display("@@@@=%d", dout_r );   //must delay to allow logic settle
        if (i == 5'd31) begin
            dout_l <= #10 sum_l + s0 + s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9;
            dout_r <= #10 sum_r + t0 + t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9;
            sum_l <= 0;
            sum_r <= 0;
            sample_l <= {sample_shift_l,
                         sample_l[ADDER_COUNT - 1:0],
                         sample_l[NTAP-1: ADDER_COUNT + DEC_FACTOR]};
            sample_r <= {sample_shift_r,
                         sample_r[ADDER_COUNT - 1:0],
                         sample_r[NTAP-1: ADDER_COUNT + DEC_FACTOR]};

            i <= 0;
            end
        else begin
            dout_l <=  dout_l;
            dout_r <=  dout_r;
            sum_l <= #10 sum_l + s0 + s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9;
            sum_r <= #10 sum_r + t0 + t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9;
            sample_l <= {sample_l[ADDER_COUNT-1:0], sample_l[NTAP-1:ADDER_COUNT]}; 
            sample_r <= {sample_l[ADDER_COUNT-1:0], sample_r[NTAP-1:ADDER_COUNT]}; 
            i <= i + 5'd1;
            end
        end

endmodule


