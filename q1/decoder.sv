module decoder (
  input logic [3:0] binary,
  output logic [15:0] one_hot
);
    always_comb begin
        one_hot = 16'b0; // Initialize all bits to 0
        if (binary < 16) begin
            one_hot[binary] = 1'b1; // Set the corresponding bit to 1
        end
    end

endmodule
