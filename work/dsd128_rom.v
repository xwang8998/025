module dsd128_rom(
input x0,
input x1,
input x2,
input x3,
input x4,
input x5,
input x6,
input x7,
input x8,
input x9,
input y0,
input y1,
input y2,
input y3,
input y4,
input y5,
input y6,
input y7,
input y8,
input y9,
output signed [31:0] tap_left0,
output signed [31:0] tap_left1,
output signed [31:0] tap_left2,
output signed [31:0] tap_left3,
output signed [31:0] tap_left4,
output signed [31:0] tap_left5,
output signed [31:0] tap_left6,
output signed [31:0] tap_left7,
output signed [31:0] tap_left8,
output signed [31:0] tap_left9,
output signed [31:0] tap_right0,
output signed [31:0] tap_right1,
output signed [31:0] tap_right2,
output signed [31:0] tap_right3,
output signed [31:0] tap_right4,
output signed [31:0] tap_right5,
output signed [31:0] tap_right6,
output signed [31:0] tap_right7,
output signed [31:0] tap_right8,
output signed [31:0] tap_right9,
input [4:0] addr
);

wire signed [31:0] TAP128_MAP0[0:31];
wire signed [31:0] TAP128_MAP1[0:31];
wire signed [31:0] TAP128_MAP2[0:31];
wire signed [31:0] TAP128_MAP3[0:31];
wire signed [31:0] TAP128_MAP4[0:31];
wire signed [31:0] TAP128_MAP5[0:31];
wire signed [31:0] TAP128_MAP6[0:31];
wire signed [31:0] TAP128_MAP7[0:31];
wire signed [31:0] TAP128_MAP8[0:31];
wire signed [31:0] TAP128_MAP9[0:31];

assign TAP128_MAP0[0] = 244;
assign TAP128_MAP1[0] = 223;
assign TAP128_MAP2[0] = 323;
assign TAP128_MAP3[0] = 450;
assign TAP128_MAP4[0] = 610;
assign TAP128_MAP5[0] = 808;
assign TAP128_MAP6[0] = 1050;
assign TAP128_MAP7[0] = 1341;
assign TAP128_MAP8[0] = 1689;
assign TAP128_MAP9[0] = 2100;
assign TAP128_MAP0[1] = 2583;
assign TAP128_MAP1[1] = 3144;
assign TAP128_MAP2[1] = 3792;
assign TAP128_MAP3[1] = 4534;
assign TAP128_MAP4[1] = 5378;
assign TAP128_MAP5[1] = 6333;
assign TAP128_MAP6[1] = 7404;
assign TAP128_MAP7[1] = 8601;
assign TAP128_MAP8[1] = 9928;
assign TAP128_MAP9[1] = 11391;
assign TAP128_MAP0[2] = 12995;
assign TAP128_MAP1[2] = 14742;
assign TAP128_MAP2[2] = 16635;
assign TAP128_MAP3[2] = 18671;
assign TAP128_MAP4[2] = 20850;
assign TAP128_MAP5[2] = 23166;
assign TAP128_MAP6[2] = 25611;
assign TAP128_MAP7[2] = 28175;
assign TAP128_MAP8[2] = 30843;
assign TAP128_MAP9[2] = 33597;
assign TAP128_MAP0[3] = 36416;
assign TAP128_MAP1[3] = 39273;
assign TAP128_MAP2[3] = 42138;
assign TAP128_MAP3[3] = 44973;
assign TAP128_MAP4[3] = 47739;
assign TAP128_MAP5[3] = 50389;
assign TAP128_MAP6[3] = 52870;
assign TAP128_MAP7[3] = 55125;
assign TAP128_MAP8[3] = 57089;
assign TAP128_MAP9[3] = 58692;
assign TAP128_MAP0[4] = 59858;
assign TAP128_MAP1[4] = 60504;
assign TAP128_MAP2[4] = 60542;
assign TAP128_MAP3[4] = 59878;
assign TAP128_MAP4[4] = 58411;
assign TAP128_MAP5[4] = 56037;
assign TAP128_MAP6[4] = 52644;
assign TAP128_MAP7[4] = 48117;
assign TAP128_MAP8[4] = 42340;
assign TAP128_MAP9[4] = 35188;
assign TAP128_MAP0[5] = 26537;
assign TAP128_MAP1[5] = 16262;
assign TAP128_MAP2[5] = 4236;
assign TAP128_MAP3[5] = -9668;
assign TAP128_MAP4[5] = -25575;
assign TAP128_MAP5[5] = -43608;
assign TAP128_MAP6[5] = -63883;
assign TAP128_MAP7[5] = -86515;
assign TAP128_MAP8[5] = -111607;
assign TAP128_MAP9[5] = -139257;
assign TAP128_MAP0[6] = -169551;
assign TAP128_MAP1[6] = -202563;
assign TAP128_MAP2[6] = -238354;
assign TAP128_MAP3[6] = -276968;
assign TAP128_MAP4[6] = -318433;
assign TAP128_MAP5[6] = -362756;
assign TAP128_MAP6[6] = -409925;
assign TAP128_MAP7[6] = -459902;
assign TAP128_MAP8[6] = -512627;
assign TAP128_MAP9[6] = -568011;
assign TAP128_MAP0[7] = -625939;
assign TAP128_MAP1[7] = -686263;
assign TAP128_MAP2[7] = -748807;
assign TAP128_MAP3[7] = -813360;
assign TAP128_MAP4[7] = -879677;
assign TAP128_MAP5[7] = -947479;
assign TAP128_MAP6[7] = -1016449;
assign TAP128_MAP7[7] = -1086236;
assign TAP128_MAP8[7] = -1156448;
assign TAP128_MAP9[7] = -1226659;
assign TAP128_MAP0[8] = -1296403;
assign TAP128_MAP1[8] = -1365177;
assign TAP128_MAP2[8] = -1432442;
assign TAP128_MAP3[8] = -1497623;
assign TAP128_MAP4[8] = -1560108;
assign TAP128_MAP5[8] = -1619253;
assign TAP128_MAP6[8] = -1674381;
assign TAP128_MAP7[8] = -1724787;
assign TAP128_MAP8[8] = -1769735;
assign TAP128_MAP9[8] = -1808467;
assign TAP128_MAP0[9] = -1840200;
assign TAP128_MAP1[9] = -1864136;
assign TAP128_MAP2[9] = -1879457;
assign TAP128_MAP3[9] = -1885338;
assign TAP128_MAP4[9] = -1880943;
assign TAP128_MAP5[9] = -1865434;
assign TAP128_MAP6[9] = -1837975;
assign TAP128_MAP7[9] = -1797737;
assign TAP128_MAP8[9] = -1743901;
assign TAP128_MAP9[9] = -1675664;
assign TAP128_MAP0[10] = -1592247;
assign TAP128_MAP1[10] = -1492897;
assign TAP128_MAP2[10] = -1376893;
assign TAP128_MAP3[10] = -1243554;
assign TAP128_MAP4[10] = -1092241;
assign TAP128_MAP5[10] = -922365;
assign TAP128_MAP6[10] = -733393;
assign TAP128_MAP7[10] = -524850;
assign TAP128_MAP8[10] = -296328;
assign TAP128_MAP9[10] = -47489;
assign TAP128_MAP0[11] = 221932;
assign TAP128_MAP1[11] = 512118;
assign TAP128_MAP2[11] = 823170;
assign TAP128_MAP3[11] = 1155100;
assign TAP128_MAP4[11] = 1507830;
assign TAP128_MAP5[11] = 1881189;
assign TAP128_MAP6[11] = 2274907;
assign TAP128_MAP7[11] = 2688617;
assign TAP128_MAP8[11] = 3121852;
assign TAP128_MAP9[11] = 3574043;
assign TAP128_MAP0[12] = 4044520;
assign TAP128_MAP1[12] = 4532510;
assign TAP128_MAP2[12] = 5037141;
assign TAP128_MAP3[12] = 5557439;
assign TAP128_MAP4[12] = 6092333;
assign TAP128_MAP5[12] = 6640658;
assign TAP128_MAP6[12] = 7201156;
assign TAP128_MAP7[12] = 7772479;
assign TAP128_MAP8[12] = 8353196;
assign TAP128_MAP9[12] = 8941798;
assign TAP128_MAP0[13] = 9536699;
assign TAP128_MAP1[13] = 10136248;
assign TAP128_MAP2[13] = 10738731;
assign TAP128_MAP3[13] = 11342380;
assign TAP128_MAP4[13] = 11945381;
assign TAP128_MAP5[13] = 12545878;
assign TAP128_MAP6[13] = 13141987;
assign TAP128_MAP7[13] = 13731801;
assign TAP128_MAP8[13] = 14313397;
assign TAP128_MAP9[13] = 14884852;
assign TAP128_MAP0[14] = 15444242;
assign TAP128_MAP1[14] = 15989660;
assign TAP128_MAP2[14] = 16519223;
assign TAP128_MAP3[14] = 17031078;
assign TAP128_MAP4[14] = 17523416;
assign TAP128_MAP5[14] = 17994476;
assign TAP128_MAP6[14] = 18442561;
assign TAP128_MAP7[14] = 18866040;
assign TAP128_MAP8[14] = 19263359;
assign TAP128_MAP9[14] = 19633050;
assign TAP128_MAP0[15] = 19973739;
assign TAP128_MAP1[15] = 20284151;
assign TAP128_MAP2[15] = 20563118;
assign TAP128_MAP3[15] = 20809587;
assign TAP128_MAP4[15] = 21022621;
assign TAP128_MAP5[15] = 21201410;
assign TAP128_MAP6[15] = 21345270;
assign TAP128_MAP7[15] = 21453651;
assign TAP128_MAP8[15] = 21526138;
assign TAP128_MAP9[15] = 21562450;
assign TAP128_MAP0[16] = 21562450;
assign TAP128_MAP1[16] = 21526138;
assign TAP128_MAP2[16] = 21453651;
assign TAP128_MAP3[16] = 21345270;
assign TAP128_MAP4[16] = 21201410;
assign TAP128_MAP5[16] = 21022621;
assign TAP128_MAP6[16] = 20809587;
assign TAP128_MAP7[16] = 20563118;
assign TAP128_MAP8[16] = 20284151;
assign TAP128_MAP9[16] = 19973739;
assign TAP128_MAP0[17] = 19633050;
assign TAP128_MAP1[17] = 19263359;
assign TAP128_MAP2[17] = 18866040;
assign TAP128_MAP3[17] = 18442561;
assign TAP128_MAP4[17] = 17994476;
assign TAP128_MAP5[17] = 17523416;
assign TAP128_MAP6[17] = 17031078;
assign TAP128_MAP7[17] = 16519223;
assign TAP128_MAP8[17] = 15989660;
assign TAP128_MAP9[17] = 15444242;
assign TAP128_MAP0[18] = 14884852;
assign TAP128_MAP1[18] = 14313397;
assign TAP128_MAP2[18] = 13731801;
assign TAP128_MAP3[18] = 13141987;
assign TAP128_MAP4[18] = 12545878;
assign TAP128_MAP5[18] = 11945381;
assign TAP128_MAP6[18] = 11342380;
assign TAP128_MAP7[18] = 10738731;
assign TAP128_MAP8[18] = 10136248;
assign TAP128_MAP9[18] = 9536699;
assign TAP128_MAP0[19] = 8941798;
assign TAP128_MAP1[19] = 8353196;
assign TAP128_MAP2[19] = 7772479;
assign TAP128_MAP3[19] = 7201156;
assign TAP128_MAP4[19] = 6640658;
assign TAP128_MAP5[19] = 6092333;
assign TAP128_MAP6[19] = 5557439;
assign TAP128_MAP7[19] = 5037141;
assign TAP128_MAP8[19] = 4532510;
assign TAP128_MAP9[19] = 4044520;
assign TAP128_MAP0[20] = 3574043;
assign TAP128_MAP1[20] = 3121852;
assign TAP128_MAP2[20] = 2688617;
assign TAP128_MAP3[20] = 2274907;
assign TAP128_MAP4[20] = 1881189;
assign TAP128_MAP5[20] = 1507830;
assign TAP128_MAP6[20] = 1155100;
assign TAP128_MAP7[20] = 823170;
assign TAP128_MAP8[20] = 512118;
assign TAP128_MAP9[20] = 221932;
assign TAP128_MAP0[21] = -47489;
assign TAP128_MAP1[21] = -296328;
assign TAP128_MAP2[21] = -524850;
assign TAP128_MAP3[21] = -733393;
assign TAP128_MAP4[21] = -922365;
assign TAP128_MAP5[21] = -1092241;
assign TAP128_MAP6[21] = -1243554;
assign TAP128_MAP7[21] = -1376893;
assign TAP128_MAP8[21] = -1492897;
assign TAP128_MAP9[21] = -1592247;
assign TAP128_MAP0[22] = -1675664;
assign TAP128_MAP1[22] = -1743901;
assign TAP128_MAP2[22] = -1797737;
assign TAP128_MAP3[22] = -1837975;
assign TAP128_MAP4[22] = -1865434;
assign TAP128_MAP5[22] = -1880943;
assign TAP128_MAP6[22] = -1885338;
assign TAP128_MAP7[22] = -1879457;
assign TAP128_MAP8[22] = -1864136;
assign TAP128_MAP9[22] = -1840200;
assign TAP128_MAP0[23] = -1808467;
assign TAP128_MAP1[23] = -1769735;
assign TAP128_MAP2[23] = -1724787;
assign TAP128_MAP3[23] = -1674381;
assign TAP128_MAP4[23] = -1619253;
assign TAP128_MAP5[23] = -1560108;
assign TAP128_MAP6[23] = -1497623;
assign TAP128_MAP7[23] = -1432442;
assign TAP128_MAP8[23] = -1365177;
assign TAP128_MAP9[23] = -1296403;
assign TAP128_MAP0[24] = -1226659;
assign TAP128_MAP1[24] = -1156448;
assign TAP128_MAP2[24] = -1086236;
assign TAP128_MAP3[24] = -1016449;
assign TAP128_MAP4[24] = -947479;
assign TAP128_MAP5[24] = -879677;
assign TAP128_MAP6[24] = -813360;
assign TAP128_MAP7[24] = -748807;
assign TAP128_MAP8[24] = -686263;
assign TAP128_MAP9[24] = -625939;
assign TAP128_MAP0[25] = -568011;
assign TAP128_MAP1[25] = -512627;
assign TAP128_MAP2[25] = -459902;
assign TAP128_MAP3[25] = -409925;
assign TAP128_MAP4[25] = -362756;
assign TAP128_MAP5[25] = -318433;
assign TAP128_MAP6[25] = -276968;
assign TAP128_MAP7[25] = -238354;
assign TAP128_MAP8[25] = -202563;
assign TAP128_MAP9[25] = -169551;
assign TAP128_MAP0[26] = -139257;
assign TAP128_MAP1[26] = -111607;
assign TAP128_MAP2[26] = -86515;
assign TAP128_MAP3[26] = -63883;
assign TAP128_MAP4[26] = -43608;
assign TAP128_MAP5[26] = -25575;
assign TAP128_MAP6[26] = -9668;
assign TAP128_MAP7[26] = 4236;
assign TAP128_MAP8[26] = 16262;
assign TAP128_MAP9[26] = 26537;
assign TAP128_MAP0[27] = 35188;
assign TAP128_MAP1[27] = 42340;
assign TAP128_MAP2[27] = 48117;
assign TAP128_MAP3[27] = 52644;
assign TAP128_MAP4[27] = 56037;
assign TAP128_MAP5[27] = 58411;
assign TAP128_MAP6[27] = 59878;
assign TAP128_MAP7[27] = 60542;
assign TAP128_MAP8[27] = 60504;
assign TAP128_MAP9[27] = 59858;
assign TAP128_MAP0[28] = 58692;
assign TAP128_MAP1[28] = 57089;
assign TAP128_MAP2[28] = 55125;
assign TAP128_MAP3[28] = 52870;
assign TAP128_MAP4[28] = 50389;
assign TAP128_MAP5[28] = 47739;
assign TAP128_MAP6[28] = 44973;
assign TAP128_MAP7[28] = 42138;
assign TAP128_MAP8[28] = 39273;
assign TAP128_MAP9[28] = 36416;
assign TAP128_MAP0[29] = 33597;
assign TAP128_MAP1[29] = 30843;
assign TAP128_MAP2[29] = 28175;
assign TAP128_MAP3[29] = 25611;
assign TAP128_MAP4[29] = 23166;
assign TAP128_MAP5[29] = 20850;
assign TAP128_MAP6[29] = 18671;
assign TAP128_MAP7[29] = 16635;
assign TAP128_MAP8[29] = 14742;
assign TAP128_MAP9[29] = 12995;
assign TAP128_MAP0[30] = 11391;
assign TAP128_MAP1[30] = 9928;
assign TAP128_MAP2[30] = 8601;
assign TAP128_MAP3[30] = 7404;
assign TAP128_MAP4[30] = 6333;
assign TAP128_MAP5[30] = 5378;
assign TAP128_MAP6[30] = 4534;
assign TAP128_MAP7[30] = 3792;
assign TAP128_MAP8[30] = 3144;
assign TAP128_MAP9[30] = 2583;
assign TAP128_MAP0[31] = 2100;
assign TAP128_MAP1[31] = 1689;
assign TAP128_MAP2[31] = 1341;
assign TAP128_MAP3[31] = 1050;
assign TAP128_MAP4[31] = 808;
assign TAP128_MAP5[31] = 610;
assign TAP128_MAP6[31] = 450;
assign TAP128_MAP7[31] = 323;
assign TAP128_MAP8[31] = 223;
assign TAP128_MAP9[31] = 244;

wire signed [31:0]l128_0 = x0 ? TAP128_MAP0[addr] : (32'd0 - TAP128_MAP0[addr]);
wire signed [31:0]r128_0 = y0 ? TAP128_MAP0[addr] : (32'd0 - TAP128_MAP0[addr]);
assign tap_left0 = l128_0;
assign tap_right0 = r128_0;
wire signed [31:0]l128_1 = x1 ? TAP128_MAP1[addr] : (32'd0 - TAP128_MAP1[addr]);
wire signed [31:0]r128_1 = y1 ? TAP128_MAP1[addr] : (32'd0 - TAP128_MAP1[addr]);
assign tap_left1 = l128_1;
assign tap_right1 = r128_1;
wire signed [31:0]l128_2 = x2 ? TAP128_MAP2[addr] : (32'd0 - TAP128_MAP2[addr]);
wire signed [31:0]r128_2 = y2 ? TAP128_MAP2[addr] : (32'd0 - TAP128_MAP2[addr]);
assign tap_left2 = l128_2;
assign tap_right2 = r128_2;
wire signed [31:0]l128_3 = x3 ? TAP128_MAP3[addr] : (32'd0 - TAP128_MAP3[addr]);
wire signed [31:0]r128_3 = y3 ? TAP128_MAP3[addr] : (32'd0 - TAP128_MAP3[addr]);
assign tap_left3 = l128_3;
assign tap_right3 = r128_3;
wire signed [31:0]l128_4 = x4 ? TAP128_MAP4[addr] : (32'd0 - TAP128_MAP4[addr]);
wire signed [31:0]r128_4 = y4 ? TAP128_MAP4[addr] : (32'd0 - TAP128_MAP4[addr]);
assign tap_left4 = l128_4;
assign tap_right4 = r128_4;
wire signed [31:0]l128_5 = x5 ? TAP128_MAP5[addr] : (32'd0 - TAP128_MAP5[addr]);
wire signed [31:0]r128_5 = y5 ? TAP128_MAP5[addr] : (32'd0 - TAP128_MAP5[addr]);
assign tap_left5 = l128_5;
assign tap_right5 = r128_5;
wire signed [31:0]l128_6 = x6 ? TAP128_MAP6[addr] : (32'd0 - TAP128_MAP6[addr]);
wire signed [31:0]r128_6 = y6 ? TAP128_MAP6[addr] : (32'd0 - TAP128_MAP6[addr]);
assign tap_left6 = l128_6;
assign tap_right6 = r128_6;
wire signed [31:0]l128_7 = x7 ? TAP128_MAP7[addr] : (32'd0 - TAP128_MAP7[addr]);
wire signed [31:0]r128_7 = y7 ? TAP128_MAP7[addr] : (32'd0 - TAP128_MAP7[addr]);
assign tap_left7 = l128_7;
assign tap_right7 = r128_7;
wire signed [31:0]l128_8 = x8 ? TAP128_MAP8[addr] : (32'd0 - TAP128_MAP8[addr]);
wire signed [31:0]r128_8 = y8 ? TAP128_MAP8[addr] : (32'd0 - TAP128_MAP8[addr]);
assign tap_left8 = l128_8;
assign tap_right8 = r128_8;
wire signed [31:0]l128_9 = x9 ? TAP128_MAP9[addr] : (32'd0 - TAP128_MAP9[addr]);
wire signed [31:0]r128_9 = y9 ? TAP128_MAP9[addr] : (32'd0 - TAP128_MAP9[addr]);
assign tap_left9 = l128_9;
assign tap_right9 = r128_9;

endmodule

