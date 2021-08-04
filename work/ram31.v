
// this will use 31Kx18 block ram, all of the igloo2 005's ram

module ram31(
   input mclk,
   input wen,
   input [14:0] addr,
   input [17:0] wdata,
   output [17:0] rdata
);

wire [17:0] rdatax [0:30];
wire [4:0] sel = addr[14:10];
assign rdata = (sel < 5'd31) ? rdatax[sel] : 18'd0;

wire wen0 = (sel == 5'd0) ? wen : 1'b0;
wire wen1 = (sel == 5'd1) ? wen : 1'b0;
wire wen2 = (sel == 5'd2) ? wen : 1'b0;
wire wen3 = (sel == 5'd3) ? wen : 1'b0;
wire wen4 = (sel == 5'd4) ? wen : 1'b0;
wire wen5 = (sel == 5'd5) ? wen : 1'b0;
wire wen6 = (sel == 5'd6) ? wen : 1'b0;
wire wen7 = (sel == 5'd7) ? wen : 1'b0;
wire wen8 = (sel == 5'd8) ? wen : 1'b0;
wire wen9 = (sel == 5'd9) ? wen : 1'b0;
wire wen10 = (sel == 5'd10) ? wen : 1'b0;
wire wen11 = (sel == 5'd11) ? wen : 1'b0;
wire wen12 = (sel == 5'd12) ? wen : 1'b0;
wire wen13 = (sel == 5'd13) ? wen : 1'b0;
wire wen14 = (sel == 5'd14) ? wen : 1'b0;
wire wen15 = (sel == 5'd15) ? wen : 1'b0;
wire wen16 = (sel == 5'd16) ? wen : 1'b0;
wire wen17 = (sel == 5'd17) ? wen : 1'b0;
wire wen18 = (sel == 5'd18) ? wen : 1'b0;
wire wen19 = (sel == 5'd19) ? wen : 1'b0;
wire wen20 = (sel == 5'd20) ? wen : 1'b0;
wire wen21 = (sel == 5'd21) ? wen : 1'b0;
wire wen22 = (sel == 5'd22) ? wen : 1'b0;
wire wen23 = (sel == 5'd23) ? wen : 1'b0;
wire wen24 = (sel == 5'd24) ? wen : 1'b0;
wire wen25 = (sel == 5'd25) ? wen : 1'b0;
wire wen26 = (sel == 5'd26) ? wen : 1'b0;
wire wen27 = (sel == 5'd27) ? wen : 1'b0;
wire wen28 = (sel == 5'd28) ? wen : 1'b0;
wire wen29 = (sel == 5'd29) ? wen : 1'b0;
wire wen30 = (sel == 5'd30) ? wen : 1'b0;

ram1Kx18 smallram0 (.mclk(mclk), .wen(wen0),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[0]));
ram1Kx18 smallram1 (.mclk(mclk), .wen(wen1),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[1]));
ram1Kx18 smallram2 (.mclk(mclk), .wen(wen2),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[2]));
ram1Kx18 smallram3 (.mclk(mclk), .wen(wen3),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[3]));
ram1Kx18 smallram4 (.mclk(mclk), .wen(wen4),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[4]));
ram1Kx18 smallram5 (.mclk(mclk), .wen(wen5),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[5]));
ram1Kx18 smallram6 (.mclk(mclk), .wen(wen6),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[6]));
ram1Kx18 smallram7 (.mclk(mclk), .wen(wen7),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[7]));
ram1Kx18 smallram8 (.mclk(mclk), .wen(wen8),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[8]));
ram1Kx18 smallram9 (.mclk(mclk), .wen(wen9),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[9]));
ram1Kx18 smallram10 (.mclk(mclk), .wen(wen10),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[10]));
ram1Kx18 smallram11 (.mclk(mclk), .wen(wen11),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[11]));
ram1Kx18 smallram12 (.mclk(mclk), .wen(wen12),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[12]));
ram1Kx18 smallram13 (.mclk(mclk), .wen(wen13),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[13]));
ram1Kx18 smallram14 (.mclk(mclk), .wen(wen14),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[14]));
ram1Kx18 smallram15 (.mclk(mclk), .wen(wen15),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[15]));
ram1Kx18 smallram16 (.mclk(mclk), .wen(wen16),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[16]));
ram1Kx18 smallram17 (.mclk(mclk), .wen(wen17),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[17]));
ram1Kx18 smallram18 (.mclk(mclk), .wen(wen18),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[18]));
ram1Kx18 smallram19 (.mclk(mclk), .wen(wen19),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[19]));
ram1Kx18 smallram20 (.mclk(mclk), .wen(wen20),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[20]));
ram1Kx18 smallram21 (.mclk(mclk), .wen(wen21),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[21]));
ram1Kx18 smallram22 (.mclk(mclk), .wen(wen22),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[22]));
ram1Kx18 smallram23 (.mclk(mclk), .wen(wen23),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[23]));
ram1Kx18 smallram24 (.mclk(mclk), .wen(wen24),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[24]));
ram1Kx18 smallram25 (.mclk(mclk), .wen(wen25),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[25]));
ram1Kx18 smallram26 (.mclk(mclk), .wen(wen26),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[26]));
ram1Kx18 smallram27 (.mclk(mclk), .wen(wen27),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[27]));
ram1Kx18 smallram28 (.mclk(mclk), .wen(wen28),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[28]));
ram1Kx18 smallram29 (.mclk(mclk), .wen(wen29),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[29]));
ram1Kx18 smallram30 (.mclk(mclk), .wen(wen30),  .addr(addr[9:0]), .wdata(wdata), .rdata(rdatax[30]));

endmodule



