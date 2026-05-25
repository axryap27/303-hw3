// memory_module_tb.v
// ECE 303 HW 3 Problem 2 - Testbench
//
// Covers all required scenarios from the HW3 spec:
//   * Reset clears memory and internal regs
//   * CE = 0 forces OUTPUT to 8'bz
//   * >=2 writes and >=2 reads in normal mode (SEQ = 0)
//   * >=2 writes and >=2 reads in sequential mode (SEQ = 1)
//   * SEQ -> 0 -> 1 transition restarts the address counter at ADDRESS
//
// Clock period: 1 ns (as specified in Problem 2(3)).

`timescale 1ns / 1ps

module memory_module_tb;

    reg         CLK;
    reg         RSTB;
    reg         WE;
    reg         CE;
    reg         SEQ;
    reg  [7:0]  ADDRESS;
    reg  [7:0]  INPUT;
    wire [7:0]  OUTPUT;

    memory_module dut (
        .CLK     (CLK),
        .RSTB    (RSTB),
        .WE      (WE),
        .CE      (CE),
        .SEQ     (SEQ),
        .ADDRESS (ADDRESS),
        .INPUT   (INPUT),
        .OUTPUT  (OUTPUT)
    );

    // 1 ns period clock (500 ps high / 500 ps low)
    initial CLK = 1'b0;
    always #0.5 CLK = ~CLK;

    initial begin
        $dumpfile("memory_module_tb.vcd");
        $dumpvars(0, memory_module_tb);

        $display("  time  | RSTB CE WE SEQ | ADDR INPUT | OUTPUT");
        $display("--------+----------------+------------+-------");
        $monitor("%7t |  %b   %b  %b   %b  |  %h    %h  |   %h",
                 $time, RSTB, CE, WE, SEQ, ADDRESS, INPUT, OUTPUT);

        // ---- Initial state: chip held in reset, disabled ----
        RSTB    = 1'b0;
        CE      = 1'b0;
        WE      = 1'b0;
        SEQ     = 1'b0;
        ADDRESS = 8'h00;
        INPUT   = 8'h00;

        // Release reset, then enable chip
        @(negedge CLK) RSTB = 1'b1;
        @(negedge CLK) CE   = 1'b1;

        // ============ Phase A: SEQ = 0 writes (3 of them) ============
        @(negedge CLK) begin WE = 1'b1; ADDRESS = 8'h10; INPUT = 8'hAA; end
        @(negedge CLK) begin             ADDRESS = 8'h11; INPUT = 8'hBB; end
        @(negedge CLK) begin             ADDRESS = 8'h12; INPUT = 8'hCC; end

        // ============ Phase B: SEQ = 0 reads (3 of them) ============
        @(negedge CLK) begin WE = 1'b0; ADDRESS = 8'h10; end  // expect AA
        @(negedge CLK)                  ADDRESS = 8'h11;       // expect BB
        @(negedge CLK)                  ADDRESS = 8'h12;       // expect CC

        // ============ Phase C: CE = 0 -> OUTPUT should be 8'bz ============
        @(negedge CLK) CE = 1'b0;
        @(negedge CLK);
        @(negedge CLK) CE = 1'b1;

        // ============ Phase D: SEQ = 1 writes (4 sequential) ============
        @(negedge CLK) begin WE = 1'b1; SEQ = 1'b1; ADDRESS = 8'h20; INPUT = 8'h11; end
        @(negedge CLK)                                                INPUT = 8'h22;
        @(negedge CLK)                                                INPUT = 8'h33;
        @(negedge CLK)                                                INPUT = 8'h44;
        // MEM[20]=11, MEM[21]=22, MEM[22]=33, MEM[23]=44

        // Drop SEQ for one cycle so the next SEQ=1 run restarts at ADDRESS.
        // Also drop WE so the transition cycle does not corrupt MEM[20].
        @(negedge CLK) begin SEQ = 1'b0; WE = 1'b0; end

        // ============ Phase E: SEQ = 1 reads (4 sequential) ============
        @(negedge CLK) begin SEQ = 1'b1; ADDRESS = 8'h20; end  // expect 11
        @(negedge CLK);                                          // expect 22
        @(negedge CLK);                                          // expect 33
        @(negedge CLK);                                          // expect 44

        @(negedge CLK) SEQ = 1'b0;
        @(negedge CLK);
        #1 $finish;
    end

endmodule
