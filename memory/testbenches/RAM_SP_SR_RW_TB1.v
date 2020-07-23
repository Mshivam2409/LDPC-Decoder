//---------------------------------------------
// Test Bench #1 for RAM_SP_SR_RW
// This Test-Bench firstly initializes the RAM
// with data and then randomly reads data 
//---------------------------------------------

`include "../RAM_SP_SR_RW.v"

module RAM_SP_SR_RW_TB1
#(
  parameter DATA_WIDTH = 8 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
);

  logic                  clk ;     // Clock
  logic [DATA_WIDTH-1:0] data_in ;    // Data Input 
  logic [ADDR_WIDTH-1:0] address ; // Address 
  logic [DATA_WIDTH-1:0] data_out ; // Data Output
  logic                  we ; // Write Enable
  logic                  cs ; // Chip select
  integer                i ; // loop variable
  integer                seed; // seed for random 

  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) ram
  (
    .clk      (clk),
    .data_in  (data_in),
    .data_out (data_out),
    .address  (address),
    .we       (we),
    .cs       (cs)
  );



  //-----------------------------------
  // Clock generation
  //-----------------------------------
  initial begin
    clk=0;
  end

  always begin 
    #5 clk= ~clk;
  end



  //-----------------------------------
  // Dump waveform
  //-----------------------------------
  initial begin
    $dumpfile("RAM_SP_SR_RW_TB1.vcd");
    $dumpvars;
  end



  //-----------------------------------
  // Initialize RAM with Data
  //-----------------------------------
  initial begin
    seed=1;
    #3 for(i=0;i<RAM_DEPTH;i++) begin
      data_in=i;
      address=i;
      we=1; cs=1;
      #10 we=0; cs=0;
    end    

    repeat(20) begin
      repeat(1) @(posedge clk);
      address=$random(seed) % RAM_DEPTH;
      we=0;
      cs=1;

      #2 if(data_out==address) begin
      $display("Correct \t Address:%d\tData:%d\t",address,data_out);
      end
      else begin
      $display("Incorrect \t Address:%d\tData:%d\t",address,data_out);
      end
    end

    #5 $finish;

  end


endmodule
