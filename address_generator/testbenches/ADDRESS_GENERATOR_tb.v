// Testbench for ADDRESS GENERATOR module

module test;
   // Parameters for UUT module
   parameter DATA_WIDTH = 8;
   parameter COUNT_FROM = 12;

   // Regs for passing input to UUT
   reg clk;
   reg en;
   reg reset;

   // For output UUT
   wire [DATA_WIDTH-1: 0] out;

   ADDRESS_GENERATOR #(DATA_WIDTH, COUNT_FROM) AG (
      .clk(clk),
      .en(en),
      .reset(reset),
      .out(out)
   );

   // Generating clock
   always #5 clk = ~clk;

   initial begin
      $dumpfile("dumpfile.vcd");
      $dumpvars(1, test);

      // Initialize values
      en <= 1;
      reset <= 1;
      clk <= 0;
      repeat(1) @(posedge clk);
      reset <= 0;

      #100 $finish;
   end

   // Priniting output for sanity check
   always @(posedge clk) begin
      #1; $display("Current output: %d", out);
   end

endmodule
