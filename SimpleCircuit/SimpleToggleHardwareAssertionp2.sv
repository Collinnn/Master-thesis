module SimpleToggleHardwareAssertion(
    input logic clk,
    input logic reset,
    input logic en,
    input logic q,
    input logic z
);

  typedef enum logic [1:0] {START,S1,S2,S3} state_type;
  state_type state, next_state;
  // State encoding
  always_ff @(posedge clk or negedge reset) begin
    if (!reset)
      state <= START;
    else
      state <= next_state;
  end
  // Next state logic
  always_comb begin
    case (state)
      START: next_state = (en && q) ? S1 : START;
      S1: next_state    = (en && q) ? S2 : S3;
      S2: next_state    = (en && q) ? S2 : S3;
      S3: next_state    = (en && q) ? S1 : START;
    endcase
  end
  // Output logic
  always_ff @(posedge clk) begin
    if (state == S2)
      assert(z);
    else if (state == S3)
      assert(z);
  end

endmodule
