# Written by Synplify Pro version map201609actrcp1, Build 005R. Synopsys Run ID: sid1625299362 
# Top Level Design Parameters 

# Clocks 
create_clock -period 8.000 -waveform {0.000 4.000} -name {mclk} [get_ports {mclk}] 
create_clock -period 16.000 -waveform {0.000 8.000} -name {wck} [get_pins {test_0/wck:Y}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {u8|clock138_bck} [get_ports {clock138_bck}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {u8|sdclk} [get_ports {sdclk}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sdtop|mmclk_d2_inferred_clock} [get_pins {test_0/u100/mmclk_d2:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sdtop|mmclk_d4_inferred_clock} [get_pins {test_0/u100/mmclk_d4:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {u8_FCCC_0_FCCC|GL0_net_inferred_clock} [get_pins {FCCC_0/CCC_INST:GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sdtop|dsd_clkr_inferred_clock} [get_pins {test_0/u100/dsd_clkr:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sample|m_inferred_clock[4]} [get_pins {test_0/u100/u_sample/m[4]:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {pcm_tx|ii_inferred_clock[5]} [get_pins {test_0/u100/UPCMTX/ii[5]:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_divider|clk2_inferred_clock} [get_pins {test_0/u100/DSD138/UIN100/UCK0/clk2:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_divider|clk4_inferred_clock} [get_pins {test_0/u100/DSD138/UIN100/UCK0/clk4:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_divider|clk8_inferred_clock} [get_pins {test_0/u100/DSD138/UIN100/UCK0/clk8:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_div|clk2_inferred_clock} [get_pins {test_0/u_clock_div/clk2:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_div|clk4_inferred_clock} [get_pins {test_0/u_clock_div/clk4:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_div|clk8_inferred_clock} [get_pins {test_0/u_clock_div/clk8:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_div|clk16_inferred_clock} [get_pins {test_0/u_clock_div/clk16:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_div|clk32_inferred_clock} [get_pins {test_0/u_clock_div/clk32:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {u8_sb_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {u8_sb_0/CCC_0/CCC_INST:GL0}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 
set_false_path -from [get_ports {DEVRST_N}] 
set_false_path -to [get_ports {en45}] 
set_false_path -to [get_ports {en49}] 
set_false_path -to [get_ports {led0 led1 led2 led3 led4 led5 led6 led7}] 
set_false_path -to [get_ports {spdif_en spdif_tx}] 
set_false_path -from [get_cells {test_0/u100/uctrl/sound_card_start}] 
set_false_path -from [get_cells {test_0/u100/uctrl/use_dsd}] 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {u8|clock138_bck}]
set_clock_groups -asynchronous -group [get_clocks {u8|sdclk}]
set_clock_groups -asynchronous -group [get_clocks {sdtop|mmclk_d2_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {sdtop|mmclk_d4_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {u8_FCCC_0_FCCC|GL0_net_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {sdtop|dsd_clkr_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {sample|m_inferred_clock[4]}]
set_clock_groups -asynchronous -group [get_clocks {pcm_tx|ii_inferred_clock[5]}]
set_clock_groups -asynchronous -group [get_clocks {clock_divider|clk2_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_divider|clk4_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_divider|clk8_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_div|clk2_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_div|clk4_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_div|clk8_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_div|clk16_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {clock_div|clk32_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {u8_sb_CCC_0_FCCC|GL0_net_inferred_clock}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# create_clock -name mmclk -period 8 -waveform {0 4} [get_pins { *mmclk* }]
# create_clock -name omclk -period 8 -waveform {0 4} [get_pins { *omclk* }]
# create_clock -name gl0 -period 16 -waveform {0 8} [get_pins { *GL0_INST* }]
# create_clock -name sdclk_n -period 16 -waveform {0 8} [get_pins { *sdclk_n* }]
# create_clock -name clock138_bck -period 16 -waveform {0 8} [get_pins { *clock138_bck* }]
# create_clock -name spdif_clock -period 16 -waveform {0 8} [get_pins { *spdif_clock* }]
# create_clock -name mclk4549 -period 16 -waveform {0 8} [get_pins { *mclk* }]
# create_clock -name dsd_clk -period 16 -waveform {0 8} [get_pins { *dsd_clk* }]
# create_clock -name in_bck -period 16 -waveform {0 8} [get_pins { *in_bck* }]
# set_false_path -from [get_clocks { gl0 }] -to test_0*
# set_false_path -from [get_clocks { mclk4549 }] -to u8_sb*
# set_false_path -from [get_clocks { mclk4549 }] -to *USPDIF_TX*
# set_false_path -from [get_clocks { mclk }] -to test_0.u100*
# set_false_path -from [get_clocks { mclk4549 }] -to *UPCMTX*
# set_false_path -from [get_clocks { sdclk_n }] -to test_0.u200*
# set_false_path -from [get_clocks { sdclk_n }] -to *usync*
# set_false_path -from [get_clocks { sdclk_n }] -to *usync*
# set_false_path -from [get_clocks { sdclk_n }] -to *ufifo*
# set_false_path -from [get_clocks { in_bck }] -to test_0.u100.uctrl*
# set_false_path -from [get_clocks { sdclk_n }] -to u8_sb*
# set_false_path -from [get_clocks { clock138_bck }] -to test_0.u200*
# set_false_path -from [get_clocks { mclk }] -to test_0.u200*
# set_false_path -from [get_clocks { sdclk_n }] -to *UPCM*
# set_false_path -from [get_clocks { sdclk_n }] -to *uctrl*

# Non-forward-annotatable constraints (intentionally commented out) 
# set_clock_groups -name Inferred_clkgroup_17 -derive -asynchronous -group c:u8_sb_FABOSC_0_OSC|N_RCOSC_25_50MHZ_CLKOUT_inferred_clock

# Block Path constraints 

