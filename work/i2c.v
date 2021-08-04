

// i2c configuration module
// the job is to configure reverb parameters 
// program and ctrl dsp cores
// and setup other stuff
// ===================================================================
// 1) program/ctrl dsp core: 5 bytes, cmd, reg1-4
// 2) reverb param: 16bit x 4 ==> 8 bytes
// 3) other stuff, 16bytes + 3bytes make it total 32 bytes, 256bits



module i2c(
input mclk,      //high freq sample clock, 1MHz to 2MHz and above
input reset_n,

//output regs
output [255:0] i2c_mem,   //256bits

input scl,
input sda,
output reg sda_out,
output reg sda_out_en
);

parameter I2C_SLAVE_ADDR = 7'd8;

///////signal conditioning, the clean signal would be sdain and sclin
reg scl1, sda1, scl_in, sda_in;
always @(posedge mclk or negedge reset_n)
    if (reset_n == 1'b0) begin
        scl1 <= 0; sda1 <= 0; scl_in <= 0; sda_in <= 0;
        end
    else begin
        scl1 <= scl;  scl_in <= scl1;
        sda1 <= sda;  sda_in <= sda1;
    end

/// start/stop check, edge detection
reg scl_old, sda_old;
always @(posedge mclk or negedge reset_n)
    if (reset_n == 0) begin
        scl_old <= 0; sda_old <= 0;
        end
    else begin
        scl_old <= scl_in; sda_old <= sda_in;
    end

// conditions
reg i2c_start, i2c_stop, scl_rise, scl_fall;
reg slave_addr_match;
reg i2c_set, i2c_get;
always @* begin
    if (scl_old==1 && scl_in ==1 && sda_old ==1 && sda_in == 0) i2c_start = 1; else i2c_start = 0;
    if (scl_old==1 && scl_in ==1 && sda_old ==0 && sda_in == 1) i2c_stop = 1; else i2c_stop = 0;
    if (scl_old == 0 && scl_in == 1) scl_rise = 1; else scl_rise = 0;
    if (scl_old == 1 && scl_in == 0) scl_fall = 1; else scl_fall = 0;
    end

reg state, n_state;
reg [4:0] i, n_i;
reg n_sda_out, n_sda_out_en;
reg [7:0] slave_addr, n_slave_addr, addr, n_addr, data, n_data;
reg [7:0] bigr[0:31], n_bigr[0:31];

genvar m;
generate 
   for(m=0;m<32;m=m+1) begin: id1
       assign i2c_mem[m*8 + 7: m*8] = bigr[m];
   end
endgenerate

//address translation
wire [7:0] read_data = bigr[addr[4:0]];

integer n;

always @* begin
    if (slave_addr[7:1] == I2C_SLAVE_ADDR) slave_addr_match = 1; else slave_addr_match = 0;
    if (slave_addr_match && slave_addr[0] == 1) i2c_get = 1; else i2c_get = 0;
    if (slave_addr_match && slave_addr[0] == 0) i2c_set = 1; else i2c_set = 0;
    end

always @(posedge mclk or negedge reset_n)
    if (reset_n == 1'b0) begin
            state <= 0;
            i <= 0;
            sda_out <= 0; sda_out_en <= 0;
            slave_addr <= 0; addr <= 0; data <= 0;
            for (n=0; n<32; n = n+1) bigr[n] <= 0;
            end
    else begin
            state <=  n_state;
            i <= n_i;
            sda_out <= n_sda_out; sda_out_en <= n_sda_out_en;
            slave_addr <= n_slave_addr; addr <= n_addr; data <= n_data;
            for (n=0; n<32; n = n+1) bigr[n] <= n_bigr[n];
            end

parameter I2C_IDLE = 0;
parameter I2C_WORK = 1;
always @(*) begin
    n_state = state; n_i = i; n_sda_out = sda_out;
    n_sda_out_en = sda_out_en;
    n_slave_addr = slave_addr; n_addr = addr; n_data = data;
    for (n=0; n<32; n = n+1) n_bigr[n] = bigr[n];

    case (state)
        I2C_IDLE: begin
           n_i = 0;  n_sda_out = 1;
           if (i2c_start == 1) begin
               n_i = 0;
               n_state = I2C_WORK;
               end
           end
        //  SCL 0-7: slave_addr
        //  SCL 8: ACK
        //  SCL 9,10,11,12,13,14,15,16: I2C addr
        //  SCL 17: ACK
        //  SCL 18,19,20,21,22,23,24,25: I2C data
        //  SCL 26: ACK    end session:
        I2C_WORK: begin
           if (i2c_stop == 1) begin
              n_state = I2C_IDLE;
              n_slave_addr = 0;
              n_i = 0;
              n_sda_out = 1;          // release bus
              n_sda_out_en = 0;       // disable output
              end

           else if (i2c_start == 1) begin // re_start?
              n_i = 0;
              n_sda_out = 1;          // release bus
              n_sda_out_en = 0;       // disable output
              n_slave_addr = 0;
              n_state = I2C_WORK;
              end

           else if (scl_rise == 1) begin  // rising edge
              n_state = I2C_WORK;
              if (i<30) n_i = i + 5'd1;
              if (i<8) n_slave_addr = {slave_addr[6:0], sda_in};

              if (i>8) begin
                 if (i2c_get) begin
                     // do something else , do not write anything
                     end
                 else begin  //write operation
                     if (i>8 && i<17) n_addr = {addr[6:0], sda_in};
                     if (i>17 && i<26) n_data = {data[6:0], sda_in};
                     end
                 end
              end
           else if (scl_fall == 1) begin   // falling edge
              n_sda_out = 1;               // default mode: release bus to master
              n_sda_out_en = 0;


              if (i==8 && slave_addr_match)  begin n_sda_out_en = 1; n_sda_out = 0; end   // 1st ACK, slave address match
              if (i==17 && slave_addr_match && i2c_set) begin n_sda_out_en = 1; n_sda_out = 0; end  // 2nd ACK, I2C addr received
              if (i==26 && slave_addr_match && i2c_set) begin n_sda_out_en = 1; n_sda_out = 0; end  // 3rd ACK, I2C data R/W complete

// i2c protocal, start reading after ack
              if (i==9 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[7]; end    //map addr/register
              if (i==10 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[6]; end
              if (i==11 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[5]; end
              if (i==12 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[4]; end
              if (i==13 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[3]; end
              if (i==14 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[2]; end
              if (i==15 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[1]; end
              if (i==16 && i2c_get) begin n_sda_out_en = 1; n_sda_out = read_data[0]; end
              if (i==17 && slave_addr_match && i2c_get) 
                   begin 
                   n_sda_out_en = 0; 
                   n_sda_out = 1; 
                   //go back to beginning
                   n_i = 0;
                   n_slave_addr = 0;
                   n_state = I2C_IDLE;
                   end  // NACK

              if (i==26 && i2c_set) begin
                   n_bigr[addr[4:0]] = data;
                  end

              if (i==27 && slave_addr_match && i2c_set) 
                  begin   //force end
                  n_sda_out_en = 0; 
                  n_sda_out = 1;
                  n_i = 0;
                  n_slave_addr = 0;
                  n_state = I2C_IDLE;
                  end  

              end
           end
    endcase
    end
endmodule


