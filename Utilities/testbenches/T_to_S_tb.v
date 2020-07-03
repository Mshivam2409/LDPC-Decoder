// Testbench for Utilities
module test;

    parameter DATA_WIDTH = 6;

    //reg clk;
    reg [DATA_WIDTH-1 : 0] inp;
    reg signed [DATA_WIDTH : 0] out;

    // Instantiating module to be tested
    T_to_S # (DATA_WIDTH) uut (
      .inp(inp),
      .out(out)
    );


    // For sanity checking
    reg [DATA_WIDTH: 0] i;
    initial begin

        // Writing data into the RAM module to be tested
        for(i=0; i<(1<<DATA_WIDTH); ++i) begin
            inp = i[DATA_WIDTH-1:0];
            $display("data sent: %b", i[DATA_WIDTH-1:0]);
            #1;
            $display("data received: %b", out);
        end

        $display("Sanity checks completed");
        #10 $finish;
    end
endmodule
