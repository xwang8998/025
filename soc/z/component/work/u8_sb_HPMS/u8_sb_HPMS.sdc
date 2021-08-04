set_component u8_sb_HPMS
# Microsemi Corp.
# Date: 2021-Jul-22 16:09:29
#

create_clock -period 81.3802 [ get_pins { MSS_ADLIB_INST/CLK_CONFIG_APB } ]
set_false_path -ignore_errors -through [ get_pins { MSS_ADLIB_INST/CONFIG_PRESET_N } ]
