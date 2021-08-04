

// ADC for KTV project
// Analog ==> DSD128 ==> 88.2KHz or 96KHz PCM, 2 channel

module adc96(
input mclk,  //45.1584MHz
input reset_n, 

// Analog circuit control
output latch,    //latch signal for comparator LT1394
input analog_dsd_l,
input analog_dsd_r, 

// PCM out
output obck,
output [31:0] pcm_left,
output [31:0] pcm_right,

//dac output
output dac_lp0,
output dac_lp1,
output dac_lp2,
output dac_lp3,
output dac_ln0,
output dac_ln1,
output dac_ln2,
output dac_ln3,

output dac_rp0,
output dac_rp1,
output dac_rp2,
output dac_rp3,
output dac_rn0,
output dac_rn1,
output dac_rn2,
output dac_rn3
);


/////////////////////////////////////DSD128 ADC ////////////////////////////////////
// DSD sample clock is 128x44100 = 5644800Hz
// We will use 8x DSD128 system clock to process the ADC, so it will be mclk (45/49MHz)
wire dsd_clk;
wire dsd_l;
wire dsd_r;

reg [2:0] i, n_i;
reg rdsd_l, rdsd_r;
reg rdsd_clk;
reg latch1394;
assign latch = latch1394;
assign dsd_clk = rdsd_clk;
assign dsd_l = rdsd_l;
assign dsd_r = rdsd_r;

always @(posedge mclk or negedge reset_n) 
    if (1'b0 == reset_n) begin
        i <= 0;
        rdsd_l <= 0;
        rdsd_r <= 0;
        rdsd_clk <= 0;
        latch1394 <= 0;
        end
    else begin
        i <= i + 3'd1;
        if (3'd7 == i) rdsd_l <= analog_dsd_l;
        if (3'd7 == i) rdsd_r <= analog_dsd_r;
        
        if (3'd0 == i) rdsd_clk <= 1'b0;
        if (3'd4 == i) rdsd_clk <= 1'b1;


//        if (3'd6 == i || 3'd7 == i) 
//             latch1394 <= 1'b1;
//        else
//             latch1394 <= 1'b0;

        latch1394 <= 1'b0;           //free running comparator
        end


// dsd to pcm

reg clkd2;
always @(posedge mclk or negedge reset_n) if (0 == reset_n) clkd2 <= 0; else clkd2 <= ~clkd2;

reg clkd4;
always @(posedge clkd2 or negedge reset_n) if (0 == reset_n) clkd4 <= 0; else clkd4 <= ~clkd4;

reg clkd8;
always @(posedge clkd4 or negedge reset_n) if (0 == reset_n) clkd8 <= 0; else clkd8 <= ~clkd8;

reg clkd16;
always @(posedge clkd8 or negedge reset_n) if (0 == reset_n) clkd16 <= 0; else clkd16 <= ~clkd16;


wire [31:0] dl176, dr176;
dsd128_176 DUT600( .bck(dsd_clk), .data_l(dsd_r), .data_r(dsd_r), .reset_n(reset_n),
    .pcm_left(dl176), .pcm_right(dr176));

// kill DC
wire signed [31:0] gl,gr;
kill_dc176 UKDC1 (.bck176(clkd4), .reset_n(reset_n), .xin(dl176), .xout(gl));
kill_dc176 UKDC2 (.bck176(clkd4), .reset_n(reset_n), .xin(dr176), .xout(gr));

//now we have 176.4KHz PCM, we do down conversion test
wire [31:0] el, er;
down_882 DUT700(.bck176(clkd4), .reset_n(reset_n) ,
    .x0(gl), .x1(gr), .pcm_left(el), .pcm_right(er));

assign obck = clkd16;
assign pcm_left = el;
assign pcm_right = er;

reg [3:0] dsd_rpp, dsd_rnn, dsd_lpp, dsd_lnn;
always @(posedge mclk or negedge reset_n) 
    if (1'b0 == reset_n) begin
        dsd_rpp <= 3'd0;
        dsd_rnn <= 3'd0;
        dsd_lpp <= 3'd0;
        dsd_lnn <= 3'd0;
        end
    else begin
        dsd_lpp <= {dsd_l, dsd_l, dsd_l, dsd_l};
        dsd_lnn <= {!dsd_l, !dsd_l, !dsd_l, !dsd_l};
        dsd_rpp <= {dsd_r, dsd_r, dsd_r, dsd_r};
        dsd_rnn <= {!dsd_r, !dsd_r, !dsd_r, !dsd_r};
        end

assign dac_rp0 = dsd_rpp[0];
assign dac_rp1 = dsd_rpp[1];
assign dac_rp2 = dsd_rpp[2];
assign dac_rp3 = dsd_rpp[3];

assign dac_rn3 = dsd_rnn[3];
assign dac_rn2 = dsd_rnn[2];
assign dac_rn1 = dsd_rnn[1];
assign dac_rn0 = dsd_rnn[0];

assign dac_lp0 = dsd_lpp[0];
assign dac_lp1 = dsd_lpp[1];
assign dac_lp2 = dsd_lpp[2];
assign dac_lp3 = dsd_lpp[3];

assign dac_ln3 = dsd_lnn[3];
assign dac_ln2 = dsd_lnn[2];
assign dac_ln1 = dsd_lnn[1];
assign dac_ln0 = dsd_lnn[0];


endmodule




// remove dc for 176.4KHz x 32 pcm stream
// good, but 1st seconds are garbage

module kill_dc176(
input bck176,    //176.4 bit clock, = 176.4x64
input reset_n,
input signed [31:0] xin,
output signed [31:0] xout
);

//    int64_t AXx16 = AX << 4;
//    int64_t diff = AXx16 - Y;
//    int64_t alpha = 9;
//    int64_t prod = diff * alpha;
//    int64_t frac = prod >> 18;
//    if (frac<0) frac ++;
//    Y = Y + frac;
//    int64_t z = AXx16 - Y;
//    int64_t Z = z>>4;
//    return (double)Z / (double)xmax;


reg [5:0] i;
reg signed [37:0] AX;
reg signed [37:0] Y;
wire signed [17:0] alpha = 18'd9;
reg signed [37:0] result;
wire signed [31:0]result32 = result[35:4];
assign xout = result32;
wire [1:0] sign = xin[31]? 2'h3: 2'd0;
wire signed [37:0] diff = AX - Y;
wire signed [55:0] prod = diff * alpha;
wire signed [37:0] frac = prod[55:18];
wire signed [37:0] fracx = frac[37]? frac + 38'd1 : frac;


always @(posedge bck176 or negedge reset_n)
    if (1'b0 == reset_n) begin
        AX <= 0; Y <= 0;
        i <= 0;
        result <= 0;
        end
    else begin
        i <= i + 6'd1;
        if (i==6'd1) AX <= {sign,xin, 4'd0};
        if (i==6'd5) Y <= Y  + fracx;
        if (i==6'd10) result <= diff;
        if (i == 6'd20) $display("@@@@=%d", result32);
        //if (i == 6'd7) $display("@@@@=%d %d %d", nz/16, AX, Y);
        //if (i == 6'd7) $display("@@@@=%d", AX/16 );   //must delay to allow logic settle
        //if (i == 7) $display("@@@@=%d %d %d %d %d %d", ndiff, nprod, nfrac, Y, nz, nz/16);
        end
endmodule


