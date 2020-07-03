 //----------------------------------------------------------------------------------
// Design Name : INT_RAM
// File Name  : INT_RAM.v
// Function  : Single port Synchronous read and write RAMs to store Intrinsic Messages
//-----------------------------------------------------------------------------------

module INT_RAM 
#(
  parameter DATA_WIDTH = 5 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input  logic                  clk            , // Clock Input
  input  wire [ADDR_WIDTH-1:0] address  [0:1]  , // Address Input
  input  wire [DATA_WIDTH-1:0] data_in  [0:1] , // Data Input
  output wire  [DATA_WIDTH-1:0] data_out [0:1] , // Data Output
  input  logic                  we       [0:1] , // Write Enable
  input  logic                  cs       [0:1] , // Chip select
  input  logic                  rs               // RAM Select
);
  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_1
  (
    .clk      (clk),
    .data_in  (data_in  [0]),
    .data_out (data_out [0]),
    .address  (address  [0]),
    .we       (we       [0]),
    .cs       (cs       [0])
  );
  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_2
  (
    .clk      (clk),
    .data_in  (data_in  [1]),
    .data_out (data_out [1]),
    .address  (address  [1]),
    .we       (we       [1]),
    .cs       (cs       [1])
  );
endmodule
