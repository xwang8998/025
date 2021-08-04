set_device \
    -family  IGLOO2 \
    -die     PA4MGL2500_N \
    -package fg484 \
    -speed   -1 \
    -tempr   {COM} \
    -voltr   {COM}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_def {PLL_SUPPLY} {PLL_SUPPLY_25}
set_netlist -afl {D:\820\igloo\soc\sdio25\designer\u8\u8.afl} -adl {D:\820\igloo\soc\sdio25\designer\u8\u8.adl}
set_constraints   {D:\820\igloo\soc\sdio25\designer\u8\u8.tcml}
set_placement   {D:\820\igloo\soc\sdio25\designer\u8\u8.loc}
set_routing     {D:\820\igloo\soc\sdio25\designer\u8\u8.seg}
