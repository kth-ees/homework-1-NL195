module arithmetic_right_shifter_tb;

  localparam N = 8;

  logic [N-1:0] input_data;
  logic [1:0] control;
  logic [N-1:0] shifted_result;

  arithmetic_right_shifter #(
    .N(N)
  ) uut (
    .input_data(input_data),
    .control(control),
    .shifted_result(shifted_result)
  );

  initial begin

    logic [N-1:0] expected_result;
    int errors;

    $dumpfile("waveform.vcd");
    $dumpvars(0, uut);


    for(int i = 0; i < 4; i++) begin
      control = i;

      for (int j = 0; j < 2**8; j++) begin
        input_data = j;
        #5ns; 

        expected_result = signed'(input_data) >>> control;
        if (shifted_result !== expected_result) begin
          $display("FAIL: data=%b, shift=%d -> out=%b, EXPECTED=%b",
                   input_data, control, shifted_result, expected_result);
          errors++;
        end
      end

      $display("Tests for shift = %d completed.", control);

    end

    $display("All %d tests completed with %d errors.", 4 * (2**8), errors);
    $finish;

  end

endmodule