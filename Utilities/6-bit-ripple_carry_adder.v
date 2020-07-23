// 6-bit ripple-carry adder

module ripple_adder(
  input [5:0] X,
  input [5:0] Y,

  output [5:0] S,
  output C_out
  );

 wire w1, w2, w3, w4, w5;

 fulladder u1(X[0], Y[0], 1'b0, S[0], w1);
 fulladder u2(X[1], Y[1], w1, S[1], w2);
 fulladder u3(X[2], Y[2], w2, S[2], w3);
 fulladder u4(X[3], Y[3], w3, S[3], w4);
 fulladder u5(X[4], Y[4], w4, S[4], w5);
 fulladder u6(X[5], Y[5], w5, S[5], C_out);

endmodule