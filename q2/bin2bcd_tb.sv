module bin2bcd_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [3:0] bcd;
  logic carry;

  bin2bcd uut(
    .binary(binary),
    .bcd(bcd),
    .carry(carry)
  );

  initial begin
    int j;

    $dumpfile("waveform.vcd");
    $dumpvars(0, uut);

    for (int i; i<10; i++) begin
      binary = i;
      #10ns;

      if ((bcd == binary)&&(carry == 1'b0)) begin
        $display("PASS for binary = %b, carry = %b, bcd = %b", binary, carry, bcd);
      end else begin
        $display("FAIL for binary = %b, carry = %b, bcd = %b. EXPECTED: carry = %b, bcd = %b", binary, carry, bcd, 1'b0, binary);
      end
    end

    j = 0;
    for (int i = 10; i<16; i++) begin
      binary = i;
      #10ns;

      if ((bcd == j)&&(carry == 1'b1)) begin
        $display("PASS for binary = %b, carry = %b, bcd = %b", binary, carry, bcd);
      end else begin
        $display("FAIL for binary = %b, carry = %b, bcd = %b. EXPECTED: carry = %b, bcd = %b", binary, carry, bcd, 1'b1, j);
      end
      
      j++;
    end

    $finish;

  end

endmodule
