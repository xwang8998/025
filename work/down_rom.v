module down_rom(
input [6:0] addr,
input use_882,
output signed [31:0] tap);

wire signed [31:0] TAP882[0:127];
wire signed [31:0] TAP441[0:127];

assign tap = use_882 ? TAP882[addr] : TAP441[addr];

assign TAP882[0] = 34356;
assign TAP882[1] = 234600;
assign TAP882[2] = 449007;
assign TAP882[3] = -55933;
assign TAP882[4] = -1013010;
assign TAP882[5] = -164690;
assign TAP882[6] = 2155264;
assign TAP882[7] = 648338;
assign TAP882[8] = -4153377;
assign TAP882[9] = -1463334;
assign TAP882[10] = 7459258;
assign TAP882[11] = 2635159;
assign TAP882[12] = -12729651;
assign TAP882[13] = -4119673;
assign TAP882[14] = 20995503;
assign TAP882[15] = 5792089;
assign TAP882[16] = -34186598;
assign TAP882[17] = -7457024;
assign TAP882[18] = 57033119;
assign TAP882[19] = 8881399;
assign TAP882[20] = -106755314;
assign TAP882[21] = -9843713;
assign TAP882[22] = 339325296;
assign TAP882[23] = 547054518;
assign TAP882[24] = 339325296;
assign TAP882[25] = -9843713;
assign TAP882[26] = -106755314;
assign TAP882[27] = 8881399;
assign TAP882[28] = 57033119;
assign TAP882[29] = -7457024;
assign TAP882[30] = -34186598;
assign TAP882[31] = 5792089;
assign TAP882[32] = 20995503;
assign TAP882[33] = -4119673;
assign TAP882[34] = -12729651;
assign TAP882[35] = 2635159;
assign TAP882[36] = 7459258;
assign TAP882[37] = -1463334;
assign TAP882[38] = -4153377;
assign TAP882[39] = 648338;
assign TAP882[40] = 2155264;
assign TAP882[41] = -164690;
assign TAP882[42] = -1013010;
assign TAP882[43] = -55933;
assign TAP882[44] = 449007;
assign TAP882[45] = 234600;
assign TAP882[46] = 34356;
assign TAP882[47] = 0;
assign TAP882[48] = 0;
assign TAP882[49] = 0;
assign TAP882[50] = 0;
assign TAP882[51] = 0;
assign TAP882[52] = 0;
assign TAP882[53] = 0;
assign TAP882[54] = 0;
assign TAP882[55] = 0;
assign TAP882[56] = 0;
assign TAP882[57] = 0;
assign TAP882[58] = 0;
assign TAP882[59] = 0;
assign TAP882[60] = 0;
assign TAP882[61] = 0;
assign TAP882[62] = 0;
assign TAP882[63] = 0;
assign TAP882[64] = 0;
assign TAP882[65] = 0;
assign TAP882[66] = 0;
assign TAP882[67] = 0;
assign TAP882[68] = 0;
assign TAP882[69] = 0;
assign TAP882[70] = 0;
assign TAP882[71] = 0;
assign TAP882[72] = 0;
assign TAP882[73] = 0;
assign TAP882[74] = 0;
assign TAP882[75] = 0;
assign TAP882[76] = 0;
assign TAP882[77] = 0;
assign TAP882[78] = 0;
assign TAP882[79] = 0;
assign TAP882[80] = 0;
assign TAP882[81] = 0;
assign TAP882[82] = 0;
assign TAP882[83] = 0;
assign TAP882[84] = 0;
assign TAP882[85] = 0;
assign TAP882[86] = 0;
assign TAP882[87] = 0;
assign TAP882[88] = 0;
assign TAP882[89] = 0;
assign TAP882[90] = 0;
assign TAP882[91] = 0;
assign TAP882[92] = 0;
assign TAP882[93] = 0;
assign TAP882[94] = 0;
assign TAP882[95] = 0;
assign TAP882[96] = 0;
assign TAP882[97] = 0;
assign TAP882[98] = 0;
assign TAP882[99] = 0;
assign TAP882[100] = 0;
assign TAP882[101] = 0;
assign TAP882[102] = 0;
assign TAP882[103] = 0;
assign TAP882[104] = 0;
assign TAP882[105] = 0;
assign TAP882[106] = 0;
assign TAP882[107] = 0;
assign TAP882[108] = 0;
assign TAP882[109] = 0;
assign TAP882[110] = 0;
assign TAP882[111] = 0;
assign TAP882[112] = 0;
assign TAP882[113] = 0;
assign TAP882[114] = 0;
assign TAP882[115] = 0;
assign TAP882[116] = 0;
assign TAP882[117] = 0;
assign TAP882[118] = 0;
assign TAP882[119] = 0;
assign TAP882[120] = 0;
assign TAP882[121] = 0;
assign TAP882[122] = 0;
assign TAP882[123] = 0;
assign TAP882[124] = 0;
assign TAP882[125] = 0;
assign TAP882[126] = 0;
assign TAP882[127] = 0;

assign TAP441[0] = 2990;
assign TAP441[1] = 38752;
assign TAP441[2] = 125310;
assign TAP441[3] = 182494;
assign TAP441[4] = 81737;
assign TAP441[5] = -113051;
assign TAP441[6] = -122593;
assign TAP441[7] = 108800;
assign TAP441[8] = 188415;
assign TAP441[9] = -104489;
assign TAP441[10] = -281726;
assign TAP441[11] = 83194;
assign TAP441[12] = 401364;
assign TAP441[13] = -34782;
assign TAP441[14] = -546337;
assign TAP441[15] = -50268;
assign TAP441[16] = 715049;
assign TAP441[17] = 181877;
assign TAP441[18] = -905343;
assign TAP441[19] = -371872;
assign TAP441[20] = 1112248;
assign TAP441[21] = 631947;
assign TAP441[22] = -1329460;
assign TAP441[23] = -975006;
assign TAP441[24] = 1547907;
assign TAP441[25] = 1414105;
assign TAP441[26] = -1756219;
assign TAP441[27] = -1962889;
assign TAP441[28] = 1940039;
assign TAP441[29] = 2635184;
assign TAP441[30] = -2081966;
assign TAP441[31] = -3445068;
assign TAP441[32] = 2161394;
assign TAP441[33] = 4407370;
assign TAP441[34] = -2153708;
assign TAP441[35] = -5537781;
assign TAP441[36] = 2030023;
assign TAP441[37] = 6854156;
assign TAP441[38] = -1755769;
assign TAP441[39] = -8377848;
assign TAP441[40] = 1289163;
assign TAP441[41] = 10136705;
assign TAP441[42] = -577859;
assign TAP441[43] = -12169443;
assign TAP441[44] = -446367;
assign TAP441[45] = 14533431;
assign TAP441[46] = 1877275;
assign TAP441[47] = -17318579;
assign TAP441[48] = -3852418;
assign TAP441[49] = 20673169;
assign TAP441[50] = 6588957;
assign TAP441[51] = -24856929;
assign TAP441[52] = -10461442;
assign TAP441[53] = 30360224;
assign TAP441[54] = 16189301;
assign TAP441[55] = -38214014;
assign TAP441[56] = -25371752;
assign TAP441[57] = 50974388;
assign TAP441[58] = 42449007;
assign TAP441[59] = -77081451;
assign TAP441[60] = -86078115;
assign TAP441[61] = 170084762;
assign TAP441[62] = 473528275;
assign TAP441[63] = 473528275;
assign TAP441[64] = 170084762;
assign TAP441[65] = -86078115;
assign TAP441[66] = -77081451;
assign TAP441[67] = 42449007;
assign TAP441[68] = 50974388;
assign TAP441[69] = -25371752;
assign TAP441[70] = -38214014;
assign TAP441[71] = 16189301;
assign TAP441[72] = 30360224;
assign TAP441[73] = -10461442;
assign TAP441[74] = -24856929;
assign TAP441[75] = 6588957;
assign TAP441[76] = 20673169;
assign TAP441[77] = -3852418;
assign TAP441[78] = -17318579;
assign TAP441[79] = 1877275;
assign TAP441[80] = 14533431;
assign TAP441[81] = -446367;
assign TAP441[82] = -12169443;
assign TAP441[83] = -577859;
assign TAP441[84] = 10136705;
assign TAP441[85] = 1289163;
assign TAP441[86] = -8377848;
assign TAP441[87] = -1755769;
assign TAP441[88] = 6854156;
assign TAP441[89] = 2030023;
assign TAP441[90] = -5537781;
assign TAP441[91] = -2153708;
assign TAP441[92] = 4407370;
assign TAP441[93] = 2161394;
assign TAP441[94] = -3445068;
assign TAP441[95] = -2081966;
assign TAP441[96] = 2635184;
assign TAP441[97] = 1940039;
assign TAP441[98] = -1962889;
assign TAP441[99] = -1756219;
assign TAP441[100] = 1414105;
assign TAP441[101] = 1547907;
assign TAP441[102] = -975006;
assign TAP441[103] = -1329460;
assign TAP441[104] = 631947;
assign TAP441[105] = 1112248;
assign TAP441[106] = -371872;
assign TAP441[107] = -905343;
assign TAP441[108] = 181877;
assign TAP441[109] = 715049;
assign TAP441[110] = -50268;
assign TAP441[111] = -546337;
assign TAP441[112] = -34782;
assign TAP441[113] = 401364;
assign TAP441[114] = 83194;
assign TAP441[115] = -281726;
assign TAP441[116] = -104489;
assign TAP441[117] = 188415;
assign TAP441[118] = 108800;
assign TAP441[119] = -122593;
assign TAP441[120] = -113051;
assign TAP441[121] = 81737;
assign TAP441[122] = 182494;
assign TAP441[123] = 125310;
assign TAP441[124] = 38752;
assign TAP441[125] = 2990;
assign TAP441[126] = 0;
assign TAP441[127] = 0;

endmodule
