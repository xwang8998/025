`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/26 14:52:46
// Design Name: 
// Module Name: GEN_DDS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GEN_DDS(
       input mclk,
       input reset_n,
       
       output signed [31:0] pcml,
       output signed [31:0] pcmr
       );
    
    
reg start;
wire signed [31:0] pcm;
wire signed [31:0] angle;
wire started;

//assign angle = 'b00100000000000000000000000000000;
assign angle = 12173944;       //1KHz @ 352.8KHz @45MHz Mclk
//assign angle = 3043486;        //250Hz @ 352.8KHz
//assign angle = 97391549;       //1KHz @ 44.1KHz

parameter LEVEL_0dB =  40'd1304065748 * 256;
parameter LEVEL_N12dB = 40'd1304065748 * 64;
parameter LEVEL_N60dB = 40'd1304065748 / 4; 
parameter LEVEL_MUTE = 40'd0;

wire signed [39:0] level;  // amplitude of wavegen
assign level = LEVEL_0dB;

// generate slow pcm
reg [9:0] i;   //44.1K
//reg [8:0] i;   //88.2K
//reg [7:0] i;   //176.4K
//reg [6:0] i;    //352.8k
reg signed [31:0] pcmslow;
reg [9:0] cnt;

assign pcml = pcmslow;
assign pcmr =pcmslow;


always @(posedge mclk or negedge reset_n) begin
    if (0==reset_n) begin
        i<=0;  
		pcmslow <= 0;
		start<=0;
		cnt <=0;
        end
    else begin
        if(cnt==1000) cnt<=cnt;else cnt<=cnt+1;
        if(cnt==1000) start<=1'b1;
        i <= i+1;
        if (i==0) begin
            pcmslow <= pcm; 
            end
        end
end


wavegen U100(.pclk(mclk), .preset_n(reset_n), .start(start),
     .level(level),
     .angle(angle), .started(started), .pcm_out(pcm));

endmodule