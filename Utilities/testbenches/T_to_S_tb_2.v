// testbench for module T_to_S
module T_to_S_tb;
  
    parameter DATA_WIDTH = 6;
  
    reg [DATA_WIDTH-1 : 0] in;
    wire [DATA_WIDTH : 0] out;
  
  reg [DATA_WIDTH-1 : 0] temp;  


  T_to_S # (DATA_WIDTH) test (
      .inp(in),
      .out(out)
    );

    initial begin
      $dumpfile("dump.vcd"); 
      $dumpvars;

      for(int i=0; i<(1<<DATA_WIDTH); ++i) begin   //all possible inputs of length DATA_WIDTH
            in = i;
        $display("input = %b", i[DATA_WIDTH-1:0]);
            #10;
        if(i<=31)begin                                                    // positive input 
          if(out!=in)begin                                                // output same as input
              $display("FAILED at input = %b",in);
              #10 $finish;
            end
          end
          else begin                                                      //negative input
            temp=-in;
            if((out[DATA_WIDTH-1:0]!=temp) || (out[DATA_WIDTH]!=1))begin  //check that first bit is one and the rest is the negative of the input
              $display("FAILED at input = %b",in);
              #10 $finish;              
            end
          end
              $display("output = %b", out);
        end

          $display("ALL tests passed.");
        #10 $finish;
    end
endmodule
