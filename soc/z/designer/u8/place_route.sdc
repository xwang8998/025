# Microsemi Corp.
# Date: 2021-Jul-03 16:06:54
# This file was generated based on the following SDC source files:
#   c:/igloo/work/test.sdc
#

### open synthesis/test.v, find all the SLE's clock section, collect the clock nets ######
create_clock -name {mclk} -period 8 -waveform {0 4 } [ get_ports { mclk } ]
create_clock -name {mmclk} -period 8 -waveform {0 4 } [ get_pins { *mmclk* } ]
###create_clock -name {mmclk_d8} -period 64 -waveform {0 32 } [ get_nets { *mmclk_d8* } ]
create_clock -name {omclk} -period 8 -waveform {0 4 } [ get_pins { *omclk* } ]
create_clock -name {gl0} -period 16 -waveform {0 8 } [ get_pins { *GL0_INST* } ]
create_clock -name {sdclk_n} -period 16 -waveform {0 8 } [ get_pins { *sdclk_n* } ]
create_clock -name {wck} -period 16 -waveform {0 8 } [ get_nets { wck } ]
###create_clock -name {sdclk_p} -period 16 -waveform {0 8 } [ get_nets { *sdclk_p* } ]
create_clock -name {clock138_bck} -period 16 -waveform {0 8 } [ get_pins { *clock138_bck* } ]
create_clock -name {spdif_clock} -period 16 -waveform {0 8 } [ get_pins { *spdif_clock* } ]
#create_clock -name {dop_clock} -period 16 -waveform {0 8 } [ get_nets { *dop_clock* } ]
create_clock -name {mclk4549} -period 16 -waveform {0 8 } [ get_pins { *mclk* } ]
#create_clock -name {decibck} -period 16 -waveform {0 8 } [ get_nets { *deci_bck* } ]
create_clock -name {dsd_clk} -period 16 -waveform {0 8 } [ get_pins { *dsd_clk* } ]
create_clock -name {in_bck} -period 16 -waveform {0 8 } [ get_pins { *in_bck* } ]
### check smartTime result, and fix these false paths ############
set_false_path -from [ get_ports { DEVRST_N* } ]
set_false_path -to [ get_ports { en45* } ]
set_false_path -to [ get_ports { en49* } ]
set_false_path -to [ get_ports { led* } ]
set_false_path -to [ get_ports { spdif* } ]
set_false_path -from [ get_clocks { gl0 } ] -to { test_0* }
set_false_path -from [ get_clocks { mclk4549 } ] -to { u8_sb* }
set_false_path -from [ get_clocks { mclk4549 } ] -to { *USPDIF_TX* }
set_false_path -from [ get_clocks { mclk } ] -to { test_0/u100* }
set_false_path -from [ get_clocks { mclk4549 } ] -to { *UPCMTX* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { test_0/u200* }
#set_false_path -from [get_clocks {mclk4549}] -to test_0/mclk_d2*
set_false_path -from [ get_clocks { sdclk_n } ] -to { *usync* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { *usync* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { *ufifo* }
#set_false_path -from [get_clocks {sdclk_n}] -to *UDOP*
set_false_path -from { test_0/u100/uctrl/sound_card_start* }
set_false_path -from { test_0/u100/uctrl/use_dsd* }
#set_false_path -from [ get_clocks { in_bck } ] -to { *DSD138* }
set_false_path -from [ get_clocks { in_bck } ] -to { test_0/u100/uctrl* }
## set_false_path -from [get_clocks {mclk4549}] -to *UADC_GEAR*
set_false_path -from [ get_clocks { sdclk_n } ] -to { u8_sb* }
set_false_path -from [ get_clocks { clock138_bck } ] -to { test_0/u200* }
set_false_path -from [ get_clocks { mclk } ] -to { test_0/u200* }
###set_false_path -from [get_clocks {decibck}] -to *UDSDTX*
set_false_path -from [ get_clocks { sdclk_n } ] -to { *UPCM* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { *uctrl* }
#set_false_path -from [ get_clocks { dop_clock } ] -to { *USPDIF_TX* }
set_clock_groups  -asynchronous -group gl0 -group sdclk_n -group mclk4549 -group dsd_clk -group spdif_clock -group clock138_bck -group mclk -group in_bck