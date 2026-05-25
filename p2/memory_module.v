// memory_module.v
// ECE 303 HW 3 Problem 2 - 256 x 8 memory with sequential auto-increment
//
// Ports:
//   CLK     - clock
//   RSTB    - active-low async reset (clears memory and all internal regs)
//   WE      - write enable (only effective when CE = 1)
//   CE      - chip enable (OUTPUT is 8'bz whenever CE = 0)
//   SEQ     - sequence mode (auto-increment address on consecutive SEQ = 1)
//   ADDRESS - 8-bit external address
//   INPUT   - 8-bit write data
//   OUTPUT  - 8-bit read/write-echo data, high-Z when CE = 0
//
// Behaviour:
//   - Read/write completes with 1-cycle latency: the operation issued on the
//     posedge of cycle N is reflected on OUTPUT during cycle N+1.
//   - SEQ run semantics:
//       * First SEQ=1 cycle  -> address used = ADDRESS (external pin)
//       * Continuing SEQ=1   -> address used = stored seq_addr (++ each cycle)
//       * SEQ=0              -> address used = ADDRESS, internal counter idle
//     A new SEQ=1 run after any SEQ=0 cycle restarts from the external ADDRESS.

`timescale 1ns / 1ps

module memory_module (
    input  wire        CLK,
    input  wire        RSTB,
    input  wire        WE,
    input  wire        CE,
    input  wire        SEQ,
    input  wire [7:0]  ADDRESS,
    input  wire [7:0]  INPUT,
    output wire [7:0]  OUTPUT
);

    reg [7:0] MEM [0:255];
    reg [7:0] out_reg;
    reg [7:0] seq_addr;     // address used during SEQ=1 continuation cycles
    reg       seq_prev;     // value of SEQ at the previous posedge

    // During a continuation cycle of a SEQ run, use the internal counter;
    // otherwise (SEQ=0 OR first cycle of a new SEQ=1 run) use the pin ADDRESS.
    wire        seq_cont = SEQ & seq_prev;
    wire [7:0]  cur_addr = seq_cont ? seq_addr : ADDRESS;

    integer i;

    always @(posedge CLK or negedge RSTB) begin
        if (!RSTB) begin
            for (i = 0; i < 256; i = i + 1)
                MEM[i] <= 8'b0;
            out_reg  <= 8'b0;
            seq_addr <= 8'b0;
            seq_prev <= 1'b0;
        end else begin
            seq_prev <= SEQ;

            if (CE) begin
                if (WE) begin
                    MEM[cur_addr] <= INPUT;
                    out_reg       <= INPUT;
                end else begin
                    out_reg       <= MEM[cur_addr];
                end
            end

            // Stage the next continuation address while inside a SEQ=1 run.
            if (SEQ)
                seq_addr <= cur_addr + 8'd1;
        end
    end

    assign OUTPUT = CE ? out_reg : 8'bz;

endmodule
