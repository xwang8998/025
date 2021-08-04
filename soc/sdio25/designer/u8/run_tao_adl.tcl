set_device -family {IGLOO2} -die {M2GL025} -speed {-1}
read_adl {D:\820\igloo\soc\sdio25\designer\u8\u8.adl}
read_afl {D:\820\igloo\soc\sdio25\designer\u8\u8.afl}
map_netlist
read_sdc {D:\820\igloo\work\test.sdc}
check_constraints {D:\820\igloo\soc\sdio25\constraint\placer_sdc_errors.log}
write_sdc -mode layout {D:\820\igloo\soc\sdio25\designer\u8\place_route.sdc}
