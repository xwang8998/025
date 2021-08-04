module pcmsinegear(
input mclk,
input reset_n,
input sample,
output bick,
output pcm32ldata,
output pcm32rdata
);
wire signed [31:0] pcm;
wire signed [31:0] angle;
//assign angle = 'b00100000000000000000000000000000;
assign angle = 12173944;       //1KHz @ 352.8KHz @45MHz Mclk
//assign angle = 3043486;        //250Hz @ 352.8KHz
//assign angle = 97391549;       //1KHz @ 44.1KHz
//assign angle = 584349294;     //1khz  @8khz


parameter LEVEL_0dB =  40'd1304065748 * 256;
parameter LEVEL_N12dB = 40'd1304065748 * 64;
parameter LEVEL_N60dB = 40'd1304065748 / 4; 
parameter LEVEL_MUTE = 40'd0;

wire signed [39:0] level;  // amplitude of wavegen
assign level = LEVEL_0dB;
reg signed [31:0] pcmslow;

// generate slow pcm
//reg [11:0] i;    //11.025k
//reg [9:0] i;   //44.1K
reg [8:0] i;   //88.2K
//reg [7:0] i;   //176.4K
//reg [6:0] i;    //352.8k
assign start = 1'b1;
reg clkd2;
always @(posedge mclk or negedge reset_n) if (0 == reset_n) clkd2 <= 0; else clkd2 <= ~clkd2;

reg clkd4;
always @(posedge clkd2 or negedge reset_n) if (0 == reset_n) clkd4 <= 0; else clkd4 <= ~clkd4;

reg clkd8;
always @(posedge clkd4 or negedge reset_n) if (0 == reset_n) clkd8 <= 0; else clkd8 <= ~clkd8;

reg clkd16;
always @(posedge clkd8 or negedge reset_n) if (0 == reset_n) clkd16 <= 0; else clkd16 <= ~clkd16;
assign bick = clkd8;
wavegen u_wavegen(.pclk(mclk), .preset_n(reset_n), .start(start),
     .level(level),
     .angle(angle), .started(), .pcm_out(pcm));
	 
always @(posedge mclk or negedge reset_n) begin
    if (0==reset_n) begin
        i<=0;  
		pcmslow <= 0;
		
	    
	   
        end
    else begin
        i <= i+1;
        if (i==0) begin
            pcmslow <= pcm; 
               end
		
        end
		
end
assign pcm32ldata = pcmslow;
assign pcm32rdata = pcmslow;
endmodule