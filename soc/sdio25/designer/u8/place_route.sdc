# Microsemi Corp.
# Date: 2021-Aug-04 15:41:39
# This file was generated based on the following SDC source files:
#   D:/820/igloo/work/test.sdc
#

create_clock -name {mclk} -period 8 -waveform {0 4 } [ get_ports { mclk } ]
create_clock -name {gl0} -period 16 -waveform {0 8 } [ get_pins { u8_sb_0/CCC_0/GL0_INST/YWn u8_sb_0/CCC_0/GL0_INST/YEn } ]
create_clock -name {sdclk_n} -period 16 -waveform {0 8 } [ get_pins { test_0/UCK3/YWn test_0/UCK3/YEn } ]
create_clock -name {mclk4549} -period 16 -waveform {0 8 } [ get_pins { test_0/UCK1/YWn test_0/UCK1/YEn } ]
set_output_delay 3.7  -clock { mclk } [ get_ports { *dsd_* } ]
set_output_delay 0.5  -clock { sdclk_n } [ get_ports { cmd sd_d0 sd_d1 sd_d2 sd_d3 } ]
set_false_path -from [ get_ports { DEVRST_N* } ]
set_false_path -to [ get_ports { en45* } ]
set_false_path -to [ get_ports { en49* } ]
set_false_path -to [ get_ports { led* } ]
set_false_path -to [ get_ports { spdif_en* } ]
set_false_path -from [ get_clocks { gl0 } ] -to { test_0* }
set_false_path -from [ get_clocks { mclk4549 } ] -to { u8_sb* }
set_false_path -from [ get_clocks { mclk } ] -to { test_0/u100* }
set_false_path -from [ get_clocks { mclk4549 } ] -to { test_0/mclk_d2* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { *ufifo* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { u8_sb* }
set_false_path -from [ get_clocks { sdclk_n } ] -to { *uctrl* }
set_clock_groups -name {u8grps} -asynchronous -group [ get_clocks { gl0 } ] -group [ get_clocks { mclk } ] -group [ get_clocks { mclk4549 } ] -group [ get_clocks { sdclk_n } ]
