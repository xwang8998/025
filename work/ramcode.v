
// code ram is a 128x32bit ram that allows < 128 instructions
// 

module ramcode(
input mclk,
input we,
input [6:0] addr,
input [31:0] wdata,
output [31:0] rdata
);

reg [31:0] q;
assign rdata = q;  

reg [31:0] mem [127:0] ;

always @(posedge mclk) begin
    if(we) begin
        //#1 $display("W: %d %X", addr, wdata);
        mem[addr] <= wdata;
        end
    else 
        q <= mem[addr];
    end


endmodule



