//-----------------------------------------------------
// Design Name : EXT_RAM
// File Name   : EXT_RAM.v
// Function    : Implementation of EXT_RAM
//-----------------------------------------------------

module EXT_RAM #(
    parameter DATA_WIDTH = 8 ,
    parameter ADDR_WIDTH = 8 ,
    parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
    clk      , // Clock Input
    address  , // Address Input
    data_in  , // Data Input
    data_out , // Data Output
    we       , // Write Enable
    cs       , // Chip select
);

//--------------Input Ports-----------------------
input                  clk      ;
input                  cs       ;
input [ADDR_WIDTH-1:0] address  ;
input                  we       ;
input [DATA_WIDTH-1:0] data_in  ;

//--------------Output ports----------------------
output [DATA_WIDTH-1:0] data_out;

// Use generic RAM module
RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) ram (
    .clk(clk),
    .address(address),
    .data_in(data_in),
    .we(we),
    .data_out(data_out),
    .cs(cs)
);

endmodule
