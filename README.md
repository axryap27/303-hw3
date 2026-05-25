# ECE 303 — Homework 3

Aarya Patel · Spring 2026

Two designs, written in Verilog, simulated in **Cadence Xcelium** and synthesized with **Cadence Genus** (NangateOpenCellLibrary).

| | Design | Clock period |
|---|---|---|
| Problem 1 | Moore-FSM transition detector (2 DFF + XOR) | 0.5 ns |
| Problem 2 | 256 × 8 memory with `SEQ` auto-increment addressing | 1.0 ns |

---

## Where to find each deliverable

### Problem 1 — `p1/`

| Asks for | File |
|---|---|
| RTL | [`p1/transition_detector.v`](p1/transition_detector.v) |
| Testbench | [`p1/transition_detector_tb.v`](p1/transition_detector_tb.v) |
| SDC | [`p1/transition_detector.sdc`](p1/transition_detector.sdc) |
| Timing report | [`p1/Synthesis/synth_opt_high/timing.rpt`](p1/Synthesis/synth_opt_high/timing.rpt) |
| Area report | [`p1/Synthesis/synth_opt_high/area.rpt`](p1/Synthesis/synth_opt_high/area.rpt) |
| Waveforms | screenshots in the submitted PDF; raw VCD at [`p1/transition_detector_tb.vcd`](p1/transition_detector_tb.vcd) |

Bonus: [`gates.rpt`](p1/Synthesis/synth_opt_high/gates.rpt), [`power.rpt`](p1/Synthesis/synth_opt_high/power.rpt), and the post-synthesis netlist [`transition_detector_syn_high.v`](p1/Synthesis/synth_opt_high/transition_detector_syn_high.v).

### Problem 2 — `p2/`

| Asks for | File |
|---|---|
| RTL | [`p2/memory_module.v`](p2/memory_module.v) |
| Testbench | [`p2/memory_module_tb.v`](p2/memory_module_tb.v) |
| SDC | [`p2/memory_module.sdc`](p2/memory_module.sdc) |
| Timing report | [`p2/Synthesis/synth_opt_high/timing.rpt`](p2/Synthesis/synth_opt_high/timing.rpt) |
| Area report | [`p2/Synthesis/synth_opt_high/area.rpt`](p2/Synthesis/synth_opt_high/area.rpt) |
| Waveforms | screenshots in the submitted PDF; raw VCD at [`p2/memory_module_tb.vcd`](p2/memory_module_tb.vcd) |

Bonus: [`gates.rpt`](p2/Synthesis/synth_opt_high/gates.rpt), [`power.rpt`](p2/Synthesis/synth_opt_high/power.rpt), and the post-synthesis netlist [`memory_module_syn_high.v`](p2/Synthesis/synth_opt_high/memory_module_syn_high.v).

---

## Headline numbers

| | P1 (transition detector) | P2 (memory) |
|---|---|---|
| Clock target | 0.5 ns | 1.0 ns |
| Setup slack | **+270 ps** (MET) | **0 ps** (MET) |
| Cell area | 13.0 μm² | 16,107 μm² |
| Total area (cell + net) | 17.5 μm² | 22,842 μm² |
| Total cells | 4 | 3,971 |
| Sequential cells | 2 (DFFR) | 2,065 |
