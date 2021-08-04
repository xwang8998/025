set_family {IGLOO2}
set_editor_type {SYNTHESIS}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_addrdec.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_defaultslavesm.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_masterstage.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_matrix4x16.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_slavearbiter.v}
read_verilog -mode verilog_2k -lib COREAHBLITE_LIB {C:\igloo\soc\z\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vlog\core\coreahblite_slavestage.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp_pcie_hotreset.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8\FCCC_0\u8_FCCC_0_FCCC.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8\u8.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb\CCC_0\u8_sb_CCC_0_FCCC.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb\FABOSC_0\u8_sb_FABOSC_0_OSC.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb\u8_sb.v}
read_verilog -mode verilog_2k {C:\igloo\soc\z\component\work\u8_sb_HPMS\u8_sb_HPMS.v}
read_verilog -mode verilog_2k {c:\igloo\work\bigfifo.v}
read_verilog -mode verilog_2k {c:\igloo\work\crc7.v}
read_verilog -mode verilog_2k {c:\igloo\work\ram.v}
read_verilog -mode verilog_2k {c:\igloo\work\sd.v}
read_verilog -mode verilog_2k {c:\igloo\work\sound.v}
read_verilog -mode verilog_2k {c:\igloo\work\test.v}
set_top_level {u8}
map_netlist
read_sdc {c:\igloo\work\test.sdc}
set_output_sdc {C:\igloo\soc\z\constraint\user.sdc}
