module bin2gray_tb;

  // Inputs
  logic [3:0] binary;

  // Outputs
  logic [3:0] gray;

  bin2gray uut(
    .binary(binary),
    .gray(gray)
  );

  initial begin
    logic [3:0] expected_gray;

    for (int i; i<8; i++) begin
      binary = i;
      #5ns;

      expected_gray = binary ^ (binary >> 1);

      if (gray === expected_gray) begin
        $display("PASS: bin=%b, gray=%b", binary, gray);
      end else begin
        $display("FAIL: bin=%b, gray=%b, EXPECTED=%b", binary, gray, expected_gray);
      end
    end
    $finish;
  end

endmodule
