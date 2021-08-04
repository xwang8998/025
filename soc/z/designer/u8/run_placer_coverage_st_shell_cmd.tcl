read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/igloo/soc/z/designer/u8/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\igloo\soc\z\designer\u8\u8_place_and_route_constraint_coverage.xml}]
set reportfile {C:\igloo\soc\z\designer\u8\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
