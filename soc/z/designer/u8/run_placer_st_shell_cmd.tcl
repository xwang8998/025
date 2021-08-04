read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/igloo/soc/z/designer/u8/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\igloo\soc\z\designer\u8\u8_layout_combinational_loops.xml}
report -type slack {C:\igloo\soc\z\designer\u8\pinslacks.txt}
