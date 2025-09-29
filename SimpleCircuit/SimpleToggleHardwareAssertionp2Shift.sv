module SimpleToggleHardwareAssertion(
    input logic clk,
    input logic reset,
    input logic en,
    input logic q,
    input logic z
);

  typedef enum logic [1:0] {START,S1} state_type;
  state_type state, next_state;
  // State encoding
  always_ff @(posedge clk or negedge reset) begin
    if (!reset)
      state <= START;
    else
      state <= next_state;
  end

  logic [1:0] shift_reg;
  always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
      shift_reg <= 2'b00;
    end
    else
      shift_reg <= {(en && q) ? 1'b1 : 1'b0, shift_reg[1]};
  end


  // Next state logic
  always_comb begin
    case (state)
      START: next_state = (shift_reg[1] == 1'b1) ? S1 : START;
      S1: next_state    = (shift_reg[1] == 1'b1) ? S1 : START;
    endcase
  end
  // Output logic
  always_ff @(posedge clk) begin
    if (state == S1)
      assert(z);
  end

endmodule
