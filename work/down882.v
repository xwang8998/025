// down conversion
// from 176.4K to 88.2K 32bit
// 3.3K DFF 2.6K LUT

module down_882(
input bck176,         //176.4 bit clock
input reset_n,
input signed [31:0] x0,  
input signed [31:0] x1, 

output [31:0] pcm_left,
output [31:0] pcm_right);

reg [6:0] i;
wire [6:0] addr = i[6:0];
wire [6:0] limit = 7'd127;

parameter NTAP = 47;
reg [55:0] queue_l, queue_r;

reg signed [31:0] final_l, final_r;
reg signed [59:0] sum_l, sum_r;
assign pcm_left = final_l;
assign pcm_right = final_r;

reg signed [27:0] fir_0 [0:NTAP-1];
reg signed [27:0] fir_1 [0:NTAP-1];

wire signed [31:0] tap;
down_rom UDOWN_ROM(.addr(addr), .use_882(1'b1), .tap(tap));

wire signed [27:0] fir_l = (addr < NTAP) ? fir_0[addr] : 28'd0;
wire signed [27:0] fir_r = (addr < NTAP) ? fir_1[addr] : 28'd0;
wire signed [59:0] mul_fir0_tapi =  fir_l * tap;
wire signed [59:0] mul_fir1_tapi =  fir_r * tap;

integer n;
always @(posedge bck176 or negedge reset_n)
    if (1'b0 == reset_n) begin
        for (n = 0; n < NTAP; n = n + 1)  #1 fir_0[n] <= 28'd0;
        for (n = 0; n < NTAP; n = n + 1)  #1 fir_1[n] <= 28'd0;
        queue_l <= 56'd0;
        queue_r <= 56'd0;
        i <= 7'd0;
        sum_l <= 60'd0;
        sum_r <= 60'd0;
        final_l <= 32'd0;
        final_r <= 32'd0;
        end

    else begin
        i <= i + 7'd1;

        if (i[5:0] ==6'd2) queue_l <= {x0[31:4], queue_l[55:28]}; 
        if (i[5:0] ==6'd2) queue_r <= {x1[31:4], queue_r[55:28]}; 

        //if (i == 6'd1) $display("@@@@=%d", final_r );   //must delay to allow logic settle
        //if (i[5:0] == 6'd1) $display("@@@@=%d", x1 );   //must delay to allow logic settle

        if (i == limit) begin
            i <= 7'd0;
            final_l <= sum_l[59:28];
            final_r <= sum_r[59:28];
            //$display ("i=%d sum=%d", i,  sum_l);

            for (n = NTAP - 1; n >= 2; n = n - 1)  #1 fir_0[n] <= fir_0[n-2];
            for (n = NTAP - 1; n >= 2; n = n - 1)  #1 fir_1[n] <= fir_1[n-2];

            #1 fir_0[0] <= queue_l[55:28];
            #1 fir_1[0] <= queue_r[55:28];
            #1 fir_0[1] <= queue_l[27:0];
            #1 fir_1[1] <= queue_r[27:0];

            sum_l <= 60'd0;
            sum_r <= 60'd0;
            end

        else begin   //regular loop
            i <= i + 7'd1;

            final_l <= final_l;
            final_r <= final_r;
            for (n = 0; n < NTAP; n = n + 1)  #1 fir_0[n] <= fir_0[n];
            for (n = 0; n < NTAP; n = n + 1)  #1 fir_1[n] <= fir_1[n];

            if (i<NTAP) begin
                sum_l <= sum_l + mul_fir0_tapi;
                sum_r <= sum_r + mul_fir1_tapi;
                end
            else begin
                sum_l <= sum_l;
                sum_r <= sum_r;
                end
            end
        end

endmodule


