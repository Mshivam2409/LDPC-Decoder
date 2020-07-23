//----------------------------------------------------------------------------------
// Design Name : LDPC_Decoder
// File Name   : Decoder.v
// Function    : LDPC Decoder for 
//-----------------------------------------------------------------------------------

`include "permutations/PI_1_shuffle.v"
`include "permutations/PI_1_unshuffle.v"
`include "permutations/PI_2_shuffle.v"
`include "permutations/PI_2_unshuffle.v"
`include "permutations/PI_3_shuffle.v"
`include "permutations/PI_3_unshuffle.v"

`include "Utilities/full_adder.v"
`include "Utilities/6-bit-ripple_carry_adder.v"
`include "Utilities/LUT.v"
`include "Utilities/S_to_T.v"
`include "Utilities/T_to_S.v"

`include "CNU/CNU.v"
`include "VNU/VNU.v"

`include "PE_block/PE_block.v"
`include "memory/INT_RAM.v"
`include "memory/EXT_RAM.v"
`include "memory/DEC_RAM.v"
`include "memory/RAM_SP_SR_RW.v"
`include "address_generator/ADDRESS_GENERATOR.v"


module LDPC_Decoder
#(
  parameter L = 32,
  parameter ADDR_WIDTH = 5,    // log2L
  parameter MESSAGE_WIDTH = 5,
  parameter K = 6,
  parameter CNU_DATA_IN_WIDTH  = 6,
  parameter CNU_DATA_OUT_WIDTH = 5,
  parameter INTRINSIC_DATA_WIDTH = 5
)
(
  input clk,
  input clk_df,
  input en,      // enable pin
  output wire f_id,
  output wire relay,

  input logic [K-1:0] column_select,
  input [(K*K)-1:0] pe_select,       // Will be used in column major order
  input [MESSAGE_WIDTH-1:0] int_in,
  input [ADDR_WIDTH-1:0] load_add_in,
  input [ADDR_WIDTH-1:0] read_add_in,

  output [K-1:0] dec_out_fin [K-1:0]
);

parameter RAM_DEPTH =1<<ADDR_WIDTH ;


// Wires for Data I/O at PE bloks
wire [ADDR_WIDTH-1:0]    load_add_out [((K+1)*K)-1:0];  // Will be used in row major order
wire [MESSAGE_WIDTH-1:0] int_out      [((K+1)*K)-1:0];  // Will be used in row major order

wire [ADDR_WIDTH-1:0]    read_add_out [((K+1)*K)-1:0];  // Will be used in col major order
wire [K-1:0]             dec_out      [((K+1)*K)-1:0];  // Will be used in col major order

generate
  genvar x,y;

  for(y=0; y<K; y=y+1) begin
    // Assign first row of load addresses and intrinsic data
    assign load_add_out[y] = load_add_in;
    assign int_out[y] = int_in;
  end

  for(x=0; x<K; x=x+1) begin
    // Assign first column of read addresses and decoded data
    assign read_add_out[x] = read_add_in;
    assign dec_out[x] = {K{1'b0}};
  end

  for(x=0; x<K; x=x+1) begin
    // Assign last column of decoded data to dec_out_fin
    assign dec_out_fin[x] = dec_out[K*K + x];
  end

endgenerate

// Wires and regs for CNU procesing
wire [CNU_DATA_IN_WIDTH-1:0] PE_out_cnu[0:2][0:(K*K)-1];
wire en_cnu[0:(K*K)-1];
reg [CNU_DATA_OUT_WIDTH-1:0] PE_in_cnu[0:2][0:(K*K)-1];

reg [CNU_DATA_IN_WIDTH-1:0] PI_1_shuffle_in[0:(K*K)-1];
reg [CNU_DATA_IN_WIDTH-1:0] PI_2_shuffle_in[0:(K*K)-1];
reg [CNU_DATA_IN_WIDTH-1:0] PI_3_shuffle_in[0:(K*K)-1];

wire [CNU_DATA_IN_WIDTH-1:0] PI_1_shuffle_out[0:(K*K)-1];
wire [CNU_DATA_IN_WIDTH-1:0] PI_2_shuffle_out[0:(K*K)-1];
wire [CNU_DATA_IN_WIDTH-1:0] PI_3_shuffle_out[0:(K*K)-1];

reg PI_1_shuffle_en_cnu_in[0: (K*K)-1];
reg PI_2_shuffle_en_cnu_in[0: (K*K)-1];
reg PI_3_shuffle_en_cnu_in[0: (K*K)-1];

wire PI_1_shuffle_en_cnu_out[0:(K*K)-1];  // permuted enable bits for CNU 1,j
wire PI_2_shuffle_en_cnu_out[0:(K*K)-1];  // permuted enable bits for CNU 1,j
wire PI_3_shuffle_en_cnu_out[0:(K*K)-1];  // permuted enable bits for CNU 1,j

reg [CNU_DATA_IN_WIDTH-1:0][0:K-1] CNU_1_in[0:K-1];
reg [CNU_DATA_IN_WIDTH-1:0][0:K-1] CNU_2_in[0:K-1];
reg [CNU_DATA_IN_WIDTH-1:0][0:K-1] CNU_3_in[0:K-1];

reg CNU_1_en[0:K-1];
reg CNU_2_en[0:K-1];
reg CNU_3_en[0:K-1];

reg [CNU_DATA_OUT_WIDTH-1:0][0:K-1] CNU_1_out[0:K-1];
reg [CNU_DATA_OUT_WIDTH-1:0][0:K-1] CNU_2_out[0:K-1];
reg [CNU_DATA_OUT_WIDTH-1:0][0:K-1] CNU_3_out[0:K-1];

reg [CNU_DATA_OUT_WIDTH-1:0] PI_1_unshuffle_in[0:(K*K)-1];
reg [CNU_DATA_OUT_WIDTH-1:0] PI_2_unshuffle_in[0:(K*K)-1];
reg [CNU_DATA_OUT_WIDTH-1:0] PI_3_unshuffle_in[0:(K*K)-1];

wire [CNU_DATA_OUT_WIDTH-1:0] PI_1_unshuffle_out[0:(K*K)-1];
wire [CNU_DATA_OUT_WIDTH-1:0] PI_2_unshuffle_out[0:(K*K)-1];
wire [CNU_DATA_OUT_WIDTH-1:0] PI_3_unshuffle_out[0:(K*K)-1];

reg [3*K] p_bit;  // parity bits from all cnu's

wire temp_f_id;
wire temp_relay;

assign relay=temp_relay;

assign f_id=temp_f_id;

// CNU 1,j
PI_1_shuffle #(.DATA_WIDTH(CNU_DATA_IN_WIDTH)) pi_1_shuffle (.data_in(PI_1_shuffle_in), .data_out(PI_1_shuffle_out));
PI_1_shuffle #(.DATA_WIDTH(1)) pi_1_shuffle_en (.data_in(PI_1_shuffle_en_cnu_in), .data_out(PI_1_shuffle_en_cnu_out));

generate
  genvar i;
  for(i=0; i<K; i=i+1) begin
    CNU cnu
    (
      .clk(clk),
      .X(CNU_1_in[i]),
      .en(CNU_1_en[i]),
      .Y(CNU_1_out[i]),
      .p_bit()
    );
  end
endgenerate

PI_1_unshuffle #(.DATA_WIDTH(CNU_DATA_OUT_WIDTH)) pi_1_unshuffle (.data_in(PI_1_unshuffle_in), .data_out(PI_1_unshuffle_out));


// CNU 2,j
PI_2_shuffle #(.DATA_WIDTH(CNU_DATA_IN_WIDTH)) pi_2_shuffle (.data_in(PI_2_shuffle_in), .data_out(PI_2_shuffle_out));
PI_2_shuffle #(.DATA_WIDTH(1)) pi_2_shuffle_en (.data_in(PI_2_shuffle_en_cnu_in), .data_out(PI_2_shuffle_en_cnu_out));

generate
  for(i=0; i<K; i=i+1) begin
    CNU cnu
    (
      .clk(clk),
      .X(CNU_2_in[i]),
      .en(CNU_2_en[i]),
      .Y(CNU_2_out[i]),
      .p_bit()
    );
  end
endgenerate

PI_2_unshuffle #(.DATA_WIDTH(CNU_DATA_OUT_WIDTH)) pi_2_unshuffle (.data_in(PI_2_unshuffle_in), .data_out(PI_2_unshuffle_out));


// CNU 3,j
PI_3_shuffle #(.DATA_WIDTH(CNU_DATA_IN_WIDTH)) pi_3_shuffle (.data_in(PI_3_shuffle_in), .clk(clk), .reset(~(CNU_3_en[0] | CNU_3_en[1] | CNU_3_en[2] | CNU_3_en[3] | CNU_3_en[4] | CNU_3_en[5])), .data_out(PI_3_shuffle_out));
PI_3_shuffle #(.DATA_WIDTH(1)) pi_3_shuffle_en (.data_in(PI_3_shuffle_en_cnu_in), .clk(clk), .reset(~(CNU_3_en[0] | CNU_3_en[1] | CNU_3_en[2] | CNU_3_en[3] | CNU_3_en[4] | CNU_3_en[5])), .data_out(PI_3_shuffle_en_cnu_out));

generate
  for(i=0; i<K; i=i+1) begin
    CNU cnu
    (
      .clk(clk),
      .X(CNU_3_in[i]),
      .en(CNU_3_en[i]),
      .Y(CNU_3_out[i]),
      .p_bit()
    );
  end
endgenerate

PI_3_unshuffle #(.DATA_WIDTH(CNU_DATA_OUT_WIDTH)) pi_3_unshuffle (.data_in(PI_3_unshuffle_in), .clk(clk), .reset(~(CNU_3_en[0] | CNU_3_en[1] | CNU_3_en[2] | CNU_3_en[3] | CNU_3_en[4] | CNU_3_en[5])), .data_out(PI_3_unshuffle_out));



// Generating PE_blocks modules
generate
  genvar j;

  genvar read_add_prev, read_add_in_curr;
  genvar load_add_prev, load_add_in_curr;

  // Generating first row of PE_blocks
  for(i=0; i<K; i=i+1) begin
    for(j=0; j<K; j=j+1) begin
      // (i, j) PE_block with i and j being 0-indexed
      PE_BLOCK #(.X(i+1), .Y(j+1), .K(K), .L(L),
                 .COUNT_FROM_1(0), .COUNT_FROM_2((i*(j+1))%L), .COUNT_FROM_3(((i+1)*(j+2))%L)) pe_block
      (
        .enable(en),
        .clk(clk),
        .clk_df(clk_df),
        .f_id(temp_f_id),
        .pe_select(pe_select[i + j*K]),
        .column_select(column_select[j]),
        .relay(temp_relay),

        .read_add_in(read_add_out[i + K*j]),
        .read_add_out(read_add_out[i + K*(j+1)]),

        .load_add_in(load_add_out[i*K + j]),
        .load_add_out(load_add_out[(i+1)*K + j]),

        .dec_in(dec_out[i + K*j]),
        .dec_out(dec_out[i + K*(j+1)]),

        .int_in(int_out[i*K + j]),
        .int_out(int_out[(i+1)*K + j]),

        // For sending to Permutation in column major order
        .cnu_data_in({PE_in_cnu[0][i + K*j], PE_in_cnu[1][i + K*j], PE_in_cnu[2][i + K*j]}),
        .enable_cnu(en_cnu[i + K*j]),
        .cnu_data_out({PE_out_cnu[0][i + K*j], PE_out_cnu[1][i + K*j], PE_out_cnu[2][i + K*j]})
      );
    end
  end

endgenerate

integer a,b;

// Check node processing cycle
always @(posedge clk) begin
  // Read -> Shuffle
  for(b=0; b<(K*K); b=b+1) begin
    PI_1_shuffle_in[b] <= PE_out_cnu[0][b];
    PI_2_shuffle_in[b] <= PE_out_cnu[1][b];
    PI_3_shuffle_in[b] <= PE_out_cnu[2][b];

    PI_1_shuffle_en_cnu_in[b] <= en_cnu[b];
    PI_2_shuffle_en_cnu_in[b] <= en_cnu[b];
    PI_3_shuffle_en_cnu_in[b] <= en_cnu[b];
  end


  // Shuffle -> CNU
  a = 0;
  for(b=0; b<(K*K); b=b+K) begin
    CNU_1_in[a] <= {PI_1_shuffle_out[b], PI_1_shuffle_out[b+1], PI_1_shuffle_out[b+2], PI_1_shuffle_out[b+3], PI_1_shuffle_out[b+4], PI_1_shuffle_out[b+5]};
    CNU_2_in[a] <= {PI_2_shuffle_out[b], PI_2_shuffle_out[b+1], PI_2_shuffle_out[b+2], PI_2_shuffle_out[b+3], PI_2_shuffle_out[b+4], PI_2_shuffle_out[b+5]};
    CNU_3_in[a] <= {PI_3_shuffle_out[b], PI_3_shuffle_out[b+1], PI_3_shuffle_out[b+2], PI_3_shuffle_out[b+3], PI_3_shuffle_out[b+4], PI_3_shuffle_out[b+5]};
    
    CNU_1_en[a] <= (PI_1_shuffle_en_cnu_out[b] | PI_1_shuffle_en_cnu_out[b+1] | PI_1_shuffle_en_cnu_out[b+2] | PI_1_shuffle_en_cnu_out[b+3] | PI_1_shuffle_en_cnu_out[b+4] | PI_1_shuffle_en_cnu_out[b+5]);
    CNU_2_en[a] <= (PI_2_shuffle_en_cnu_out[b] | PI_2_shuffle_en_cnu_out[b+1] | PI_2_shuffle_en_cnu_out[b+2] | PI_2_shuffle_en_cnu_out[b+3] | PI_2_shuffle_en_cnu_out[b+4] | PI_2_shuffle_en_cnu_out[b+5]);
    CNU_3_en[a] <= (PI_3_shuffle_en_cnu_out[b] | PI_3_shuffle_en_cnu_out[b+1] | PI_3_shuffle_en_cnu_out[b+2] | PI_3_shuffle_en_cnu_out[b+3] | PI_3_shuffle_en_cnu_out[b+4] | PI_3_shuffle_en_cnu_out[b+5]);
    
    a=a+1;
  end


  // CNU -> Unshuffle
  for(b=0; b<K; b=b+1) begin
      PI_1_unshuffle_in[b*K] <= CNU_1_out[b];
      PI_2_unshuffle_in[b*K] <= CNU_2_out[b];
      PI_3_unshuffle_in[b*K] <= CNU_3_out[b];

      // PI_1_unshuffle_in <= {CNU_1_out[0], CNU_1_out[1], CNU_1_out[2], CNU_1_out[3], CNU_1_out[4], CNU_1_out[5]};
      // PI_2_unshuffle_in <= {CNU_2_out[0], CNU_2_out[1], CNU_2_out[2], CNU_2_out[3], CNU_2_out[4], CNU_2_out[5]};
      // PI_3_unshuffle_in <= {CNU_3_out[0], CNU_3_out[1], CNU_3_out[2], CNU_3_out[3], CNU_3_out[4], CNU_3_out[5]};
  end

  // Unshuffle -> Write
  for(b=0; b<(K*K); b=b+1) begin
    PE_in_cnu[0][b] <= PI_1_unshuffle_out[b];
    PE_in_cnu[1][b] <= PI_2_unshuffle_out[b];
    PE_in_cnu[2][b] <= PI_3_unshuffle_out[b];
  end

end


endmodule : LDPC_Decoder
