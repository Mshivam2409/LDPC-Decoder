//testbench for module PI_1_shuffle
/*
here random 6 bit number is sent as input whose value is then compared with the output
which is connected to that input according to the condition of Pi 1 shuffle
relation between a connected input_index and output_index is : input_index= (6*output_index)%35 
for example: input[6]==output[(6*6)%35=1]
NOTE: input[35]=output[35]
*/
module pi_1_shuffle_tb;
  reg [6-1 : 0] data_in [0 : 35];
  reg [6-1 : 0] data_out [0 : 35];
  reg [6-1 : 0] temp [0:35];
  
  PI_1_shuffle#(6) test(  //parameter DATA_WIDTH is 6
    .data_in(data_in),
    .data_out(data_out));
  
    initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1, test);
    
      for(int i=0;i<36;i++)begin
        data_in[i]=$random%(1<<6); //random 6-bit number is sent as input
        temp[i]=data_in[i];        //random number is stored at index same as that of input
      end
      
      #10;
      //compare output at index 0
      if(data_out[0]!=temp[0]) begin
        $display("data_in[0] not shuffled correctly");
          #10 $finish;
        end      
       
      //compare output from indices 1 to 34 (both included)
      for(int i=1;i<35;i++)begin
        if(data_out[i]!=temp[(6*i)%35]) begin                    //compare with index found according  
          $display("data_in[%d] not shuffled correctly",i);//to condition mentioned in the header
          #10 $finish;
        end
      end
      
      //compare at index 35
      if(data_out[35]!=temp[35]) begin
        $display("data_in[35] not shuffled correctly");
          #10 $finish;
        end
 
      
        $display("All tests passed.");
        #10 $finish;
      end
endmodule
