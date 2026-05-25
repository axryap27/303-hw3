
# XM-Sim Command File
# TOOL:	xmsim	18.09-s011
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias quit exit
database -open -vcd -into transition_detector_tb.vcd _transition_detector_tb.vcd1 -timescale fs
database -open -evcd -into transition_detector_tb.vcd _transition_detector_tb.vcd -timescale fs
database -open -shm -into waves.shm waves -default
probe -create -database waves transition_detector_tb.dut.Q0 transition_detector_tb.dut.Q1 transition_detector_tb.dut.clk transition_detector_tb.dut.in transition_detector_tb.dut.out transition_detector_tb.dut.rstb

simvision -input /home/lxk9828/303/303-hw3/p1/.simvision/3679787_lxk9828_batman.ece.northwestern.edu_autosave.tcl.svcf
