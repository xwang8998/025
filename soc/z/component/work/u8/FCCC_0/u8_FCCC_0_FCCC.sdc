set_component u8_FCCC_0_FCCC
# Microsemi Corp.
# Date: 2020-Aug-26 11:03:52
#

create_clock -period 10.1725 [ get_pins { CCC_INST/CLK0 } ]
create_generated_clock -multiply_by 2 -divide_by 4 -source [ get_pins { CCC_INST/CLK0 } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
