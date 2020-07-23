 //----------------------------------------------------------------------------------
// Design Name : EXT_RAM
// File Name  : EXT_RAM.v
// Function  : Single port Synchronous read and write RAM to store Extrinsic Messages
//-----------------------------------------------------------------------------------

module EXT_RAM 
#(
  parameter DATA_WIDTH = 5 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input  logic                  clk      , // Clock Input
  input  logic [ADDR_WIDTH-1:0] address  , // Address Input
  input  logic                  we       , // Write Enable
  input  logic                  cs       , // Chip select
  input  logic [DATA_WIDTH-1:0] data_in  , // Data Input
  output  wire [DATA_WIDTH-1:0] data_out  // Data Output
);


  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) ext_ram
  (
    .clk      (clk),
    .data_in  (data_in),
    .data_out (data_out),
    .address  (address),
    .we       (we),
    .cs       (cs)
  );

endmodule
