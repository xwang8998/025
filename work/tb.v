
// test bench 

`timescale 1ps/1ps

module tbdsp();

initial begin $dumpfile ("0.vcd"); $dumpvars; #600000000 $finish; end   //600us

initial begin 
    // long debug
    //$dumpvars (1, lrck); 
    //#600000000000 $finish;   //0.6s
    //#6000000000000 $finish;     //6s
    //#500000000000 $finish;     //0.5
   // #1500000000000 $finish;     //1.5

    // short debug
   // $dumpfile ("0.vcd"); 
   // $dumpvars;
   // #6000000000 $finish;   //0.006s
    end

reg reset_n; initial begin reset_n = 1; #10000 reset_n = 0; #100000 reset_n = 1; end
reg mclk; initial begin mclk = 0; #313333 mclk = 0; forever #11072.1 mclk = ~mclk; end


reg [7:0] cmd;
reg [31:0] code;
initial  begin
   #100 cmd = 0; code = 0;
   #513333 cmd = 0; code = 0;
   #22144.2 cmd = 4; code = 0;  //stop
   #22144.2 cmd = 1; code = 0;  //init
   #11072100 code = 0; cmd = 0;  //NOP
//   # OR: 0000000F
   #10000 code =code;

//# RDAX 13 1.00: 3FFF01A1
   #44288.4 code = 32'h3FFF01A1; #100 cmd = 2;  //push
   #44288.4 cmd = 0; #100 code = 0; //push
//# WRA 18 0.00: 00000245
   #44288.4 code = 32'h00000245; #100 cmd = 2;  //push
   #44288.4 cmd = 0; #100 code = 0; //push

//# SOF 0.00 0.00: 0000000D
   #44288.4 code = 32'h0000000D; #100 cmd = 2;  //push
   #44288.4 cmd = 0; #100 code = 0; //push
//# RDA 20 1.00: 3FE00282
   #44288.4 code = 32'h3FE00282; #100 cmd = 2;  //push
   #44288.4 cmd = 0; #100 code = 0; //push
//# WRAX 15 0.00: 000001E4
   #44288.4 code = 32'h000001E4; #100 cmd = 2;  //push
   #44288.4 cmd = 0; #100 code = 0; //push




   #22144.2 cmd = 3; code = 0;   //start
   end

reg [7:0] s0, s1, s2, s3, s4;
reg [31:0] xl, xr;
wire [31:0] yl, yr;
wire [7:0] debug;
reg [7:0] i;

always @(posedge mclk or negedge reset_n) 
    if (1'b0 == reset_n) begin
        xl <= 0; xr <= 0; s0 <= 0; s1 <= 0; s2 <= 0; s3 <= 0; s4 <=0;
        i <= 0;
        end
    else begin
        i <= i +1;
        if (i==0) xr <= xr +256;
        s0 <= cmd;
        {s1, s2, s3, s4} <= code;
        end



minidsp UDSP(.mclk(mclk), .reset_n(reset_n), .sd0(s0), .sd1(s1), .sd2(s2), .sd3(s3), .sd4(s4),
.debug(debug), .xl(xr), .xr(xr), .yl(yl), .yr(yr));


endmodule


`include "minidsp.v"

