// Testbench for LDPC_Decoder module
`include "Decoder.v"

module Decoder_tb ();
  parameter L = 32;
  parameter K = 6;
  parameter DATA_COUNT = 1152;     // L*K*K
  parameter ADDR_WIDTH = 5;    // log2L
  parameter MESSAGE_WIDTH = 5;
  parameter CNU_DATA_IN_WIDTH  = 6;
  parameter CNU_DATA_OUT_WIDTH = 5;
  parameter INTRINSIC_DATA_WIDTH = 5;


  string inp_file_name = "inp.txt";
  string out_file_name = "out.txt";
  integer code_frames = 3;
  integer scan_faults;
  integer count=0;
  integer flag;

  integer inp_fd;
  integer out_fd;

  logic clk;
  logic clk_df;
  logic en;
  logic f_id;
  logic prev_f_id;
  logic relay;
  logic [K-1:0] column_select;
  logic [(K*K)-1:0] pe_select;
  logic [MESSAGE_WIDTH-1:0] int_in;
  logic [ADDR_WIDTH-1:0] load_add_in;
  logic [ADDR_WIDTH-1:0] read_add_in;
  logic [K-1:0] dec_out_fin [K-1:0];
  logic [(L*K*K)-1:0] hard_dec;

  reg [5-1:0] curr_data;
  reg [5-1:0] int_data[0:(L*K*K)-1];
  reg [(L*K*K)-1:0] out_data;

  LDPC_Decoder #(.L(L), 
                 .ADDR_WIDTH(ADDR_WIDTH), 
                 .MESSAGE_WIDTH(MESSAGE_WIDTH), 
                 .K(K),
                 .CNU_DATA_IN_WIDTH(CNU_DATA_IN_WIDTH),
                 .CNU_DATA_OUT_WIDTH(CNU_DATA_OUT_WIDTH),
                 .INTRINSIC_DATA_WIDTH(INTRINSIC_DATA_WIDTH)) decoder
  (
  .clk(clk),
  .clk_df(clk_df),
  .en(en),
  .f_id(f_id),
  .column_select(column_select),
  .pe_select(pe_select),
  .int_in(int_in),
  .load_add_in(load_add_in),
  .read_add_in(read_add_in),
  .relay(relay)
  );


  initial begin
    // Taking arguments from the command line
    if ($value$plusargs("FRAMES=%0d", code_frames) | 1'b1) begin 
      $display("Number of frames = %0d", code_frames);
    end

    if ($value$plusargs("INP_FILE=%s", inp_file_name) | 1'b1) begin 
      $display("Input file = %s", inp_file_name);
    end

    if ($value$plusargs("OUT_FILE=%s", out_file_name) | 1'b1) begin 
      $display("Output file = %s", out_file_name);
    end


    // Reading data from input file
    inp_fd = $fopenr(inp_file_name);
    out_fd = $fopen(out_file_name);
    
    en=1'b0;
    @(posedge clk);


    for(int frame=1; frame<=code_frames; frame=frame+1) begin
      $display("\nFrame number: %0d",frame);
      for(int i=0; i<DATA_COUNT; i=i+1) begin
        scan_faults = $fscanf(inp_fd, "%b", int_data[i]);
        //$display("data: %b", int_data[i]);
      end
      en=1'b1;
      prev_f_id=f_id;
      flag=1;
      while(flag) begin
        $display("Count = %d",count);
        //$display("relay = %b",relay);
        //$display("prev_f_id = %b\n",prev_f_id);
        
        @(negedge clk); 
        if((count/L)<(K*K)) begin
          pe_select[count/L]=1'b1;
          int_in=int_data[count];
          load_add_in=count%L;        
        end
        if((count/K)<L) begin
          read_add_in=count/K;
          column_select[count%K]=1'b1;          
        end
      


        @(posedge clk);
        @(posedge clk_df);
        #1;

        if(count%K==(K-1) && (count/K)<L) begin
          for(int x=0; x<K; x=x+1) begin
            for(int y=0; y<K; y=y+1) begin
              hard_dec[L*x + y  ]=dec_out_fin[x][y];
            end
          end
        end

        if(f_id!=prev_f_id) begin
          flag=0;
        end

        count=count+1;

        //(L*K*y)+(L*x)+((count-1)/K)

      end

      
      column_select=6'b0;
      pe_select=36'b0;
      count=0;

      if(frame!=1 && frame!=2 ) begin
        for(int j=0; j<(L*K*K); j=j+1) begin
          $fwrite(out_fd, "%b", hard_dec[j]);
        end
        $fwrite(out_fd, "\n");
      end

      
    
    end

    $fclose(inp_fd);
    $fclose(out_fd);

    $finish;


    // Writing decoded data to file, assumes that the data for current frame is in 

  end

  initial begin
    clk<=0;
    clk_df<=0;
  end
  
  always begin
    #2 clk <= ~clk; 
  end

  always begin
    #1 clk_df <= ~clk_df;
  end


endmodule