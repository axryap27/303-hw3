# ####################################################################

#  Created by Genus(TM) Synthesis Solution 18.14-s037_1 on Mon May 25 11:24:14 CDT 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1.0fF
set_units -time 1000.0ps

# Set the current design
current_design transition_detector

create_clock -name "CLK" -period 0.5 -waveform {0.0 0.25} [get_ports clk]
set_load -pin_load -min 0.0 [get_ports out]
set_load -pin_load -max 0.1 [get_ports out]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks CLK] -add_delay 0.1 [get_ports in]
set_input_delay -clock [get_clocks CLK] -add_delay 0.1 [get_ports rstb]
set_output_delay -clock [get_clocks CLK] -add_delay 0.1 [get_ports out]
set_max_transition 0.07 [current_design]
set_max_capacitance 0.0 [get_ports clk]
set_max_capacitance 0.0 [get_ports rstb]
set_max_capacitance 0.0 [get_ports in]
set_dont_use [get_lib_cells NangateOpenCellLibrary/ANTENNA_X1]
set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X1]
set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X2]
set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X4]
set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X8]
set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X16]
set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X32]
set_dont_use [get_lib_cells NangateOpenCellLibrary/LOGIC0_X1]
set_dont_use [get_lib_cells NangateOpenCellLibrary/LOGIC1_X1]
set_clock_uncertainty -setup 0.02 [get_clocks CLK]
set_clock_uncertainty -hold 0.02 [get_clocks CLK]
