 //-----------------------------------------------------
// Design Name : RAM_SP_SR_RW
// File Name  : RAM_SP_SR_RW.v
// Function  : Single port Synchronous read and write RAM
//-----------------------------------------------------
module RAM_SP_SR_RW 
#(
  parameter DATA_WIDTH = 8 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input  logic                  clk   , // Clock Input
  input  logic [ADDR_WIDTH-1:0] address , // Address Input
  input  logic [DATA_WIDTH-1:0] data_in , // Data Input
  output logic [DATA_WIDTH-1:0] data_out , // Data Output
  input  logic                  we    , // Write Enable
  input  logic                  cs     // Chip select
);

  //This defines a memory bank of size RAM_DEPTH storing word of size DATA_WIDTH
  logic [DATA_WIDTH-1:0] ram_mem [0:RAM_DEPTH-1] ;


  //------------------------------------------------------
  // Data Write
  //------------------------------------------------------
  always @( posedge clk) begin
    
    if(we && cs) begin
        ram_mem[address]<=data_in;
    end

  end
  
  
  //-------------------------------------------------------
  //Data Read
  //-------------------------------------------------------
  always @( posedge clk) begin
    
    if(!we && cs) begin
        data_out=ram_mem[address];
    end

  end

endmodule
