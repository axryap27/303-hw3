# memory_module.sdc
# ECE 303 HW 3 Problem 2 - Timing constraints for the 256x8 memory module.
# Sequential design with a 1.0 ns clock period (50% duty cycle).
# Style follows the SDC template from Lecture 5, slide 25.

create_clock -name CLK -period 1.0 -waveform {0 0.5} [get_ports CLK]
set_clock_uncertainty 0.05 [get_clocks CLK]

# I/O delay budget = 20% of clock period
set_input_delay  -clock CLK 0.2 [get_ports {RSTB WE CE SEQ ADDRESS INPUT}]
set_output_delay -clock CLK 0.2 [get_ports OUTPUT]

# Output load and input drive caps
set_load            0.050 [all_outputs]
set_max_capacitance 0.010 [all_inputs]

# Signal transition speed
set_max_transition  0.10  [current_design]

# Keep regular flops (no scan substitution)
set_attr use_scan_seqs_for_non_dft false
