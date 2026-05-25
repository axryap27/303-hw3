# synth_opt_high.tcl
# ECE 303 HW 3 Problem 2 - Genus synthesis at HIGH effort
# Mirrors /home/jgu/ECE303/synthesis_example/FP_multiplier/synth_opt_high.tcl
#
# Usage:
#   cd p2
#   mkdir -p Synthesis/synth_opt_high
#   cd Synthesis
#   genus -f ../synth_opt_high.tcl

set_db hdl_search_path { .. }
read_hdl [list memory_module.v]

set_db library     /vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib
set_db lef_library /vol/ece303/genus_tutorial/NangateOpenCellLibrary.lef

elaborate memory_module
current_design memory_module

read_sdc ../memory_module.sdc

set_db auto_ungroup both

set_db syn_opt_effort     high
set_db syn_generic_effort high
set_db syn_map_effort     high

syn_generic
syn_map
syn_opt
syn_opt -incremental
syn_opt -incremental

report_timing > synth_opt_high/timing.rpt
report_area   > synth_opt_high/area.rpt
report_gates  > synth_opt_high/gates.rpt
report_power  > synth_opt_high/power.rpt

write_hdl > synth_opt_high/memory_module_syn_high.v
write_sdc > synth_opt_high/memory_module_syn_high.sdc
