set_device \
    -family  IGLOO2 \
    -die     PA4MGL500 \
    -package vf256 \
    -speed   STD \
    -tempr   {COM} \
    -voltr   {COM}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_name u8
set_workdir {C:\igloo\soc\z\designer\u8}
set_filename    {C:\igloo\soc\z\designer\u8\u8_ba}
set_design_state post_layout
set_language VERILOG
