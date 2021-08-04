new_project \
         -name {u8} \
         -location {C:\igloo\soc\z\designer\u8\u8_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2GL005} \
         -name {M2GL005}
enable_device \
         -name {M2GL005} \
         -enable {TRUE}
save_project
close_project
