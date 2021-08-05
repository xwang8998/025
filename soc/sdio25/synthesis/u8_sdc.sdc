# Written by Synplify Pro version map202003act, Build 160R. Synopsys Run ID: sid1628082408 
# Top Level Design Parameters 

# Clocks 
create_clock -period 8.000 -waveform {0.000 4.000} -name {mclk} [get_ports {mclk}] 
create_clock -period 16.000 -waveform {0.000 8.000} -name {mclk4549} [get_pins {test_0/UCK1/Y}] 
create_clock -period 16.000 -waveform {0.000 8.000} -name {sdclk_n} [get_pins {test_0/UCK3/Y}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {u8_sb_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {u8_sb_0/CCC_0/CCC_INST/GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {test|c1_inferred_clock} [get_pins {test_0/c1/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {test|c2_inferred_clock} [get_pins {test_0/c2/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {adc96|clkd16_inferred_clock} [get_pins {test_0/UADC/clkd16/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {adc96|clkd2_inferred_clock} [get_pins {test_0/UADC/clkd2/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {adc96|clkd4_inferred_clock} [get_pins {test_0/UADC/clkd4/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {adc96|clkd8_inferred_clock} [get_pins {test_0/UADC/clkd8/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {wavegen|pclk_div2_inferred_clock} [get_pins {test_0/uGEN_DDS/U100/pclk_div2/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {u8|sdclk} [get_ports {sdclk}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 
set_output_delay {0.5} -clock [get_clocks {sdclk_n}] [get_ports {cmd}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln0}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln1}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln2}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln3}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln4}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln5}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln6}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_ln7}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp0}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp1}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp2}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp3}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp4}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp5}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp6}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_lp7}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn0}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn1}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn2}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn3}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn4}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn5}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn6}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rn7}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp0}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp1}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp2}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp3}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp4}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp5}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp6}]
set_output_delay {3.7} -clock [get_clocks {mclk}] [get_ports {dsd_rp7}]
set_output_delay {0.5} -clock [get_clocks {sdclk_n}] [get_ports {sd_d0}]
set_output_delay {0.5} -clock [get_clocks {sdclk_n}] [get_ports {sd_d1}]
set_output_delay {0.5} -clock [get_clocks {sdclk_n}] [get_ports {sd_d2}]
set_output_delay {0.5} -clock [get_clocks {sdclk_n}] [get_ports {sd_d3}]

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {mclk}] -group [get_clocks {mclk4549}] -group [get_clocks {sdclk_n}]
set_clock_groups -asynchronous -group [get_clocks {u8_sb_CCC_0_FCCC|GL0_net_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {test|c1_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {test|c2_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {adc96|clkd16_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {adc96|clkd2_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {adc96|clkd4_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {adc96|clkd8_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {wavegen|pclk_div2_inferred_clock}]
set_clock_groups -asynchronous -group [get_clocks {u8|sdclk}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -from [get_ports { DEVRST_N* }]
# set_false_path -to [get_ports { en45* }]
# set_false_path -to [get_ports { en49* }]
# set_false_path -to [get_ports { led* }]
# set_false_path -to [get_ports { spdif_en* }]
# set_false_path -from [get_clocks { gl0 }] -to test_0*
# set_false_path -from [get_clocks { mclk4549 }] -to u8_sb*
# set_false_path -from [get_clocks { mclk }] -to test_0.u100*
# set_false_path -from [get_clocks { mclk4549 }] -to test_0.mclk_d2*
# set_false_path -from [get_clocks { sdclk_n }] -to *ufifo*
# set_false_path -from [get_clocks { sdclk_n }] -to u8_sb*
# set_false_path -from [get_clocks { sdclk_n }] -to *uctrl*


# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

