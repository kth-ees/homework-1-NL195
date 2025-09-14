// signed_multiplier_tb.sv
module signed_multiplier_tb;

  localparam int N = 5;

  logic signed [N-1:0] x, y;
  logic signed [2*N-1:0] m;

  signed_multiplier #(.N(N)) uut (
    .x(x),
    .y(y),
    .m(m)
  );

  initial begin
    automatic int errors = 0;
    logic signed [2*N-1:0] expected_product;

    $dumpfile("signed_waveform.vcd");
    $dumpvars(0, uut);

    for (int i = 0; i < 2**N; i++) begin
      for (int j = 0; j < 2**N; j++) begin
        x = i;
        y = j;

        expected_product = x * y;

        #5ns; 

        if (m === expected_product) begin 
          $display("PASS: x = %d, y = %d, product = %d", x, y, m);
        end else begin 
          $display("FAIL: x = %d, y = %d, product = %d, expected = %d", x, y, m, expected_product);
          errors++;
        end
      end
    end

    if (errors == 0)
        $display("SUCCESS! All %d test cases passed.", (1 << (2*N)));
    else
        $display("FAILURE: %0d errors found.", errors);S
    $finish;
  end

endmodule