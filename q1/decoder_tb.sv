module decoder_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [15:0] one_hot;

  // Instantiate the decoder module
  decoder uut (
    .binary(binary),
    .one_hot(one_hot)
  );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, uut);

    // Loop through all 16 possible input values
    for (int i = 0; i < 16; i++) begin
      binary = i;
      #5ns;

      if (one_hot === (16'b1 << i)) begin
        $display("PASS: for binary = %b, one_hot = %b", binary, one_hot);
      end else begin
        $display("FAIL: for binary = %b, one_hot = %b (Expected %b)", 
                 binary, one_hot, (16'b1 << i));
      end
    end

    #10ns;
    $display("Test finished.");
    $finish;
  end
endmodule
