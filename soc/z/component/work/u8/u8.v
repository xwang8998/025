//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Aug 26 11:03:53 2020
// Version: v11.8 SP1 11.8.1.12
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// u8
module u8(
    // Inputs
    DEVRST_N,
    clock138_bck,
    clock138_lrck,
    mclk,
    sdclk,
    // Outputs
    clock138_data,
    dac_mclk,
    en45,
    en49,
    is_dsd,
    led0,
    led1,
    led2,
    led3,
    led4,
    led5,
    led6,
    led7,
    sd_det,
    spdif_en,
    spdif_tx,
    wck,
    // Inouts
    cmd,
    obck,
    odata,
    olrck,
    sd_d0,
    sd_d1,
    sd_d2,
    sd_d3
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  DEVRST_N;
input  clock138_bck;
input  clock138_lrck;
input  mclk;
input  sdclk;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output clock138_data;
output dac_mclk;
output en45;
output en49;
output is_dsd;
output led0;
output led1;
output led2;
output led3;
output led4;
output led5;
output led6;
output led7;
output sd_det;
output spdif_en;
output spdif_tx;
output wck;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  cmd;
inout  obck;
inout  odata;
inout  olrck;
inout  sd_d0;
inout  sd_d1;
inout  sd_d2;
inout  sd_d3;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          clock138_bck;
wire          clock138_data_net_0;
wire          clock138_lrck;
wire          cmd;
wire          dac_mclk_net_0;
wire          DEVRST_N;
wire          en45_net_0;
wire          en49_net_0;
wire          FCCC_0_GL0;
wire          is_dsd_net_0;
wire          led0_net_0;
wire          led1_net_0;
wire          led2_net_0;
wire          led3_net_0;
wire          led4_net_0;
wire          led5_net_0;
wire          led6_net_0;
wire          led7_net_0;
wire          mclk;
wire          obck;
wire          odata;
wire          olrck;
wire          sd_d0;
wire          sd_d1;
wire          sd_d2;
wire          sd_d3;
wire          sd_det_net_0;
wire          sdclk;
wire          spdif_en_net_0;
wire          spdif_tx_net_0;
wire          test_0_FPGA_CLK;
wire   [31:0] test_0_HADDR;
wire   [2:0]  test_0_HBURST;
wire          test_0_HMASTLOCK;
wire   [3:0]  test_0_HPROT;
wire   [2:0]  test_0_HSIZE;
wire   [1:0]  test_0_HTRANS;
wire   [31:0] test_0_HWDATA;
wire          test_0_HWRITE;
wire          u8_sb_0_FIC_0_LOCK;
wire   [31:0] u8_sb_0_HPMS_FIC_0_USER_MASTER_HRDATA_M0;
wire          u8_sb_0_HPMS_FIC_0_USER_MASTER_HREADY_M0;
wire   [1:0]  u8_sb_0_HPMS_FIC_0_USER_MASTER_HRESP_M0;
wire          u8_sb_0_HPMS_READY;
wire          wck_net_0;
wire          clock138_data_net_1;
wire          en49_net_1;
wire          en45_net_1;
wire          led0_net_1;
wire          led1_net_1;
wire          led2_net_1;
wire          led3_net_1;
wire          led4_net_1;
wire          led5_net_1;
wire          led6_net_1;
wire          led7_net_1;
wire          spdif_en_net_1;
wire          spdif_tx_net_1;
wire          sd_det_net_1;
wire          dac_mclk_net_1;
wire          wck_net_1;
wire          is_dsd_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [7:2]  PADDR_const_net_0;
wire   [7:0]  PWDATA_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net            = 1'b1;
assign GND_net            = 1'b0;
assign PADDR_const_net_0  = 6'h00;
assign PWDATA_const_net_0 = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign clock138_data_net_1 = clock138_data_net_0;
assign clock138_data       = clock138_data_net_1;
assign en49_net_1          = en49_net_0;
assign en49                = en49_net_1;
assign en45_net_1          = en45_net_0;
assign en45                = en45_net_1;
assign led0_net_1          = led0_net_0;
assign led0                = led0_net_1;
assign led1_net_1          = led1_net_0;
assign led1                = led1_net_1;
assign led2_net_1          = led2_net_0;
assign led2                = led2_net_1;
assign led3_net_1          = led3_net_0;
assign led3                = led3_net_1;
assign led4_net_1          = led4_net_0;
assign led4                = led4_net_1;
assign led5_net_1          = led5_net_0;
assign led5                = led5_net_1;
assign led6_net_1          = led6_net_0;
assign led6                = led6_net_1;
assign led7_net_1          = led7_net_0;
assign led7                = led7_net_1;
assign spdif_en_net_1      = spdif_en_net_0;
assign spdif_en            = spdif_en_net_1;
assign spdif_tx_net_1      = spdif_tx_net_0;
assign spdif_tx            = spdif_tx_net_1;
assign sd_det_net_1        = sd_det_net_0;
assign sd_det              = sd_det_net_1;
assign dac_mclk_net_1      = dac_mclk_net_0;
assign dac_mclk            = dac_mclk_net_1;
assign wck_net_1           = wck_net_0;
assign wck                 = wck_net_1;
assign is_dsd_net_1        = is_dsd_net_0;
assign is_dsd              = is_dsd_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------u8_FCCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.201
u8_FCCC_0_FCCC FCCC_0(
        // Inputs
        .CLK0 ( mclk ),
        // Outputs
        .GL0  ( FCCC_0_GL0 ),
        .LOCK (  ) 
        );

//--------test
test test_0(
        // Inputs
        .reset_n       ( u8_sb_0_HPMS_READY ),
        .HREADY        ( u8_sb_0_HPMS_FIC_0_USER_MASTER_HREADY_M0 ),
        .pll_lock      ( u8_sb_0_FIC_0_LOCK ),
        .sdclk         ( sdclk ),
        .mmclk         ( mclk ),
        .mclk          ( FCCC_0_GL0 ),
        .clock138_bck  ( clock138_bck ),
        .clock138_lrck ( clock138_lrck ),
        .HRDATA        ( u8_sb_0_HPMS_FIC_0_USER_MASTER_HRDATA_M0 ),
        .HRESP         ( u8_sb_0_HPMS_FIC_0_USER_MASTER_HRESP_M0 ),
        // Outputs
        .led0          ( led0_net_0 ),
        .led1          ( led1_net_0 ),
        .led2          ( led2_net_0 ),
        .led3          ( led3_net_0 ),
        .led4          ( led4_net_0 ),
        .led5          ( led5_net_0 ),
        .led6          ( led6_net_0 ),
        .led7          ( led7_net_0 ),
        .FPGA_CLK      ( test_0_FPGA_CLK ),
        .HWRITE        ( test_0_HWRITE ),
        .HMASTLOCK     ( test_0_HMASTLOCK ),
        .sd_det        ( sd_det_net_0 ),
        .omclk         ( dac_mclk_net_0 ),
        .spdif_en      ( spdif_en_net_0 ),
        .spdif_tx      ( spdif_tx_net_0 ),
        .en45          ( en45_net_0 ),
        .en49          ( en49_net_0 ),
        .clock138_data ( clock138_data_net_0 ),
        .wck           ( wck_net_0 ),
        .is_dsd        ( is_dsd_net_0 ),
        .HADDR         ( test_0_HADDR ),
        .HTRANS        ( test_0_HTRANS ),
        .HSIZE         ( test_0_HSIZE ),
        .HBURST        ( test_0_HBURST ),
        .HPROT         ( test_0_HPROT ),
        .HWDATA        ( test_0_HWDATA ),
        // Inouts
        .cmd           ( cmd ),
        .sd_d0         ( sd_d0 ),
        .sd_d1         ( sd_d1 ),
        .sd_d2         ( sd_d2 ),
        .sd_d3         ( sd_d3 ),
        .obck          ( obck ),
        .olrck         ( olrck ),
        .odata         ( odata ) 
        );

//--------u8_sb
u8_sb u8_sb_0(
        // Inputs
        .FAB_RESET_N                         ( VCC_net ),
        .HPMS_FIC_0_USER_MASTER_HWRITE_M0    ( test_0_HWRITE ),
        .HPMS_FIC_0_USER_MASTER_HMASTLOCK_M0 ( test_0_HMASTLOCK ),
        .DEVRST_N                            ( DEVRST_N ),
        .CLK0                                ( test_0_FPGA_CLK ),
        .HPMS_FIC_0_USER_MASTER_HADDR_M0     ( test_0_HADDR ),
        .HPMS_FIC_0_USER_MASTER_HTRANS_M0    ( test_0_HTRANS ),
        .HPMS_FIC_0_USER_MASTER_HSIZE_M0     ( test_0_HSIZE ),
        .HPMS_FIC_0_USER_MASTER_HBURST_M0    ( test_0_HBURST ),
        .HPMS_FIC_0_USER_MASTER_HPROT_M0     ( test_0_HPROT ),
        .HPMS_FIC_0_USER_MASTER_HWDATA_M0    ( test_0_HWDATA ),
        // Outputs
        .POWER_ON_RESET_N                    (  ),
        .INIT_DONE                           (  ),
        .FIC_0_CLK                           (  ),
        .FIC_0_LOCK                          ( u8_sb_0_FIC_0_LOCK ),
        .HPMS_READY                          ( u8_sb_0_HPMS_READY ),
        .HPMS_FIC_0_USER_MASTER_HREADY_M0    ( u8_sb_0_HPMS_FIC_0_USER_MASTER_HREADY_M0 ),
        .COMM_BLK_INT                        (  ),
        .HPMS_FIC_0_USER_MASTER_HRDATA_M0    ( u8_sb_0_HPMS_FIC_0_USER_MASTER_HRDATA_M0 ),
        .HPMS_FIC_0_USER_MASTER_HRESP_M0     ( u8_sb_0_HPMS_FIC_0_USER_MASTER_HRESP_M0 ),
        .HPMS_INT_M2F                        (  ) 
        );


endmodule
