//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Jun 24 19:53:13 2021
// Version: v11.8 SP1 11.8.1.12
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FIFO
module FIFO(
    // Inputs
    CLK,
    DATA,
    RE,
    RESET,
    WE,
    // Outputs
    AEMPTY,
    AFULL,
    EMPTY,
    FULL,
    Q,
    RDCNT,
    WRCNT
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         CLK;
input  [31:0] DATA;
input         RE;
input         RESET;
input         WE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        AEMPTY;
output        AFULL;
output        EMPTY;
output        FULL;
output [31:0] Q;
output [9:0]  RDCNT;
output [9:0]  WRCNT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          AEMPTY_net_0;
wire          AFULL_net_0;
wire          CLK;
wire   [31:0] DATA;
wire          EMPTY_net_0;
wire          FULL_net_0;
wire   [31:0] Q_0;
wire   [9:0]  RDCNT_net_0;
wire          RE;
wire          RESET;
wire          WE;
wire   [9:0]  WRCNT_net_0;
wire          FULL_net_1;
wire          EMPTY_net_1;
wire          AFULL_net_1;
wire          AEMPTY_net_1;
wire   [31:0] Q_0_net_0;
wire   [9:0]  RDCNT_net_1;
wire   [9:0]  WRCNT_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [31:0] MEMRD_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net           = 1'b0;
assign MEMRD_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FULL_net_1   = FULL_net_0;
assign FULL         = FULL_net_1;
assign EMPTY_net_1  = EMPTY_net_0;
assign EMPTY        = EMPTY_net_1;
assign AFULL_net_1  = AFULL_net_0;
assign AFULL        = AFULL_net_1;
assign AEMPTY_net_1 = AEMPTY_net_0;
assign AEMPTY       = AEMPTY_net_1;
assign Q_0_net_0    = Q_0;
assign Q[31:0]      = Q_0_net_0;
assign RDCNT_net_1  = RDCNT_net_0;
assign RDCNT[9:0]   = RDCNT_net_1;
assign WRCNT_net_1  = WRCNT_net_0;
assign WRCNT[9:0]   = WRCNT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------FIFO_FIFO_0_COREFIFO   -   Actel:DirectCore:COREFIFO:2.8.101
FIFO_FIFO_0_COREFIFO #( 
        .AE_STATIC_EN   ( 1 ),
        .AEVAL          ( 4 ),
        .AF_STATIC_EN   ( 1 ),
        .AFVAL          ( 400 ),
        .CTRL_TYPE      ( 2 ),
        .ECC            ( 0 ),
        .ESTOP          ( 1 ),
        .FAMILY         ( 24 ),
        .FSTOP          ( 1 ),
        .FWFT           ( 0 ),
        .NUM_STAGES     ( 2 ),
        .OVERFLOW_EN    ( 0 ),
        .PIPE           ( 2 ),
        .PREFETCH       ( 0 ),
        .RCLK_EDGE      ( 1 ),
        .RDCNT_EN       ( 1 ),
        .RDEPTH         ( 480 ),
        .RE_POLARITY    ( 0 ),
        .READ_DVALID    ( 0 ),
        .RESET_POLARITY ( 0 ),
        .RWIDTH         ( 32 ),
        .SYNC           ( 1 ),
        .UNDERFLOW_EN   ( 0 ),
        .WCLK_EDGE      ( 1 ),
        .WDEPTH         ( 480 ),
        .WE_POLARITY    ( 0 ),
        .WRCNT_EN       ( 1 ),
        .WRITE_ACK      ( 0 ),
        .WWIDTH         ( 32 ) )
FIFO_0(
        // Inputs
        .CLK        ( CLK ),
        .WCLOCK     ( GND_net ), // tied to 1'b0 from definition
        .RCLOCK     ( GND_net ), // tied to 1'b0 from definition
        .RESET      ( RESET ),
        .WE         ( WE ),
        .RE         ( RE ),
        .DATA       ( DATA ),
        .MEMRD      ( MEMRD_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .FULL       ( FULL_net_0 ),
        .EMPTY      ( EMPTY_net_0 ),
        .AFULL      ( AFULL_net_0 ),
        .AEMPTY     ( AEMPTY_net_0 ),
        .OVERFLOW   (  ),
        .UNDERFLOW  (  ),
        .WACK       (  ),
        .DVLD       (  ),
        .MEMWE      (  ),
        .MEMRE      (  ),
        .SB_CORRECT (  ),
        .DB_DETECT  (  ),
        .Q          ( Q_0 ),
        .WRCNT      ( WRCNT_net_0 ),
        .RDCNT      ( RDCNT_net_0 ),
        .MEMWADDR   (  ),
        .MEMRADDR   (  ),
        .MEMWD      (  ) 
        );


endmodule
