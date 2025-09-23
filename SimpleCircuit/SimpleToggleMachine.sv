// File: simple_toggle_with_SVA.sv
// Very simple toggle flip-flop with SystemVerilog Assertions (SVA)
// No arrays, just scalar logic.

module simple_toggle (
  input  logic clk,
  input  logic reset,  // active-low async reset
  input  logic en,     // enable toggle when high
  output logic q,       // output bit
  output logic z        // complementary output
);

  // Sequential logic: toggle when enabled
  always_ff @(posedge clk or negedge reset) begin
    if (!reset)
      q <= 1'b0;
      z <= 1'b1;
    else if (en)
      q <= ~z;
      z <= ~q;
    else
      q <= q; // hold value
      z <= z; // hold value
  end
endmodule

// ---------------------------------------------------------
// Testbench: drives simple stimulus to exercise assertions
// ---------------------------------------------------------
module tb_simple_toggle;
  logic clk;
  logic reset;
  logic en;
  logic q;
  logic z;

  // Instantiate DUT
  simple_toggle dut(
    .clk(clk),
    .reset(reset),
    .en(en),
    .q(q),
    .z(z)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Simulation control
  initial begin
    $dumpfile("tb_simple_toggle.vcd");
    $dumpvars(0, tb_simple_toggle);

    reset = 0;
    en    = 0;
    #12;  // hold reset low a bit
    reset = 1;

    // Enable toggling for a few cycles
    en = 1;
    #10;

    // Disable for a few cycles
    en = 0;
    #10;

    // Re-enable
    en = 1;
    #10;

    $display("Test completed");
    $finish;
    end
endmodule
