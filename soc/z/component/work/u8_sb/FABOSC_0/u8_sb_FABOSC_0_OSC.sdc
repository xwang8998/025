set_component u8_sb_FABOSC_0_OSC
# Microsemi Corp.
# Date: 2021-Jul-22 16:09:38
#

create_clock -ignore_errors -period 20 [ get_pins { I_RCOSC_25_50MHZ/CLKOUT } ]
