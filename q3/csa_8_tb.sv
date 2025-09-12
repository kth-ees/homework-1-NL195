module csa_8_tb;

  // Inputs
  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] sum;
  logic carry;

csa_8 uut(
  .a(a),
  .b(b),
  .sum(sum),
  .carry(carry)
);

initial begin
  int total;

  $dumpfile("waveform.vcd");
  $dumpvars(0, uut);

  for(int i; i<2**8; i++) begin
    a = i;
    for(int j; j<2**8; j++) begin
      b = j;

      #5ns;

      if ({carry, sum} == (a + b)) begin
        continue;
      end else begin
        total = a + b;
        $display("FAILED: a = %b, b = %b, carry = %b, sum = %b, EXPECTED: carry = %b, sum = %b", 
                  a, b, carry, sum, total[8], total[7:0]);
      end
    end
  end
  $display("Test complete. If no FAILED message, all tests passed.");
  $finish;      

end
  
endmodule
