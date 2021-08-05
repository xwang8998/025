
// prepare for ADC code
// A1: use 4b inoise bad but 
// A20: big pwm2 (8-0,4-4,0-8)  sound much better!  INBAND=-13
// A21: pwm5 DAC  sound good
// A22: pwm5 Latch 1 cycle
// A23: pwm5 on freerunning LT1394
// A24: rtz 2cycle of 1394 latch
// A2: A20 big pwm2, 2cycle of 1394 latch, alittle higher inband than A22, but far end better, basicly same
//     as A20
// A3: A2 but use q[1] [q0] , far end better, in band same as A2
// A4: use 1bit[q0] only, not 2bit, better than A3, but hign-end folded back in foobar2000, doesn't sound right
// A5: like A4, but 1 cycle 1394 latch, bad! high noise
// A6: like A4, but 4 cycle 1394 latch, bad, a spur too close to audio band
// A7: like A4, free run 1394, 10K-20K noise higher than A4
// A8: like A4, 2cycle 1394, but DSD 8-0, 0-8 to 7-0 0-7, bad much higher noise!
// A9: back to A4, but change 1bit shift to 2bit shift not good, had a bump around 20K
// A10: back to A4, but chnage 1bit shift differ in order (rp vs rn) worse
// A11: back to A4, still the best
// A12: like A11, use q[1], noise higher!
// A13: like A11, use dsd instead of q[0]   Bad!, like meta stable, still should use q[0]
// A14: move latch to clock5 and 6 instead of 6 & 7 try A13
// A15: back to A11
// A2, with 510/91 rsum vs 2K/360 rsum , sounds better, in band noise floor lower
//     but max0/max1 higher!
// A15: 510/90 rsum, sound much better!
// A15: 510/90, bias R from 10K/1K to 220/220 high noise!
// A15: 510/90, bias R from 10K/1K to 1K/1K  nice floor but spurs in audio band
//       but recording sound great
//       when stablized, max0/1 around 8, inband around -46 -- -50
// 3/15/2018 debug
//      RREF====> 10Kohm, RSUM 510/90, RDFF===>1K, + 39K R13
//      replace defect C2, with 560pF cap, remove cap around RDFF
//      inband noise ==> -60dB good!
//3/18/2018 A16, use 4b DSD DAC, best result so far, as good as A1
//      A17: free running 1394, ok but spurs on the floor
//      just tested, A1, A16, A17 pretty much the same


module test(
  input reset_n,

//to led
output wire led0, led1, led2, led3, led4, led5, led6, led7,

// to eSRAM controller
output FPGA_CLK,

// AHB Side Interfacing with FIC 
output           [31:0] HADDR,
output           [1:0]  HTRANS,
output                  HWRITE,
output     wire  [2:0]  HSIZE,
output     wire  [2:0]  HBURST,
output     wire  [3:0]  HPROT,
output     wire  [31:0] HWDATA,
output     wire         HMASTLOCK,

input      wire  [31:0] HRDATA,
input      wire         HREADY,
input      wire  [1:0]  HRESP, //don't check this part
input      pll_lock,
input      wire         wstart,

  //sdio interface
  input  sdclk,
  inout  cmd,
  inout  sd_d0,
  inout  sd_d1,
  inout  sd_d2,
  inout  sd_d3,

  //I2S interface
  input  mclk,
  inout  obck,
  inout  olrck,
  inout  odata,

  // u8 2100 special
  output spdif_en,
  output spdif_tx,

  output en45,
  output en49,

  //1b DAC
  inout dsd_lp0,
  inout dsd_lp1,
  inout dsd_lp2,
  inout dsd_lp3,
  inout dsd_lp4,
  inout dsd_lp5,
  inout dsd_lp6,
  inout dsd_lp7,

  inout dsd_ln0,
  inout dsd_ln1,
  inout dsd_ln2,
  inout dsd_ln3,
  inout dsd_ln4,
  inout dsd_ln5,
  inout dsd_ln6,
  inout dsd_ln7,

  inout dsd_rp0,
  inout dsd_rp1,
  inout dsd_rp2,
  inout dsd_rp3,
  inout dsd_rp4,
  inout dsd_rp5,
  inout dsd_rp6,
  inout dsd_rp7,

  inout dsd_rn0,
  inout dsd_rn1,
  inout dsd_rn2,
  inout dsd_rn3,
  inout dsd_rn4,
  inout dsd_rn5,
  inout dsd_rn6,
  inout dsd_rn7
);

//debug clock
assign en45 = 1'b1;
assign en49 = 1'b0;
reg c1,c2,c3;
always @(posedge mclk) c1 <= ~c1; //45
always @(posedge c1) c2 <= ~c2; //22
always @(posedge c2) c3 <= ~c3; //11
assign spdif_tx  = c3;
//debug wire
wire a1,a2,a3,a4;



//not all dsd_lx and dsd_rx are used in ADC setup
wire odsd_lp0, odsd_lp1, odsd_lp2, odsd_lp3, odsd_lp4, odsd_lp5, odsd_lp6, odsd_lp7;
wire odsd_ln0, odsd_ln1, odsd_ln2, odsd_ln3, odsd_ln4, odsd_ln5, odsd_ln6, odsd_ln7;
wire odsd_rp0, odsd_rp1, odsd_rp2, odsd_rp3, odsd_rp4, odsd_rp5, odsd_rp6, odsd_rp7;
wire odsd_rn0, odsd_rn1, odsd_rn2, odsd_rn3, odsd_rn4, odsd_rn5, odsd_rn6, odsd_rn7;

wire idsd_lp0, idsd_lp1, idsd_lp2, idsd_lp3, idsd_lp4, idsd_lp5, idsd_lp6, idsd_lp7;
wire idsd_ln0, idsd_ln1, idsd_ln2, idsd_ln3, idsd_ln4, idsd_ln5, idsd_ln6, idsd_ln7;
wire idsd_rp0, idsd_rp1, idsd_rp2, idsd_rp3, idsd_rp4, idsd_rp5, idsd_rp6, idsd_rp7;
wire idsd_rn0, idsd_rn1, idsd_rn2, idsd_rn3, idsd_rn4, idsd_rn5, idsd_rn6, idsd_rn7;

BIBUF UD0 (.PAD(dsd_lp0), .D(odsd_lp0), .Y(idsd_lp0), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UD1 (.PAD(dsd_lp1), .D(odsd_lp1), .Y(idsd_lp1), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UD2 (.PAD(dsd_lp2), .D(odsd_lp2), .Y(idsd_lp2), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UD3 (.PAD(dsd_lp3), .D(odsd_lp3), .Y(idsd_lp3), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UD4 (.PAD(dsd_lp4), .D(odsd_lp4), .Y(idsd_lp4), .E(1'b0));        //OUTPUT  NOT USED 
BIBUF UD5 (.PAD(dsd_lp5), .D(odsd_lp5), .Y(idsd_lp5), .E(1'b1));        //OUTPUT  LATCH1394 ok
BIBUF UD6 (.PAD(dsd_lp6), .D(odsd_lp6), .Y(idsd_lp6), .E(1'b0));        //INPUT   DSD_L ok
BIBUF UD7 (.PAD(dsd_lp7), .D(odsd_lp7), .Y(idsd_lp7), .E(1'b0));        //OUTPUT  NOT USED
assign odsd_lp4 = 1'b0;
assign odsd_lp6 = 1'b0;
assign odsd_lp7 = 1'b0;

BIBUF UE0 (.PAD(dsd_ln0), .D(odsd_ln0), .Y(idsd_ln0), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UE1 (.PAD(dsd_ln1), .D(odsd_ln1), .Y(idsd_ln1), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UE2 (.PAD(dsd_ln2), .D(odsd_ln2), .Y(idsd_ln2), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UE3 (.PAD(dsd_ln3), .D(odsd_ln3), .Y(idsd_ln3), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UE4 (.PAD(dsd_ln4), .D(odsd_ln4), .Y(idsd_ln4), .E(1'b0));        //OUTPUT  NOT USED
BIBUF UE5 (.PAD(dsd_ln5), .D(odsd_ln5), .Y(idsd_ln5), .E(1'b0));        //OUTPUT  NOT USED
BIBUF UE6 (.PAD(dsd_ln6), .D(odsd_ln6), .Y(idsd_ln6), .E(1'b0));        //OUTPUT  NOT USED
BIBUF UE7 (.PAD(dsd_ln7), .D(odsd_ln7), .Y(idsd_ln7), .E(1'b0));        //OUTPUT  NOT USED
assign odsd_ln4 = 1'b0;
assign odsd_ln5 = 1'b0;
assign odsd_ln6 = 1'b0;
assign odsd_ln7 = 1'b0;

BIBUF UF0 (.PAD(dsd_rp0), .D(odsd_rp0), .Y(idsd_rp0), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UF1 (.PAD(dsd_rp1), .D(odsd_rp1), .Y(idsd_rp1), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UF2 (.PAD(dsd_rp2), .D(odsd_rp2), .Y(idsd_rp2), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UF3 (.PAD(dsd_rp3), .D(odsd_rp3), .Y(idsd_rp3), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UF4 (.PAD(dsd_rp4), .D(odsd_rp4), .Y(idsd_rp4), .E(1'b0));        //OUTPUT  NOT USED ?bad
BIBUF UF5 (.PAD(dsd_rp5), .D(odsd_rp5), .Y(idsd_rp5), .E(1'b1));        //OUTPUT  LATCH1394 ok
BIBUF UF6 (.PAD(dsd_rp6), .D(odsd_rp6), .Y(idsd_rp6), .E(1'b0));        //INPUT   DSDR ok
BIBUF UF7 (.PAD(dsd_rp7), .D(odsd_rp7), .Y(idsd_rp7), .E(1'b0));        //OUTPUT  NOT USED ?bad 
assign odsd_rp4 = 1'b0;
assign odsd_rp6 = 1'b0;
assign odsd_rp7 = 1'b0;

BIBUF UG0 (.PAD(dsd_rn0), .D(odsd_rn0), .Y(idsd_rn0), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UG1 (.PAD(dsd_rn1), .D(odsd_rn1), .Y(idsd_rn1), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UG2 (.PAD(dsd_rn2), .D(odsd_rn2), .Y(idsd_rn2), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UG3 (.PAD(dsd_rn3), .D(odsd_rn3), .Y(idsd_rn3), .E(1'b1));        //OUTPUT  DAC ok
BIBUF UG4 (.PAD(dsd_rn4), .D(odsd_rn4), .Y(idsd_rn4), .E(1'b1));        //OUTPUT  NOT USED
BIBUF UG5 (.PAD(dsd_rn5), .D(odsd_rn5), .Y(idsd_rn5), .E(1'b1));        //OUTPUT  NOT USED
BIBUF UG6 (.PAD(dsd_rn6), .D(odsd_rn6), .Y(idsd_rn6), .E(1'b1));        //OUTPUT  NOT USED
BIBUF UG7 (.PAD(dsd_rn7), .D(odsd_rn7), .Y(idsd_rn7), .E(1'b1));        //OUTPUT  NOT USED
assign odsd_rn4 = 1'b0|a1;
assign odsd_rn5 = 1'b0|a2;
assign odsd_rn6 = 1'b0|a3;
assign odsd_rn7 = 1'b0|a4;

wire [7:0] led;
//assign {led7, led6, led3, led2, led5, led0, led1, led4} = led;
assign {led7, led6, led5, led4, led3, led2, led1, led0} = led;
wire i2s_bck, i2s_lrck, i2s_data;

assign HSIZE =  3'b010;   // 32bit word transfer
assign HBURST = 3'b000;   // Single burst
assign HMASTLOCK = 1'b1;  // don't lock it
assign HPROT  = 4'b0011;  // priviliged data access
//assign HWDATA = 32'h12345678; 

reg mclk_d2;
always @(posedge mclk or negedge reset_n)
    if (0 == reset_n) mclk_d2 <= 0;
    else  mclk_d2 <= ~mclk_d2;

wire mclk4549;

wire ns;
assign ns = ~sdclk;
wire sdclk_n;
CLKINT_PRESERVE UCK3 (.A(ns), .Y(sdclk_n));
CLKINT UCK4 (.A(sdclk), .Y(sdclk_p));


///DEBUG interface, using total phase aardvark i2s tool, read debug64 to PC so we can debug
///use scl/sda

//wire sda_in, sda_out, sda_out_enable;
//BB u800(
//.I(sda_out),
//.T(~sda_out_enable),
//.O(sda_in),
//.B(sda));
//wire [63:0]debug64;
////assign debug64 = {8'h11, 8'h22, 8'h33, 8'h44, 8'h55, 8'h66, 8'h77, 8'h88};
//debug_core U810(.pclk(mclk), .preset_n(reset_n),
//    .debug(debug64),
//    .i2c_slave_addr(7'h0d),
//    .scl(scl),
//   .sda(sda_in),
//    .sda_out(sda_out),
//    .sda_out_en(sda_out_enable));

// LED debug interface, more easy to see!
wire [63:0] debug64;
wire [7:0] debug;


//SDIO interface, in: sdio pins, out: i2s pins
wire cmd_out, cmd_out_en;
wire cmd_in;
wire sd_data_out_en;
wire [3:0] sd_data_in, sd_data_out;

BIBUF UBB (.PAD(cmd), .D(cmd_out), .Y(cmd_in), .E(cmd_out_en));
BIBUF UDAT0 (.PAD(sd_d0), .D(sd_data_out[0]), .Y(sd_data_in[0]), .E(sd_data_out_en));
BIBUF UDAT1 (.PAD(sd_d1), .D(sd_data_out[1]), .Y(sd_data_in[1]), .E(sd_data_out_en));
BIBUF UDAT2 (.PAD(sd_d2), .D(sd_data_out[2]), .Y(sd_data_in[2]), .E(sd_data_out_en));
BIBUF UDAT3 (.PAD(sd_d3), .D(sd_data_out[3]), .Y(sd_data_in[3]), .E(sd_data_out_en));

wire dac_mode;
wire obck_o,  obck_i;
wire olrck_o, olrck_i;
wire odata_o, odata_i;
wire wbck,wlrck,wdata;
BIBUF UDAT20 (.PAD(obck), .D(wbck), .Y(obck_i), .E(!dac_mode));
BIBUF UDAT21 (.PAD(olrck), .D(wlrck), .Y(olrck_i), .E(!dac_mode));
BIBUF UDAT22 (.PAD(odata), .D(wdata), .Y(odata_i), .E(!dac_mode));

// adc test, debug only!
wire bck_g, lrck_g, data_g;
//dsd_gen UGEN(.mclk(mclk4549), .reset_n(reset_n), .bck(bck_g), .dsd1(lrck_g), .dsd2(data_g));

CLKINT_PRESERVE UCK1 (.A(mclk_d2), .Y(mclk4549));
assign FPGA_CLK = ~mclk_d2;

wire en45x, en49x;
wire spdif_txx;

// pcm input
wire [31:0] xl, xr;

//dsp debug
wire [7:0] dsp0, dsp1, dsp2, dsp3, dsp4;
wire [31:0]pcm32ldata,pcm32rdata;
wire wbck;
reg [31:0]nnlldata;
assign led = debug;
sdtop u100(.sdclk_p(sdclk_p), .sdclk_n(sdclk_n), .rst_n(reset_n), .cmd(cmd_in), .led(debug), .db64(debug64),
    .en45(en45x), .en49(en49x),
    .cmd_out(cmd_out), .cmd_out_en(cmd_out_en),
    .HREADY(HREADY), .HRDATA(HRDATA), .HADDR(HADDR), .HWDATA(HWDATA), .HTRANS(HTRANS), .HWRITE(HWRITE),
    .sd_data_in(sd_data_in), .sd_data_out(sd_data_out), .sd_data_out_en(sd_data_out_en),
    .spdif_en(spdif_en), .spdif_tx(spdif_txx),
    .xl(nnlldata), .xr(pcm32rdata),
    .dsp0(dsp0), .dsp1(dsp1), .dsp2(dsp2), .dsp3(dsp3), .dsp4(dsp4), 
    .i2s_bck(i2s_bck), .i2s_lrck(i2s_lrck), .i2s_data(i2s_data),
    .mclk(mclk4549), .obck(obck_o), .olrck(olrck_o), .odata(odata_o), .dac_mode(dac_mode),
    //.bck_i(obck_i), .lrck_i(olrck_i), .data_i(odata_i)
    .bck_i(bck_g), .lrck_i(olrck_i), .data_i(odata_i)
    //.bck_i(bck_g), .lrck_i(lrck_g), .data_i(data_g)       /////DEBUG
    );
reg [5:0]wi;
reg  [31:0]lldata,rrdata;   

always @(posedge bck_g or negedge reset_n)begin
    if(!reset_n)begin
        wi <= 0;
        lldata <= 0;
        rrdata <= 0;
        end
    else if(wi ==6'd63)  begin
        lldata <= lldata + 32'd1;
        rrdata <= rrdata + 32'd1;
        wi <= 0;
    end
    else
    wi <= wi + 6'd1;
        
end
reg [6:0]wii;
reg [31:0]nlldata;

always @(posedge bck_g or negedge reset_n)begin
    if(!reset_n)begin
        wii <= 0;
        nlldata <= 0;
    
        end
    else if(wii ==7'd31)  begin
        nlldata <= {16'd0,lldata[15:0]};
        wii <= wii +7'd1;    
    end 
    else if(wii == 7'd95)begin
        nlldata <= {lldata[15:0],nlldata[15:0]};
        wii <= wii+ 7'd1;
    end 
    else if(wii == 7'd127)begin
        nnlldata <= nlldata;
        wii <= 0;
        end
    else begin
    wii <= wii + 7'd1;
    nlldata <= nlldata;
    end 
    
end


GEN_DDS uGEN_DDS(
.mclk(mclk4549),
.reset_n(wstart),
       
.pcml(pcm32ldata),
.pcmr(pcm32rdata)
       );
pcm_tx u_pcm_tx(
.in_bck(bck_g) /* synthesis syn_keep = 1 */,
.rst_n(reset_n),
.start(wstart),
.source_left(pcm32ldata),
.source_right(pcm32rdata),
.obck(wbck),
.olrck(wlrck),
.odata(wdata)
);       

/////////////////////////////////////DSD128 ADC ////////////////////////////////////
// DSD sample clock is 128x44100 = 5644800Hz
// We will use 8x DSD128 system clock to process the ADC, so it will be mclk4549
// 
assign a1 = 0;
assign a2 = 0;
assign a3 = 0;
assign a4 = 0;

wire latch1394;
adc96 UADC( .mclk(mclk4549), .reset_n(reset_n), .latch(latch1394), .analog_dsd_l(idsd_lp6),
    .analog_dsd_r(idsd_rp6),
    .obck(bck_g), .pcm_left(xl), .pcm_right(xr),
    .dac_lp0(odsd_lp0),
    .dac_lp1(odsd_lp1),
    .dac_lp2(odsd_lp2),
    .dac_lp3(odsd_lp3),
    .dac_ln0(odsd_ln0),
    .dac_ln1(odsd_ln1),
    .dac_ln2(odsd_ln2),
    .dac_ln3(odsd_ln3),

    .dac_rp0(odsd_rp0),
    .dac_rp1(odsd_rp1),
    .dac_rp2(odsd_rp2),
    .dac_rp3(odsd_rp3),
    .dac_rn0(odsd_rn0),
    .dac_rn1(odsd_rn1),
    .dac_rn2(odsd_rn2),
    .dac_rn3(odsd_rn3)

);


assign odsd_rp5 = latch1394;
assign odsd_lp5 = latch1394;

//assign led = pcm32ldata[7:0];
//assign olrck = obck;

endmodule





`include "adc96.v"
`include "down_rom.v"
`include "down882.v"
`include "down441.v"
`include "dsd128filter.v"
`include "dsd128_rom.v"
