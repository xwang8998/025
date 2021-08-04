
module minidsp(
input mclk,
input reset_n,

input scl,
inout sda,

//sdio debug
input [7:0] sd0,
input [7:0] sd1,
input [7:0] sd2,
input [7:0] sd3,
input [7:0] sd4,

output [7:0] debug,

//input
input [31:0] xl,
input [31:0] xr,

output [31:0] yl,
output [31:0] yr
);


/////////////////////////////i2c/////////////////////////////
wire [255:0] i2c_mem;
wire  sda_out, sda_out_en;
i2c UI2C(.mclk(mclk), .reset_n(reset_n), .i2c_mem(i2c_mem), .scl(scl), .sda(sda),
    .sda_out(sda_out), .sda_out_en(sda_out_en));

assign sda = sda_out_en? sda_out: 1'bz;



// sdio debug
reg [7:0] a0, a1, a2, a3, a4;
always @(posedge mclk) a0 <= sd0;
always @(posedge mclk) a1 <= sd1;
always @(posedge mclk) a2 <= sd2;
always @(posedge mclk) a3 <= sd3;
always @(posedge mclk) a4 <= sd4;

reg [7:0] b0,b1,b2,b3,b4;
always @(posedge mclk) b0 <= a0;
always @(posedge mclk) b1 <= a1;
always @(posedge mclk) b2 <= a2;
always @(posedge mclk) b3 <= a3;
always @(posedge mclk) b4 <= a4;

///config/////
wire start_stop;    //start_stop dsp
wire [31:0] wdata;  //program code
wire [6:0] waddr;   //program addr
wire we;            //write enable
config_dsp UCFGDSP(.mclk(mclk), .reset_n(reset_n),
  .cmd(b0), .reg1(b1), .reg2(b2), .reg3(b3), .reg4(b4),
    .start_dsp(start_stop), .we(we), .wdata(wdata), .addr(waddr));

///////////////code ram///////////////
wire [6:0] raddr;
wire [6:0] addr = start_stop? raddr : waddr;
wire [31:0] rdata;
ramcode UCODE(.mclk(mclk), .we(we), .addr(addr), .wdata(wdata), .rdata(rdata));


//////////////data ram /////////////
wire ram_wen;
wire [15:0] ram_addr;
wire [17:0] wdata18, rdata18;
ram31 URAM31(.mclk(mclk), .wen(ram_wen), .addr(ram_addr[14:0]), .wdata(wdata18), .rdata(rdata18));

//debug waddr for dataram
reg [6:0] dd;
always @(posedge mclk) 
    if (start_stop) 
        if (ram_wen) dd <= ram_addr[6:0]; else dd <= dd;
    else
        dd <= 7'd0;







///dsp///
wire [31:0] rdata32;
wire [31:0] wdata32;

//need a 18bit floating point to 32bit fixed converter here
fixed2float UF1 (.float(wdata18), .fixed(wdata32));
float2fixed UF2 (.float(rdata18), .fixed(rdata32));

////////////////////////////LFOs///////////////////////////////
reg mclk_d2, mclk_d4, mclk_d8, mclk_d16; 
always @(posedge mclk) mclk_d2 <= ~mclk_d2;
always @(posedge mclk_d2) mclk_d4 <= ~mclk_d4;
always @(posedge mclk_d4) mclk_d8 <= ~mclk_d8;
always @(posedge mclk_d8) mclk_d16 <= ~mclk_d16;

wire signed [31:0] sin1,sin2,cos1,cos2;
wire [8:0] kfreq1, kfreq2;
wire [14:0] amp1, amp2;
osc ULFO1(.mclk_d16(mclk_d16),.reset_n(reset_n & start_stop), 
    .kfreq(kfreq1), .amp(amp1), .cos(cos1), .sin(sin1));
osc ULFO2(.mclk_d16(mclk_d16),.reset_n(reset_n & start_stop), 
    .kfreq(kfreq2), .amp(amp2), .cos(cos2), .sin(sin2));

//pots
wire [15:0] pot0 = 0;
wire [15:0] pot1 = 0;
wire [15:0] pot2 = 0;
wire [15:0] pot3 = 0;


wire [7:0] db_dsp;
dsp_core UDSP( .mclk(mclk), .reset_n(reset_n & start_stop), .start(start_stop), .ram_din(rdata32),
 .ram_addr(ram_addr), .ram_wdata(wdata32), .ram_wen(ram_wen),
 .kfreq1(kfreq1), .amp1(amp1), .kfreq2(kfreq2), .amp2(amp2), 
 .sin1x(sin1), .sin2x(sin2), .cos1x(cos1), .cos2x(cos2),
 .pot0(pot0), .pot1(pot1), .pot2(pot2), .pot3(pot3),
 .code_addr(raddr), .codeword(rdata), 
 .debug(db_dsp),
 .xl(xl), .xr(xr), .yl(yl), .yr(yr));

//assign debug = {waddr, start_stop};
//assign debug = {dd, start_stop};
assign debug = db_dsp;

endmodule

`include "config.v"
`include "ramcode.v"
`include "ram1kx18.v"
`include "ram31.v"
`include "dspcore.v"
`include "osc.v"
`include "f2f.v"
`include "i2c.v"



