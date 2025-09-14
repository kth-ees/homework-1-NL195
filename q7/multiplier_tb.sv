module multiplier_tb;

  localparam N = 5;

  logic [N-1:0] x, y;
  logic [2*N-1:0] m;
  logic [2*N-1:0] expected_product;

  multiplier #(.N(N)) uut(
    .x(x),
    .y(y),
    .m(m)
  );

  initial begin
    automatic int errors = 0;
    
    $dumpfile("waveform.vcd");
    $dumpvars(0, uut);

    for(int i; i < 2**N; i++) begin
      for(int j; j < 2**N; j++) begin
        x = i;
        y = j;
        expected_product = x * y;
        #5ns;

        if(m == expected_product) begin 
          $display("PASS: x = %d, y = %d, product = %d", x, y, m);
        end else begin 
          $display("FAIL: x = %d, y = %d, product = %d, expected = %d", x, y, m, expected_product);
          errors++;
        end
      end
    end
    $display("Tests completed with %d errors.", errors);
    $finish;
  end

endmodule
