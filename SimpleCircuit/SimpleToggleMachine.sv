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
    if (!reset) begin
      q <= 1'b0;
      z <= 1'b1;
    end
    else if (en) begin
      q <= ~z;
      z <= ~q;
    end
    else begin
      q <= q; // hold value
      z <= z; // hold value
    end
  end
endmodule
