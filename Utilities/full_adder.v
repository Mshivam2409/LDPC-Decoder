// 1-bit full adder

module fulladder(
  input X,
  input Y, 
  input C_in, 

  output S, 
  output C_out
  );

  wire w1,w2,w3;

  // Computing Sum (S)
  xor gate_1(w1, X, Y);
  xor gate_2(S, w1, C_in);

  // Computing Carry (C_out)
  and gate_3(w2, X, Y);
  and gate_4(w3, w1, C_in);
  or gate_5(C_out, w2, w3);

endmodule
