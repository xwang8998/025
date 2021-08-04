// generate sine, cosine waves @192KHz or 176.4KHz
// input clock is 45MHz which is 256x of 176.4KHz
// actually, since we can finish sine/cosine in less than 16 cycles,
// we can use much slower clock, like 2.8224MHz, with very low power consumption!
// SIN = SIN + freq * COS 
// COS = COS - freq * SIN 

// the goal and formula:
// right now, this osc's formula is
// kfreq = (2^19) * 8.7f/sample_rate
// if f = 0.2Hz kfreq = 5.17, close to FV1's formula
// in FV1, kf (0-512) ==> 0Hz ==> 20Hz, and kf=5 ==> 0.2Hz
// in all the FV1 codes I have found, max kfreq is 129
// 

// for amplitude,  N is the affected delayline length
// Ka = N*32767/16385
// N will range from 0 to 32767
// so if wanted delay is +/-4096 samples  N = 16383
// To convert between the calculated Kf and Ka values and their equivalent decimal values:
// Kf(decimal) = Kf/512
// Ka(decimal) = Ka/32768 


// quality: 120THD+N@40Hz 1000 LUTS without multiplier, or 518LUTS + 4mults



module osc(
input mclk_d16,     //45.1584 divided by 16, 2.8224MHz
input reset_n,
//input [17:0] kfreq,  // large range
input [8:0] kfreq,     // FV1 compatible setting @ 176.4KHz
input [14:0] amp,
output signed [31:0] cos,
output signed [31:0] sin);

reg signed [31:0] acc;
wire signed [18:0] skfreq = {10'd0, kfreq};          //for 176.4KHz
//wire signed [18:0] skfreq = {8'd0, kfreq, 2'd0};        //for 44.1KHz
wire signed [27:0] sacc =  acc[31:4];
wire signed [46:0] mult = sacc * skfreq;
wire signed [31:0] mult_acc_freq = mult[46:15];

reg [3:0] i;
parameter OSC0 = 4'd0;
parameter OSC1 = 4'd1;
parameter OSC2 = 4'd2;
parameter OSC3 = 4'd3;
parameter OSC4 = 4'd4;
parameter OSC5 = 4'd5;
parameter OSC6 = 4'd6;
parameter OSC7 = 4'd7;
parameter OSC8 = 4'd8;
parameter OSC9 = 4'd9;
parameter OSC10 = 4'd10;
parameter OSC11 = 4'd11;
parameter OSC12 = 4'd12;

reg signed [31:0] c, s, sout, cout, cx, sx;
wire signed [15:0] samp = {1'b0, amp};
wire signed [23:0] accx = acc[31:8];
wire signed [39:0] acc_x_amp = accx * samp;
wire signed [31:0] mult_acc_amp = acc_x_amp[38:7];


//wire signed [23:0] s0 = s[31:8];
//wire signed [23:0] c0 = c[31:8];
//wire signed [38:0] sz = s0*samp;
//wire signed [38:0] cz = c0*samp;
//wire signed [31:0] s1 = sz[38:7];
//wire signed [31:0] c1 = cz[38:7];

assign cos = cout;
assign sin = sout;


always @(posedge mclk_d16 or negedge reset_n) 
    if (1'b0 == reset_n) begin
        //initialize SIN to 0.5
        i <= 4'd0;
        acc <= 32'd0;
        s <= 32'h3fffffff;
        c <= 32'd0;
        sout <= 0;
        cout <= 0;
        sx <= 0; cx <= 0;
        end

    else begin
        i <= i + 4'd1;
       
        if (i == 0) begin
            sout <= sx; cout <=cx;
            //$display("@@@@=%d  %d", sout, cout);
            $display("@@@@=%d  %d", cout, sout);
            end 

        else begin
            sout <= sout; cout <= cout;
            end

//rdax(c, 1);   ===> 0
//mulx(pot0);   ===> 1    
//rdax(s, 1);  ====> 2
//wrax(&s, -1); ===> 3
//mulx(pot0);  ==> 4
//rdax(c, 1); ==>5
//wrax(&c, 0); ==> 6
//rdax(s, 1); ==> 7

//mulx(pot1); ==> 8
//wrax(&dacr, 0); ==>9
//rdax(c, 1); ==> 10
//mulx(pot1); ==> 11
//wrax(&dacl, 1); 12
//       return dacl;

       
        if (i == OSC0 || i==OSC5 || i == OSC10) begin //rdax(c,1)
            acc <= acc + c; 
            s <= s; c <= c; sx <= sx; cx <= cx;
            end
        else if (i == OSC1 || i == OSC4) begin  //mulx(pot0)
            acc <= mult_acc_freq;
            s <= s; c <= c; sx <= sx; cx <= cx;
            end
        else if (i == OSC2 || i == OSC7) begin // rdax(s,1)
            acc <= acc + s;
            s <= s; c <= c; sx <= sx; cx <= cx;
            end
        else if (i == OSC3) begin //wrax(&s, -1)
            s <= acc;
            acc <= 32'd0 - acc;
            c <= c; sx <= sx; cx <= cx;
            end

        else if (i == OSC6) begin  //wrax(&c, 0);
            c <= acc;   
            s <= s; acc<= 0; sx <= sx; cx <= cx;
            end
        else if (i == OSC8 || i == OSC11) begin  //mulx(pot1);
            acc <= mult_acc_amp;
            s <= s; c <= c; sx <= sx; cx <= cx;
            end
        else if (i == OSC9) begin //wrax(&dacr, 0);
            sx <= acc;
            s <= s; c <= c; acc <= 0; cx <= cx;
            end
        else if (i == OSC12) begin //wrax(&dacl, 1)
            cx <= acc;
            s <= s; c <= c; acc <= 0; sx <= sx; 
            end
        else begin
            s <= s; c <= c; acc <= acc; sx <= sx; cx <= cx;
            end
        end 

endmodule

