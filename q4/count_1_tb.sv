module count_1_tb;

  // Inputs
  logic [3:0] a;

  // Outputs
  logic [2:0] out;

  count_1 uut(
    .a(a),
    .out(out)
  );

  initial begin
    int out_tmp;

    $dumpfile("waveform.vcd");
    $dumpvars(0, uut);

    for (int i; i<16; i++) begin
      a = i;
      #5ns;

      if (out == a[3] + a[2] + a[1] + a[0]) begin
        $display("PASSED for a = %b, out = %b", a, out);
      end else begin
        out_tmp = a[3] + a[2] + a[1] + a[0];
        $display("FAILED for a = %b, out = %b, EXPECTED out = %b",
                  a, out, out_tmp);
      end
    end
    $finish;
  end

endmodule
