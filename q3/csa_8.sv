module csa_8 (
  input logic [7:0] a, b,
  output logic [7:0] sum,
  output logic carry
);

logic c0, c1, c2;
logic [3:0] s0, s1, s2;

adder_4 adder0(
  .A(a[3:0]),
  .B(b[3:0]),
  .sum(s0),
  .carry(c0)
  );

adder_4 adder1(
  .A(a[7:4]),
  .B(b[7:4]),
  .sum(s1),
  .carry(c1)
);

assign {c2, s2} = a[7:4] + b[7:4] + 1;

assign sum[3:0] = s0;
assign sum[7:4] = c0 ? s2 : s1;
assign carry = c0 ? c2 : c1;


endmodule
