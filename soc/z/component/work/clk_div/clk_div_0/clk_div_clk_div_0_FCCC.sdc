set_component clk_div_clk_div_0_FCCC
# Microsemi Corp.
# Date: 2020-Jul-10 16:33:21
#

create_clock -period 10.1725 [ get_pins { CCC_INST/CLK1 } ]
create_generated_clock -multiply_by 2 -divide_by 4 -source [ get_pins { CCC_INST/CLK1 } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
create_generated_clock -multiply_by 2 -divide_by 8 -source [ get_pins { CCC_INST/CLK1 } ] -phase 0 [ get_pins { CCC_INST/GL1 } ]
create_generated_clock -multiply_by 2 -divide_by 16 -source [ get_pins { CCC_INST/CLK1 } ] -phase 0 [ get_pins { CCC_INST/GL2 } ]
create_generated_clock -multiply_by 2 -divide_by 32 -source [ get_pins { CCC_INST/CLK1 } ] -phase 0 [ get_pins { CCC_INST/GL3 } ]
