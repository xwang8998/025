open_project -project {D:\820\igloo\soc\sdio25\designer\u8\u8_fp\u8.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2GL025} \
    -fpga {D:\820\igloo\soc\sdio25\designer\u8\u8.map} \
    -header {D:\820\igloo\soc\sdio25\designer\u8\u8.hdr} \
    -spm {D:\820\igloo\soc\sdio25\designer\u8\u8.spm} \
    -dca {D:\820\igloo\soc\sdio25\designer\u8\u8.dca}
export_single_stapl \
    -name {M2GL025} \
    -file {D:\820\igloo\soc\sdio25\designer\u8\export\u8.stp} \
    -secured


save_project
close_project
