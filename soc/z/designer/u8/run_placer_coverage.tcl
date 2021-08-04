set_family {IGLOO2}
read_adl {C:\igloo\soc\z\designer\u8\u8.adl}
map_netlist
read_sdc {c:\igloo\work\test.sdc}
check_constraints {C:\igloo\soc\z\designer\u8\placer_coverage.log}
write_sdc -strict {C:\igloo\soc\z\designer\u8\place_route.sdc}
