
//
// most FPGA, actel , xilinx, lattice support 1Kx18 blocks
// we use single port 1Kx18 block for our DSD cores
// 
module ram1Kx18(
input mclk,
input wen,
input [9:0] addr,
input [17:0] wdata,
output [17:0] rdata);

reg [9:0] addr_reg;
reg [17:0] mem [0:1023];

assign rdata = mem[addr_reg];      //already pipelined here

always@(posedge mclk)
    begin
    addr_reg <= addr;
    if(wen) mem[addr] <= wdata;
    end

endmodule

