


module fir_stage_1(
input pclk,      //45.1584MHz clock
input preset_n,
input start,
input [1:0]oversampling_x,    //oversampling ratio, 0-->1x 1-->2x, 2-->4x, 3-->8x
input signed [31:0]x_0,             //input sample
input signed [31:0]x_1,             //input sample
output started,
output reg signed [31:0] fir_out_0,
output reg signed [31:0] fir_out_1
);

parameter FIR1_000 = 1'b0,
          FIR1_100 = 1'b1;

reg reset_n;
always @* if (start == 0) reset_n = 0; else reset_n = preset_n;

reg state, n_state;
reg [6:0] j, n_j;
reg [2:0] k, n_k;
reg work, n_work;
assign started = work;

wire [9:0] tap_addr;
wire [6:0] jj = 7'd127 - j;

assign tap_addr = (oversampling_x == 3) ? {jj[6:0],k[2:0]} :
                  (oversampling_x == 2) ? {1'b0, jj[6:0],k[1:0]} :
                  (oversampling_x == 1) ? {2'b00, jj[6:0],k[0]} : 
                                          {3'b000, j[6:0]};
wire [2:0] last_k;
assign last_k = (oversampling_x == 3) ? 3'd7 :
                (oversampling_x == 2) ? 3'd3 :
                (oversampling_x == 1) ? 3'd1 : 3'd0;

reg signed [31:0] n_fir_out_0;
reg signed [31:0] n_fir_out_1;
reg signed [59:0] sum_0, n_sum_0;
reg signed [59:0] sum_1, n_sum_1;

wire signed [59:0] mul_fir0_tap;
wire signed [59:0] mul_fir1_tap;

wire signed [31:0] TAP_AT_tap_pos;
tap_rom U1 (
  .oversampling_x(oversampling_x),
  .output_tap(TAP_AT_tap_pos),
  .address(tap_addr));


//////2p ram//////////////////////
reg wen, n_wen;
reg [6:0] waddr, n_waddr, raddr, n_raddr, ram_addr, n_ram_addr;
wire [31:0] dout_0, dout_1;
fir_ram UR0(.clk(pclk), .reset_n(preset_n), .we(wen), .waddr(waddr), .di(x_0), .raddr(raddr), .dout(dout_0));
fir_ram UR1(.clk(pclk), .reset_n(preset_n), .we(wen), .waddr(waddr), .di(x_1), .raddr(raddr), .dout(dout_1));
mult28x32 UM1 (.pclk(pclk), .reset_n(preset_n), .a(dout_0[31:4]), .b(TAP_AT_tap_pos), .y(mul_fir0_tap));
mult28x32 UM2 (.pclk(pclk), .reset_n(preset_n), .a(dout_1[31:4]), .b(TAP_AT_tap_pos), .y(mul_fir1_tap));
//////2p ram//////////////////////

always @(posedge pclk or negedge reset_n)
    if (reset_n == 0) begin
        j <= 0;
        k <= 0;
        sum_0 <= 0;
        fir_out_0 <= 0;
        sum_1 <= 0;
        fir_out_1 <= 0;
        state <= 0;
        work <= 0;
        
        wen <= 0; 
        waddr <= 0;
        raddr <= 0;
        ram_addr <= 0;

        end
    else begin
        j <= n_j;
        k <= n_k;
        sum_0 <= n_sum_0;
        fir_out_0 <= n_fir_out_0;
        sum_1 <= n_sum_1;
        fir_out_1 <= n_fir_out_1;
        state <= n_state;
        work <= n_work;

        wen <= n_wen;
        waddr <= n_waddr;
        raddr <= n_raddr;
        ram_addr <=n_ram_addr;

        end

//FSM body
always @* begin
    n_j = j;
    n_k = k;
    n_sum_0 = sum_0;
    n_fir_out_0 = fir_out_0;
    n_sum_1 = sum_1;
    n_fir_out_1 = fir_out_1;
    n_state = state;
    n_work = work;

    n_wen = wen;
    n_waddr = waddr;
    n_raddr = raddr;
    n_ram_addr = ram_addr;


    case(state)

FIR1_000: begin
    n_work = 0;
    n_sum_0 = 0;
    n_sum_1 = 0;
    n_k = 0;
    n_j = 0;
    if (start == 0) n_state = FIR1_000;
    else begin
         n_state = FIR1_100;
         end
    end

//// Big loop for polyphase interpolation FIR  /////
//// first, we start with
//// fir[0] * C0 + fir [1] * c8 + fir[2] * c16 ... ==> out0
//// then 
//// fir[0] * C1 + fir [1] * c9 + fir[2] * c17 ... ==> out1
//// ...
//// until 
//// fir[0] * C7 + fir [1] * c15 + fir[2] * c23 ... ==> out7
//// then
//// read new input x, shift fir[], redo the loop
// BIG LOOP, for example, 8x oversampling will loop 8 times
// 4x oversampling will loop 4 times
// BIG Loop's counter is k;
// each polyphase sub tap's length should < 126 because
// output rate is 352800 and our clock is 45.1584MHz, which is 
// 128x of 352800, need to finish calculating polyphase in 128 cycles
// polyphase loop counter is j

FIR1_100: begin     // inner loop, calculate filter result: sum
                    // go through poly phase sub filter (max 126!)
                    // for 8x filter, it will go through 8x128 ops
                    // at the end of 8x128 ops, read a new x in, shift fir[]
                    // at the end of each 128 ops, output a y
                    // 
                    // for 4x filter, it will go through 4x128 ops
                    // at the end of 4x128 ops, read a new x in, shift fir[]
                    // at the end of each 128 ops, output a y
#1       n_state = FIR1_100; //default is inner loop

#1       if (j==127) begin   //end of inner loop (polyphase) 
             #1 if (k==last_k) begin  //end of big loop!
             n_waddr = ram_addr;
             n_wen = 1'b1;
             n_ram_addr = ram_addr + 7'd1;
             n_raddr = ram_addr + 7'd1;
             n_k = 0;
             end
          else begin
             n_k = k+1;
             n_wen = 1'b0;
             n_raddr = ram_addr;
             end

          n_j = 0;
          n_sum_0 = 0;
          n_sum_1 = 0;
          n_state = FIR1_100;
          #10 if (work) $display("@@@@=%d", fir_out_1);   //must delay to allow logic settle
          end

       else begin
           #1 n_sum_0 = sum_0 + mul_fir0_tap;
           #1 n_sum_1 = sum_1 + mul_fir1_tap;
           #1 n_j = j+1;
           n_raddr = raddr + 7'd1;
           end

       //output result
       if (j==127) begin
            #1 n_fir_out_0 = sum_0[58:27];
            #1 n_fir_out_1 = sum_1[58:27];
            n_work = 1;
            end

       end
   endcase
   end
endmodule




// dual port syn rom, wclk === rclk === clk
module fir_ram(
input clk,
input reset_n,
input we,
input [6:0] waddr,
input [31:0] di,

input [6:0] raddr,
output [31:0] dout
);

reg [31:0] mem [0:127];
reg [31:0] rdata;
assign dout = rdata;
integer n;
always @ (posedge clk or negedge reset_n) 
   if (1'b0 == reset_n) begin
       for (n = 0; n < 128; n = n +1)   mem[n] <= 0;
       rdata <= 0;
       end
   else begin
       if (we) mem[waddr] <= di;
       rdata <= mem[raddr];
       end

endmodule
