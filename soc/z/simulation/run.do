quietly set ACTELLIBNAME IGLOO2
quietly set PROJECT_DIR "C:/igloo/soc/z"
source "${PROJECT_DIR}/simulation/bfmtovec_compile.tcl";

if {[file exists ../designer/u8/simulation/postlayout/_info]} {
   echo "INFO: Simulation library ../designer/u8/simulation/postlayout already exists"
} else {
   file delete -force ../designer/u8/simulation/postlayout 
   vlib ../designer/u8/simulation/postlayout
}
vmap postlayout ../designer/u8/simulation/postlayout
vmap IGLOO2 "D:/Microsemi118/Libero_SoC_v11.8/Designer/lib/modelsim/precompiled/vlog/smartfusion2"
vmap SmartFusion2 "D:/Microsemi118/Libero_SoC_v11.8/Designer/lib/modelsim/precompiled/vlog/smartfusion2"
vmap COREAHBLITE_LIB "../component/Actel/DirectCore/CoreAHBLite/5.2.100/mti/user_vlog/COREAHBLITE_LIB"
vcom -work COREAHBLITE_LIB -force_refresh
vlog -work COREAHBLITE_LIB -force_refresh

vlog -vlog01compat -work postlayout "${PROJECT_DIR}/designer/u8/u8_ba.v"

vsim -L IGLOO2 -L postlayout -L COREAHBLITE_LIB  -t 1fs -sdfmax /u8=${PROJECT_DIR}/designer/u8/u8_ba.sdf postlayout.u8
# The following lines are commented because no testbench is associated with the project
# add wave /testbench/*
# run 1000ns
