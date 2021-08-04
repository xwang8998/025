set_family {IGLOO2}
read_verilog -mode verilog_2k {c:\igloo\work\test.v}
read_verilog -mode verilog_2k {c:\igloo\work\sound.v}
read_verilog -mode verilog_2k {c:\igloo\work\crc7.v}
read_verilog -mode verilog_2k {c:\igloo\work\bigfifo.v}
read_verilog -mode verilog_2k {c:\igloo\work\ram.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_NstagesSync.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_grayToBinConv.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_async.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_fwft.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_resetSync.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_sync.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\corefifo_sync_scntr.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\FIFO_FIFO_0_LSRAM_top.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\FIFO_FIFO_0_ram_wrapper.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO_0\rtl\vlog\core\COREFIFO.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\FIFO\FIFO.v}
read_verilog -mode verilog_2k {c:\igloo\work\sd.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8\FCCC_0\u8_FCCC_0_FCCC.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp_pcie_hotreset.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb\CCC_0\u8_sb_CCC_0_FCCC.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb\FABOSC_0\u8_sb_FABOSC_0_OSC.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb_HPMS\u8_sb_HPMS.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_addrdec.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_defaultslavesm.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_masterstage.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_slavearbiter.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_slavestage.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_matrix4x16.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb\u8_sb.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8\u8.v}
set_top_level {u8}
map_netlist
read_sdc {c:\igloo\work\test.sdc}
check_constraints {C:\igloo\soc\z\constraint\synthesis_sdc_errors.log}
write_fdc {C:\igloo\soc\z\designer\u8\synthesis.fdc}
