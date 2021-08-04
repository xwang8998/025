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
set_def {RTG4_MITIGATION_ON} {0}
set_def USE_CONSTRAINTS_FLOW 1
set_def NETLIST_TYPE EDIF
set_name u8
set_workdir {C:\igloo\soc\z\designer\u8}
set_log     {C:\igloo\soc\z\designer\u8\u8_coverage_pr.log}
set_design_state pre_layout
