module SimpleToggleAssertion(
  input logic clk,
  input logic reset,
  input logic en,
  input logic q,
  input logic z
);
  // Assertion: z should be the complement of q
  property p1;
    @(posedge clk)
    disable iff (reset)
    (en && q) |-> ##1 (!en || z);
  endproperty
  property p2;
    @(posedge clk)
    disable iff (reset)
    (en && !q) |-> ##2 (!en || z);
  endproperty
  assert_p1: assert property(p1);
  assert_p2: assert property(p2);

endmodule