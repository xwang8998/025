
//// how to configure fv1 core system? with i2c or spi or what ever
// we need to do the following things
// 1) load program to program ram, which is 128x32 bit space
// 2) load parameters for fv1
// 3) load other stuff for other functions
// first, let's leave 3) alone
// for 1) and 2), assume we need 
// parameters for pot0, pot1, pot2 and pot3
// each is 15bits long, so 
// 8 bytes needed
// we set i2c register 0 as command register, @address 0
// then we have 4 bytes reg1, reg2, reg3, reg4 to use as data
// cmd = reg0
// cmd enums:

module config_dsp(
input mclk,
input reset_n,
input [7:0] cmd,

input [7:0] reg1,
input [7:0] reg2,
input [7:0] reg3,
input [7:0] reg4,

//fv1 start/stop ctrl
output start_dsp,

// ramcode interface
output we,
output [31:0] wdata,
output [6:0]addr);

reg [1:0] state, n_state;

parameter IDLE = 2'b00;
parameter WAIT_CLEAR = 2'b01;
parameter ZERO_BUF = 2'b10;
parameter ZERO_BUF_END = 2'b11;

parameter CMD_NOP = 8'd0;  //do nothing
parameter CMD_INIT_PRG = 8'd1;  //init program addr to 0
parameter CMD_PUSH_CODE = 8'd2; // push a 32bit code to program memory (reg1, reg2, reg3, reg4)
parameter CMD_START_DSP = 8'd3;
parameter CMD_STOP_DSP = 8'd4;

reg start, n_start;
assign start_dsp = start;

reg wen, n_wen;
assign we = wen;
assign wdata = {reg1, reg2, reg3, reg4};
reg [6:0] paddr, n_paddr;
assign addr = paddr;

always @(posedge mclk or negedge reset_n) 
    if (reset_n == 1'b0) begin
        wen <= 1'b0;
        paddr <= 7'd0;
        state <= 0;
        start <= 0;
        end
    else begin
        wen <= n_wen;
        paddr <= n_paddr;
        state <= n_state;
        start <= n_start;
        end

always @* begin
    n_wen = wen;
    n_paddr = paddr;
    n_state = state;
    n_start = start;

    case(state)
IDLE: begin
    n_wen = 1'b0;
    if (cmd == CMD_INIT_PRG) begin
        //#1 $display("INIT" );
        n_paddr = 7'd0;
        n_wen = 1'b1;
        n_state = ZERO_BUF;
        end
    else if (cmd == CMD_PUSH_CODE) begin
        //#1 $display("PUSH %d %x", paddr, wdata);
        n_wen = 1'b1;
        n_state = WAIT_CLEAR;
        end
    else if (cmd == CMD_START_DSP) begin
        n_start = 1'b1;
        end
    else if (cmd == CMD_STOP_DSP) begin
        n_start = 1'b0;
        end
    end

WAIT_CLEAR: begin
    n_wen = 1'b0;
    if (cmd == CMD_NOP) begin
        n_state = IDLE;
        n_paddr = paddr + 7'd1;
        end
    end

ZERO_BUF: begin
    //#1 $display("zero: %d", paddr);
    n_wen = 1'b1;
    n_paddr = paddr + 7'd1;
    if (paddr == 7'd127) n_state = ZERO_BUF_END;
    end

ZERO_BUF_END: begin
    n_wen = 1'b0;
    n_paddr = 7'd0;
    n_state = WAIT_CLEAR;
    end

    endcase
    end

endmodule




