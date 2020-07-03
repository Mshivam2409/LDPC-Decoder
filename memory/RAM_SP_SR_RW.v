//-----------------------------------------------------
// Design Name : RAM_SP_SR_RW
// File Name   : RAM_SP_SR_RW.v
// Function    : Single port Synchronous read and write RAM
//-----------------------------------------------------
module RAM_SP_SR_RW #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8,
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

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

//--------------Code Starts Here------------------ 

// Memory Write Block 
always @ (posedge clk) begin
    if (cs && we) begin
        mem[address] <= data_in;
    end
end

// Memory Read Block 
always @ (posedge clk) begin
    if (cs && !we) begin
        data_out <= mem[address];
    end
end

endmodule
