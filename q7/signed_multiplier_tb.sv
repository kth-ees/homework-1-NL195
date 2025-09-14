// signed_multiplier_tb.sv
module signed_multiplier_tb;

  localparam int N = 4;

  // --- Signals ---
  // Inputs and outputs are declared 'signed'
  logic signed [N-1:0] x, y;
  logic signed [2*N-1:0] m;

  // --- DUT Instantiation ---
  // Instantiate the top-level SIGNED multiplier
  signed_multiplier #(.N(N)) uut (
    .x(x),
    .y(y),
    .m(m)
  );

  // --- Test Logic ---
  initial begin
    automatic int errors = 0;
    logic signed [2*N-1:0] expected_product;

    $dumpfile("signed_waveform.vcd");
    $dumpvars(0, uut);

    // Loop through all 2^N possible bit patterns for each input
    for (int i = 0; i < (1 << N); i++) begin
      for (int j = 0; j < (1 << N); j++) begin
        // Assign the bit patterns to the signed inputs
        x = i;
        y = j;

        // The simulator performs signed multiplication because x and y are signed
        expected_product = x * y;

        #5ns; // Wait for the combinational logic to settle

        if (m === expected_product) begin 
          $display("PASS: x = %d, y = %d, product = %d", x, y, m);
        end else begin 
          $display("FAIL: x = %d, y = %d, product = %d, expected = %d", x, y, m, expected_product);
          errors++;
        end
      end
    end

    if (errors == 0)
        $display("SUCCESS! All 256 test cases passed.");
    else
        $display("FAILURE: %0d errors found.", errors);
    $finish;
  end

endmodule