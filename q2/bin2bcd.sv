module bin2bcd (
  input logic [3:0] binary,
  output logic [3:0] bcd,
  output logic carry
);

always_comb begin
  // Default statement to avoid latches
  {carry, bcd} = 5'b0;

  case(binary)
  4'b0000: {carry, bcd} = 5'b00000; 
  4'b0001: {carry, bcd} = 5'b00001;
  4'b0010: {carry, bcd} = 5'b00010;
  4'b0011: {carry, bcd} = 5'b00011;
  4'b0100: {carry, bcd} = 5'b00100; 
  4'b0101: {carry, bcd} = 5'b00101;
  4'b0110: {carry, bcd} = 5'b00110;
  4'b0111: {carry, bcd} = 5'b00111;
  4'b1000: {carry, bcd} = 5'b01000; 
  4'b1001: {carry, bcd} = 5'b01001;
  4'b1010: {carry, bcd} = 5'b10000; 
  4'b1011: {carry, bcd} = 5'b10001;
  4'b1100: {carry, bcd} = 5'b10010; 
  4'b1101: {carry, bcd} = 5'b10011;
  4'b1110: {carry, bcd} = 5'b10100;
  4'b1111: {carry, bcd} = 5'b10101; 
  endcase
end


endmodule