// Parameterized Address Generator Module

module ADDRESS_GENERATOR #(
      //==============================
      // Top level block parameters
      //==============================
      parameter DATA_WIDTH   = 8,                 // number of bits in counter
      parameter COUNT_FROM   = 0                 // start with this number
      )
      (
      //===============
      // Input Ports
      //===============
      input clk,   // clock input
      input en,    // enable
      input reset, // reset

      //===============
      // Output Ports
      //===============
      output reg [DATA_WIDTH-1:0] out
   );

   // Synchronous logic
   always @(posedge clk && en) begin
      if (reset) begin
         out <= COUNT_FROM;
      end
      else begin
         out <= out + 1;
      end
   end
endmodule
