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
    // Next state logic
    always_comb begin
        case (state)
            START: next_state = (en && q) ? S1 : START;
            S1: next_state    = (en && q) ? S1 : START;
        endcase
    end
    // Output logic
    always_ff @(posedge clk) begin
        if (state == S1)
            assert(z);
    end

endmodule
