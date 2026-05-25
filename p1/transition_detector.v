// transition_detector.v
// ECE 303 HW 3 Problem 1 - Moore FSM transition detector
//
// `out` is held high for one clock whenever `in` changes from one clock to
// the next.  Realization: 2 D-flip-flops + 1 XOR gate.
//   Q1_next = in
//   Q0_next = in ^ Q1     (transition flag for the just-taken edge)
//   out     = Q0
//
// State encoding {Q1, Q0}:
//   S0 = 2'b00 : last in = 0, no transition  (out = 0)
//   S1 = 2'b01 : last in = 0, 1->0 transition (out = 1)
//   S2 = 2'b10 : last in = 1, no transition  (out = 0)
//   S3 = 2'b11 : last in = 1, 0->1 transition (out = 1)
//
// Active-low asynchronous reset puts the FSM in S0 with the input assumed 0
// until the first post-reset clock cycle (per the HW3 spec).

`timescale 1ns / 1ps

module transition_detector (
    input  wire clk,
    input  wire rstb,
    input  wire in,
    output wire out
);

    reg Q1, Q0;

    always @(posedge clk or negedge rstb) begin
        if (!rstb) begin
            Q1 <= 1'b0;
            Q0 <= 1'b0;
        end else begin
            Q1 <= in;
            Q0 <= in ^ Q1;
        end
    end

    assign out = Q0;

endmodule
