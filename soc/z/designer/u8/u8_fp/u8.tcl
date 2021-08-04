open_project -project {C:\igloo\soc\z\designer\u8\u8_fp\u8.pro}\
         -connect_programmers {FALSE}
if { [catch {load_programming_data \
    -name {M2GL005} \
    -fpga {C:\igloo\soc\z\designer\u8\u8.map} \
    -header {C:\igloo\soc\z\designer\u8\u8.hdr} \
    -spm {C:\igloo\soc\z\designer\u8\u8.spm} \
    -dca {C:\igloo\soc\z\designer\u8\u8.dca} } return_val] } {
save_project
close_project
exit }
export_single_stapl \
    -name {M2GL005} \
    -file {C:\igloo\soc\z\designer\u8\export\u8_gd1_dop_v4.stp} \
    -secured
set_programming_file -name {M2GL005} -no_file
save_project
close_project
