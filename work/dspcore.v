

// mem management:
// each instruction need 2 cycles
// 1) run
// 2) run_xxx
// READ:
// in run cycle, we need to get data from mem, so we can do mult-add in run_xxx
// so in order to read (pipelined), read_addr must be ready in run_xxx cycle
// we need a n_read_addr == xxx in run_cycle, read_addr was extracted from precode
// WRITE:
// in run cycle, we need to write acc into mem, so write_addr and write_en is enabled in run cycle
// we need to prepare n_write_addr = xxx in run_xxx cycle, extract write_addr and write_en from precode
// @run_xxx
//


// ACC format: s.4.27 range -16 to 15.9999
// coeff16:  s.1.14   range -2 to 1.9999
// coeff11:  s.1.9    range -2 to 1.99


//
// mclk is 45.1584MHz, which is  256x176400, in order to execute  128 DSP instructions
// in a 176400 sample, each DSP instruction must be finished in one or two mclk cycles
// not easy but doable.
// in this version, we assume mclk is 256x sample rate, so we will execute a instruaction
// in <=2 mclk cycles, and finish all DSP operations in <= 256 mclk cycles
// maximum DSP instructions per program is 128
//

//  internal register address
//  0000 ==> kfreq1
//  0001 ==> amp1
//  0002 ==> kfreq2
//  0003 ==> amp2
//  0004 ==> ramp1_rate
//  0005 ==> ramp1_amp
//  0006 ==> ramp2_rate
//  0007 ==> ramp2_amp
//  0008 ==> pot0
//  0009 ==> pot1
//  0010 ==> pot2
//  0011 ==> pot3
//  0012 ==> adcl
//  0013 ==> adcr
//  0014 ==> dacl
//  0015 ==> dacr
//  0016 ==> addr_ptr

module dsp_core(
input mclk,    //256x sample rate
input reset_n,
input start,

//delay line memory interface
input [31:0] ram_din,     //read from delay memory
output [15:0] ram_addr,   // r/w addr
output [31:0] ram_wdata,  //write to delay memory
output ram_wen,  

////////LFO interface ////////
output [8:0] kfreq1,
output [8:0] kfreq2,
output [14:0] amp1,
output [14:0] amp2,
input signed [31:0] sin1x,
input signed [31:0] cos1x,
input signed [31:0] sin2x,
input signed [31:0] cos2x,

///external pot control
input [15:0] pot0,
input [15:0] pot1,
input [15:0] pot2,
input [15:0] pot3,

//programmer interface
output [6:0] code_addr,
input [31:0] codeword,

//incoming pcm
input [31:0] xl,
input [31:0] xr,

//output pcm
output [31:0] yl,
output [31:0] yr,
output [7:0] debug
);

reg [7:0] dbg, n_dbg;
assign debug = dbg;

reg [31:0] code, n_code;
reg [31:0] precode, n_precode;

//states
reg [2:0] state, n_state;
parameter IDLE = 3'd0;
parameter RUN = 3'd1;
parameter RUN_100 = 3'd2;
parameter RUN_200 = 3'd3;
parameter RUN_300 = 3'd4;
parameter RUN_400 = 3'd5;
parameter RUN_500 = 3'd6;
parameter RUN_600 = 3'd7;

//OPcodes
parameter NOP =  5'd0;
parameter RDAX =  5'd1;
parameter RDA =  5'd2;
parameter RDFX = 5'd3;
parameter WRAX = 5'd4;
parameter WRA = 5'd5;
parameter WRAP = 5'd6;
parameter WRHX = 5'd7;
parameter WRLX = 5'd8;
parameter MULX = 5'd9;
parameter WLDS = 5'd10;
parameter CHO_RDA = 5'd11;
parameter RMPA = 5'd12;
parameter SOF = 5'd13;
parameter SPIN_AND = 5'd14;
parameter SPIN_OR = 5'd15;
parameter SPIN_XOR = 5'd16;
parameter MAXX = 5'd17;
parameter SKP = 5'd18;

///output PCM
reg [31:0] out_l, out_r, n_out_l, n_out_r;
assign yl = out_l;
assign yr = out_r;

parameter N_REGS = 32;  //number of regs, internal = 17, user 15, total 32

reg signed [31:0] acc, n_acc;
reg signed [31:0] pacc, n_pacc;
reg signed [31:0] lr, n_lr;
reg signed [31:0] AX, n_AX;
reg signed [31:0] BX, n_BX;
wire signed [15:0] BXs = BX[31:16];
wire signed [47:0] mul_big = AX * BXs;
wire signed [31:0] mult_ax_bx = mul_big[45:14];

/// condition flags , for SKP instruction///
reg first_run, n_first_run;
wire is_zero_crossing = (acc[31] == pacc[31]) ? 1'b0 : 1'b1;
wire is_zero_acc = (acc == 32'd0) ? 1'b1 : 1'b0;
wire is_acc_greq_0 = (acc >= 32'd0) ? 1'b1 : 1'b0;
wire is_acc_neg = acc[31] ? 1'b1 : 1'b0;


//internal registers
reg signed [31:0] myregs[0:N_REGS-1];
reg signed [31:0] n_myregs[0:N_REGS-1];
integer n;

assign kfreq1 = myregs[0][31:23];
assign amp1 = myregs[1][31:17];
assign kfreq2 = myregs[2][31:23];
assign amp2 = myregs[3][31:17];

//internal LFO buffer
reg signed [31:0] sin1, n_sin1, cos1, n_cos1, sin2, n_sin2, cos2, n_cos2;

//internal registers
parameter  POT0 = 8;
parameter  POT1 = 9;
parameter  POT2 = 10;
parameter  POT3 = 11;
parameter  ADCL = 12;
parameter  ADCR = 13;
parameter  DACL = 14;
parameter  DACR = 15;
parameter  ADDR_PTR = 16;
// the rest are general purpose registers (17-31)


///////////////////////////////DSP////////////////////////////////
reg [7:0] i, n_i;
parameter LAST_CYCLE = 255;       //for MCLK = 256xsample rate

reg [6:0] PC, n_PC;   //program pointer, from 0 to 127, +1 after every instruction except SKP
assign code_addr = PC;
wire is_last_code = (PC == 7'd127) ? 1'b1 : 1'b0; 


////////////////// opcode parser ////////////////////////////////////////////
wire [4:0] opcode = code[4:0];
wire [5:0] reg_addr = (code[10:5] >= N_REGS-1) ? N_REGS -1 : code[10:5];
wire signed [31:0] reg_from_code = myregs[reg_addr];
wire signed [31:0] reg_from_code_s14 = {reg_from_code[31], reg_from_code[27:0], reg_from_code[31], reg_from_code[31], reg_from_code[31]};
wire signed [15:0] coeff = code[31:16];
wire signed [31:0] coeff_from_code = {coeff,16'd0};
wire signed [31:0] coeff_from_code_11 = {code[31:21], 21'd0};

//for SKP CCCCCNNNNNN000000000000000010001
wire [4:0] cmask = code[31:27];
wire [5:0] skip =  code[26:21];
wire [4:0] skp_condition = cmask & {first_run, is_zero_crossing, is_zero_acc, is_acc_greq_0, is_acc_neg};
wire skp_ok = (skp_condition == 5'd0)? 1'b0 : 1'b1;

//for wlds
wire [14:0] amp_from_code = code[19:5];
wire [9:0] freq_from_code = code[28:20];
wire SLFO_N = code[29];

//for sof CCCCCCCCCCCCCCCCDDDDDDDDDDD01101
//wire signed [31:0] sof_d = {code[15], code[15], code[15], code[15:5], 18'd0};
wire signed [31:0] sof_d = {code[15], code[15], code[15], code[15], code[15:5], 17'd0};

//// for AND, OR, XOR ////
wire [23:0] bitmask = code [31:8];


///////////// delay ram operation //////////////////////////////////////////
//// there are 3 types of commands that can access delay ram             ///
//// 1) RDA, WRA, WRAP: the address is mem_addr (code[20:5])             ///
//// 2) RMPA, the address is addr_ptr                                    ///
//// 3) CHO RDA: mem_addr + cho_off                                      ///   
//// delay ram addr calc ///////////////////////////////////////////////////
parameter MAX_MEM = 16'd31700;
parameter N_MAX_MEM_PLUS_1 = 16'd0 - MAX_MEM + 16'd1;

wire signed [15:0] max_mem = MAX_MEM;
wire signed [15:0] n_max_mem_plus_1 = N_MAX_MEM_PLUS_1;

wire signed [15:0] mem_addr = precode[20:5];
wire signed [31:0] mem_from_code = ram_din;

///delay line memory
reg signed [15:0] down_counter, n_down_counter;    //-1 @every sample rate
assign ram_wdata = acc;


wire is_read_op = (precode[4:0] == RDA) ? 1'b1:
                  (precode[4:0] == RMPA) ? 1'b1 :
                  (precode[4:0] == CHO_RDA) ? 1'b1 : 1'b0;
////for rmpa
wire is_rmpa = (precode[4:0] == RMPA) ? 1'b1 : 1'b0;
wire signed [15:0] addr_ptr =  myregs[ADDR_PTR][31:16];   //MSB of reg ==> addr


//for cho rda 00CCCCCC0NNAAAAAAAAAAAAAAAA10100
parameter CHO_COS = 6'd1;
parameter CHO_REG = 6'd2;   //since we buffer everything, this flag is useless
parameter CHO_COMPC = 6'd4;
parameter CHO_COMPA = 6'd8;
parameter CHO_RPTR2 = 6'd16;
parameter CHO_NA = 6'd32;

wire is_cho = (precode[4:0] == CHO_RDA) ? 1'b1 : 1'b0;
wire [5:0] cho_flags = precode[29:24];
wire [1:0] cho_lfo = precode[22:21];
wire signed [31:0] lfo1 = cho_flags[0] ? cos1 : sin1;
wire signed [31:0] lfo2 = cho_flags[0] ? cos2 : sin2;
wire signed [31:0] lfo = (cho_lfo == 2'd0)? lfo1 : (cho_lfo == 2'd1) ? lfo2 : 32'd0;
wire signed [31:0] lfo_compa = cho_flags[3] ? 32'd0 - lfo : lfo;
wire signed [31:0] lfo_addr = {lfo_compa[31:16], 15'd0};
wire signed [31:0] lfo_res = lfo_compa[31] ? {16'hffff, lfo_compa[15:0]} : {16'd0,  lfo_compa[15:0]};
wire signed [31:0] lfo_coeff = lfo_compa[31] ? 32'd65536 + lfo_res : lfo_res;
wire signed [15:0] cho_addr = lfo_addr[31:16];
wire signed [31:0] cho_coeff0 =  {1'b0, lfo_coeff[15:1],16'd0};
wire signed [31:0] cho_coeff = cho_flags[3] ? 32'h7fffffff - cho_coeff0 : cho_coeff0;

//read addr
wire signed [15:0] addr1 = is_cho ? cho_addr + mem_addr : is_rmpa ? addr_ptr : mem_addr;
wire signed [15:0] addr2 = addr1 + down_counter;
wire signed [15:0] addr3 = (addr2 > max_mem) ? addr2 - max_mem :
                           (addr2 < 0) ?  addr2 + max_mem : addr2;

wire [15:0] read_addr = addr3;


wire is_write_op = (precode[4:0] == WRA) ? 1'b1 :
                   (precode[4:0] == WRAP) ? 1'b1 : 1'b0;
wire signed [15:0] waddr1 = precode[20:5];
wire signed [15:0] waddr2 = waddr1 + down_counter;
wire signed [15:0] waddr3 = (waddr2 > max_mem) ? waddr2 - max_mem :
                   (waddr2 < 0) ?  waddr2 + max_mem : waddr2;
wire [15:0] write_addr = waddr3;

reg [15:0] rw_addr, n_rw_addr;
reg [15:0] we, n_we;

assign ram_wen = we;
assign ram_addr = rw_addr;

always @(posedge mclk or negedge reset_n) 
    if (1'b0 == reset_n) begin
        state <= 0;
        AX <= 0; BX <= 0;
        acc <= 0; pacc <= 0; lr <= 0;
        i <= 0;
        PC <= 0; 
        down_counter <= 0;
        out_l <= 0; out_r <= 0;
        for (n=0; n<N_REGS; n = n+1) myregs[n] <= 0;
        sin1 <= 0; cos1 <=0; sin2 <= 0; cos2 <= 0;  //LFO result
        first_run <= 1'b0;
        code <= 0;
        precode <= 0;
        rw_addr <= 0; we <= 0;
        dbg <= 0;
        end
    else begin
        state <= n_state;
        AX <= n_AX; BX <= n_BX;
        acc <= n_acc;  pacc <= n_pacc; lr <= n_lr;
        i <= n_i;
        PC <= n_PC;
        down_counter <= n_down_counter;
        out_l <= n_out_l;
        out_r <= n_out_r;
        for (n=0; n<N_REGS; n = n+1) myregs[n] <= n_myregs[n];
        sin1 <= n_sin1; sin2 <= n_sin2; cos1 <= n_cos1; cos2 <= n_cos2;
        first_run <= n_first_run;
        code <= n_code;
        precode <= n_precode;
        rw_addr <= n_rw_addr;  we <= n_we;
        dbg <= n_dbg;
        end

always @(*) begin
    n_state = state;
    n_AX = AX; n_BX = BX;
    for (n=0; n<N_REGS; n = n+1) n_myregs[n] = myregs[n];
    n_sin1 = sin1; n_sin2 = sin2; n_cos1 = cos1; n_cos2 = cos2;
    n_acc = acc; n_pacc = pacc; n_lr = lr;
    n_i = i; 
    n_PC = PC;
    n_down_counter = down_counter;
    n_out_l = out_l;
    n_out_r = out_r;
    n_first_run = first_run;
    n_code = code;
    n_precode = precode;
    n_rw_addr = rw_addr; n_we = we;
    n_dbg = dbg;
    case(state)

IDLE: begin
    n_first_run = 1'b1;
    n_i = 0;
    n_PC = 0;
    n_out_l = 0;
    n_out_r = 0;
    n_rw_addr = 0;
    n_we = 0;
    if (start) n_state = RUN;
    n_code = 0;
    n_precode = 0;
    end


RUN: begin
    #1 //$display("==========RUN================");
    //$display("PC=%d CODE=%X opcode=%X", PC, code, opcode);
    n_i = i + 8'd1;
    n_PC = PC + 7'd1;


    //mem control
    n_we = 1'b0;  //read only
    if (is_read_op) begin   //read instruction next
        n_rw_addr = read_addr;
        //#10 $display ("READ %X %d", read_addr, read_addr);
        //#10 $display ("code %X precode %X", code, precode);
        end

//   if (i == LAST_CYCLE) $display("DACR=%X %f", myregs[DACR], myregs[DACR]/134217728.0);


//    if (i <256) begin
//        $display("CODE=%X ADDR=%X PC=%X i=%d is_last_code=%d", opcode, code_addr, PC, i, is_last_code);
//        end
    
    if (i == LAST_CYCLE) n_first_run = 1'b0;
    if (i == LAST_CYCLE) n_myregs[ADCL] = xl;
    if (i == LAST_CYCLE) n_myregs[ADCR] = xr;
    if (i == LAST_CYCLE) n_out_l = myregs[DACL];
    if (i == LAST_CYCLE) n_out_r = myregs[DACR];
    if (i == LAST_CYCLE) n_sin1 = sin1x;
    if (i == LAST_CYCLE) n_sin2 = sin2x;
    if (i == LAST_CYCLE) n_cos1 = cos1x;
    if (i == LAST_CYCLE) n_cos2 = cos2x;
    if (i == LAST_CYCLE) n_myregs[POT0] = {pot0, 16'd0};
    if (i == LAST_CYCLE) n_myregs[POT1] = {pot1, 16'd0};
    if (i == LAST_CYCLE) n_myregs[POT2] = {pot2, 16'd0};
    if (i == LAST_CYCLE) n_myregs[POT3] = {pot3, 16'd0};
    
    if (i == LAST_CYCLE) begin
        if (down_counter == n_max_mem_plus_1) 
            n_down_counter = 0;
        else
            n_down_counter =  down_counter - 1;
        end

    if (is_last_code) begin   //have to wait until the next
       if (i == LAST_CYCLE)
           n_PC = 0;  //start from the 1st instruction, redo loop    
       else 
           n_PC = PC;
       n_state = RUN;
       end
    else begin // process the instructions
       /// execute the code, based on PC , current_code = codes[PC]
       n_pacc = acc;
       case(opcode) 
       RDAX: begin
           n_AX = reg_from_code;
           n_lr = reg_from_code;
           n_BX = coeff_from_code;
           n_state = RUN_100; 
           end
       RDA: begin
           //#10 $display ("RDA %X", mem_from_code);
           n_AX = mem_from_code;
           n_lr = mem_from_code;
           n_BX = coeff_from_code_11;
           n_state = RUN_100;
           end
       RMPA: begin
           n_AX = mem_from_code;    //pick mem from addr_ptr
           n_lr = mem_from_code;
           n_BX = coeff_from_code_11;
           n_state = RUN_100; 
           end
       RDFX: begin  //acc = (acc - reg) * scale + reg;
           n_AX = acc - reg_from_code;
           n_lr = reg_from_code;
           n_BX = coeff_from_code;
           n_acc = reg_from_code;
           n_state = RUN_100;
           end

       WRAP: begin //write all pass filter
           n_AX = acc;
           n_BX = coeff_from_code_11;
           n_acc = lr;
           n_state = RUN_100;
           end

       WRA: begin //write mem
           n_AX = acc;
           n_BX = coeff_from_code_11;
           n_acc = 0;
           n_state = RUN_100;
           end

       WRAX: begin
           //#10 $display("WRAX %d %x", reg_addr, acc);
           n_myregs[reg_addr] = acc;
           n_AX = acc;
           n_BX = coeff_from_code;
           n_acc = 0;
           n_state = RUN_100;
           end

       WRHX: begin  //WriteRegisterHighshelf
           n_myregs[reg_addr] = acc;
           n_AX = acc;
           n_BX = coeff_from_code;
           n_acc = pacc;
           n_state = RUN_100;
           end

       WRLX: begin //WriteRegisterLowshelf
           n_myregs[reg_addr] = acc;
           n_AX = pacc - acc;
           n_BX = coeff_from_code;
           n_acc = pacc;
           n_state = RUN_100;
           end

       MULX: begin  // NOTE, AX format is s.4.27, BX format should be s.1.xxx 
                    // need conversion here!
           n_BX = reg_from_code_s14;
           n_lr = reg_from_code;
           n_AX = acc;
           n_acc = 0;
           n_state = RUN_100; 
           end

       WLDS: begin  //load frequency and amplitude
           if (SLFO_N) n_myregs[2][31:23] = freq_from_code; else  n_myregs[0][31:23] = freq_from_code;
           if (SLFO_N) n_myregs[3][31:17] = amp_from_code; else  n_myregs[1][31:17] = amp_from_code;
           n_state = RUN_300;
           end

       CHO_RDA: begin
           n_AX = mem_from_code;
           n_lr = mem_from_code;
           n_BX = cho_coeff;
           n_state = RUN_100;
           end

       SOF: begin //C * ACC + D
           n_AX = acc;
           n_BX = coeff_from_code;
           n_lr = acc;
           n_acc = sof_d;
           n_state = RUN_100; 
           end

       SKP: begin
           n_dbg = {skip, 1'b0, skp_ok};
           if (skp_ok) begin
               n_PC = PC + {1'b0, skip} + 7'd127;   //+ skip -1;
               n_state = RUN_400;
               end
           else 
               n_state = RUN_300;
           end

       SPIN_AND: begin
           n_acc = acc & {bitmask, 8'd0};
           n_state = RUN_300;
           end

       SPIN_OR: begin
           n_acc = acc | {bitmask, 8'hff};
           n_state = RUN_300;
           end

       SPIN_XOR: begin
           n_acc = acc ^ {bitmask, 8'hff};
           n_state = RUN_300;
           end

       MAXX: begin
           n_AX = reg_from_code;
           n_lr = reg_from_code;
           n_BX = (reg_from_code[31] == coeff_from_code[31]) ? coeff_from_code : 32'd0 - coeff_from_code;
           n_acc = acc[31]? 32'd0 - acc : acc;
           n_state = RUN_200; 
           end

       default: begin
           n_state = RUN_300;
           end

       endcase
       end
    end

RUN_100: begin //for all ACC mult_add instructions except MAXX
    #1 //$display("==========RUN100===============");
    n_i = i + 8'd1;
    n_acc = acc + mult_ax_bx;
    n_state = RUN;
    n_precode = codeword;
    n_code = precode;

    //mem control
    if (is_write_op) begin   //read instruction next
        //#1 $display ("WRITE %X %d %X", write_addr, write_addr, myregs[ADCR]);
        //#1 $display ("WRITE %d %d %d %X", waddr2, waddr3, down_counter, myregs[ADCR]);
        n_rw_addr = write_addr;
        n_we = 1'b1;
        end
    end 

RUN_200: begin   //MAXX
    n_i = i + 8'd1;
    n_acc = (acc >  mult_ax_bx)  ? acc : mult_ax_bx;
    n_state = RUN;
    n_precode = codeword;
    n_code = precode;

    //mem control
    if (is_write_op) begin   //read instruction next
        n_rw_addr = write_addr;
        n_we = 1'b1;
        end
    end

RUN_300, RUN_500, RUN_600: begin 
    #1 //$display("==========RUN300===============");
    n_i = i + 8'd1;
    n_state = RUN;
    n_precode = codeword;
    n_code = precode;

    //mem control
    if (is_write_op) begin   //read instruction next
        n_rw_addr = write_addr;
        n_we = 1'b1;
        end
    end

RUN_400: begin  // for SKP command only, in SKP, PC = PC + skip, now PC = new one already
                // next cycle codeword will have new code, precode will get this, code should be cleared
    n_i = i + 8'd1;
    n_state = RUN;
    n_precode = 0;
    n_code = 0;
    end

    endcase
    end

endmodule


