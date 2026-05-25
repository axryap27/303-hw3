# transition_detector.sdc
# ECE 303 HW 3 Problem 1 - Timing constraints for the FSM transition detector.
# Sequential design with a 0.5 ns clock period (50% duty cycle).
# Style follows the SDC template from Lecture 5, slide 25.

create_clock -name CLK -period 0.5 -waveform {0 0.25} [get_ports clk]
set_clock_uncertainty 0.02 [get_clocks CLK]

# I/O delay budget = 20% of clock period
set_input_delay  -clock CLK 0.1 [get_ports {in rstb}]
set_output_delay -clock CLK 0.1 [get_ports out]

# Output load and input drive caps
set_load            0.050 [all_outputs]
set_max_capacitance 0.010 [all_inputs]

# Signal transition speed
set_max_transition  0.07  [current_design]

# Keep regular flops (no scan substitution)
set_attr use_scan_seqs_for_non_dft false
