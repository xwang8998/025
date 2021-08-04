read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {D:/820/igloo/soc/sdio25/designer/u8/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {D:\820\igloo\soc\sdio25\designer\u8\u8_layout_combinational_loops.xml}
report -type slack {D:\820\igloo\soc\sdio25\designer\u8\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {D:\820\igloo\soc\sdio25\designer\u8\u8_place_and_route_constraint_coverage.xml}]
set reportfile {D:\820\igloo\soc\sdio25\designer\u8\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp