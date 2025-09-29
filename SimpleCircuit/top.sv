module Top_tb;
  logic clk, reset, en, q, z;

  // Instantiate DUT
  simple_toggle dut (
    .clk(clk),
    .reset(reset),
    .en(en),
    .q(q),
    .z(z)
  );

  SimpleToggleAssertion u_assert(
    .clk(clk),
    .reset(reset),
    .en(en),
    .q(q),
    .z(z)
  );

  SimpleToggleHardwareAssertionp1 u_hw_assert(
    .clk(clk),
    .reset(reset),
    .en(en),
    .q(q),
    .z(z)
  );
  SimpleToggleHardwareAssertionp2 u_hw_assert2(
    .clk(clk),
    .reset(reset),
    .en(en),
    .q(q),
    .z(z)
  );
  SimpleToggleHardwareAssertionp2Shift u_hw_assert2shift(
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
  // Stimulus
    initial begin
        reset = 0; en = 0;
        @(posedge clk); // wait 1 clock
        @(posedge clk); reset = 1;  // release reset
        repeat (4) begin
          @(posedge clk);
        end
        reset = 0;
        repeat (4) begin
           @(posedge clk);
        end
        repeat (8) begin
            @(posedge clk); en = 1;   // enable toggle
            @(posedge clk); en = 0;   // disable toggle
        end
        $finish;
    end
endmodule