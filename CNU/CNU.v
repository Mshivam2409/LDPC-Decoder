// Check Node Unit module

module CNU (
  // 6 input 6-bit data of messages from PE blocks, with leftmost bit for each input is hard decision
  input [6-1 : 0][6-1 : 0] X,

  // Input clock signal
  input clk,

  // Enable port
  input en,

  // 6 output 5-bit data to send to PE blocks
  output [6-1 : 0][5-1 : 0] Y,
  
  // Parity bit
  output p_bit
);

// Intermediate registers for pipelining, starting from left in the diagram
reg [6-1 : 0] sum_regs [0 : 10-1];
reg [6-1 : 0] sign_bits;
reg sign_xor_bit;
reg parity_bit;

// intermediate wires for stage 1
wire [6-1 : 0] wire1, wire2, wire3, wire4, wire5, wire6, wire7, wire8;

// intermediate wires for stage 2
wire [6-1 : 0] wire1_2, wire2_2, wire3_2, wire4_2;


// Create modules for first level of adders in first stage
ripple_adder add1_1(.X({2'b00, X[0][3:0]}), .Y({2'b00, X[1][3:0]}), .S(wire1), .C_out());
ripple_adder add2_1(.X(wire1)             , .Y({2'b00, X[2][3:0]}), .S(wire2), .C_out());
ripple_adder add3_1(.X(wire2)             , .Y({2'b00, X[3][3:0]}), .S(wire3), .C_out());
ripple_adder add4_1(.X(wire3)             , .Y({2'b00, X[4][3:0]}), .S(wire4), .C_out());


// Create modules for second level of adders in first stage
ripple_adder add5_1(.X({2'b00, X[5][3:0]}), .Y({2'b00, X[4][3:0]}), .S(wire5), .C_out());
ripple_adder add6_1(.X(wire5)             , .Y({2'b00, X[3][3:0]}), .S(wire6), .C_out());
ripple_adder add7_1(.X(wire6)             , .Y({2'b00, X[2][3:0]}), .S(wire7), .C_out());
ripple_adder add8_1(.X(wire7)             , .Y({2'b00, X[1][3:0]}), .S(wire8), .C_out());


// Create modules for adders in second stage
ripple_adder add1_2(.X(sum_regs[1]), .Y(sum_regs[2]), .S(wire1_2), .C_out());
ripple_adder add2_2(.X(sum_regs[3]), .Y(sum_regs[4]), .S(wire2_2), .C_out());
ripple_adder add3_2(.X(sum_regs[5]), .Y(sum_regs[6]), .S(wire3_2), .C_out());
ripple_adder add4_2(.X(sum_regs[7]), .Y(sum_regs[8]), .S(wire4_2), .C_out());


// Create modules for LUT
LUT lut_1(.X(sum_regs[0]), .Y(Y[0][3:0]));
LUT lut_2(.X(wire1_2)    , .Y(Y[1][3:0]));
LUT lut_3(.X(wire2_2)    , .Y(Y[2][3:0]));
LUT lut_4(.X(wire3_2)    , .Y(Y[3][3:0]));
LUT lut_5(.X(wire4_2)    , .Y(Y[4][3:0]));
LUT lut_6(.X(sum_regs[9]), .Y(Y[5][3:0]));


always @(posedge clk) begin

  if(en == 1'b1) begin
    // First stage
    sign_bits    <= {X[0][4], X[1][4], X[2][4], X[3][4], X[4][4], X[5][4]};
    parity_bit   <= X[0][5] ^ X[1][5] ^ X[2][5] ^ X[3][5] ^ X[4][5] ^ X[5][5];
    sign_xor_bit <= X[0][4] ^ X[1][4] ^ X[2][4] ^ X[3][4] ^ X[4][4] ^ X[5][4];
    sum_regs[0]  <= wire8; 
    sum_regs[1]  <= {2'b00, X[0][3:0]};
    sum_regs[2]  <= wire7;
    sum_regs[3]  <= wire1;
    sum_regs[4]  <= wire6;
    sum_regs[5]  <= wire2; 
    sum_regs[6]  <= wire5;
    sum_regs[7]  <= wire3;
    sum_regs[8]  <= {2'b00, X[5][3:0]};
    sum_regs[9]  <= wire4;
  end

end


assign p_bit   = parity_bit;
assign Y[0][4] = sign_xor_bit ^ sign_bits[0];
assign Y[1][4] = sign_xor_bit ^ sign_bits[1];
assign Y[2][4] = sign_xor_bit ^ sign_bits[2];
assign Y[3][4] = sign_xor_bit ^ sign_bits[3];
assign Y[4][4] = sign_xor_bit ^ sign_bits[4];
assign Y[5][4] = sign_xor_bit ^ sign_bits[5];

endmodule