// transition_detector_tb.v
// ECE 303 HW 3 Problem 1 - Testbench
//
// Drives the 9-bit sequence shown in the HW3 PDF (in = 0 1 1 0 0 1 0 1 1)
// plus one trailing 0 so the final 1->0 transition is visible.  Prints a
// per-cycle log of {rstb, in, out, Q1, Q0} and dumps a VCD for SimVision.
//
// Sim clock: 10 ns period (readability only -- synthesis target is 0.5 ns).
// Stimulus changes on the negedge so values are stable at the next posedge.

`timescale 1ns / 1ps

module transition_detector_tb;

    reg  clk;
    reg  rstb;
    reg  in;
    wire out;

    transition_detector dut (
        .clk  (clk),
        .rstb (rstb),
        .in   (in),
        .out  (out)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("transition_detector_tb.vcd");
        $dumpvars(0, transition_detector_tb);

        $display("  time | rstb | in | out | Q1 Q0");
        $display("-------+------+----+-----+------");
        $monitor("%6t |  %b   | %b  |  %b  |  %b  %b",
                 $time, rstb, in, out, dut.Q1, dut.Q0);

        rstb = 1'b0;
        in   = 1'b0;

        // Release reset on a negedge so the first post-reset posedge sees in=0
        @(negedge clk) rstb = 1'b1;

        // 9-cycle PDF sequence: 0 1 1 0 0 1 0 1 1
        // (the first 0 is the implicit post-reset cycle; subsequent values are
        // driven here)
        @(negedge clk) in = 1'b1;   // cycle 2
        @(negedge clk) in = 1'b1;   // cycle 3
        @(negedge clk) in = 1'b0;   // cycle 4
        @(negedge clk) in = 1'b0;   // cycle 5
        @(negedge clk) in = 1'b1;   // cycle 6
        @(negedge clk) in = 1'b0;   // cycle 7
        @(negedge clk) in = 1'b1;   // cycle 8
        @(negedge clk) in = 1'b1;   // cycle 9
        @(negedge clk) in = 1'b0;   // trailing: shows final 1->0 transition
        @(negedge clk);
        #5 $finish;
    end

endmodule
