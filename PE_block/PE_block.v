 //----------------------------------------------------------------------------------
// Design Name : PE_BLOCK
// File Name  : PE_BLOCK.v
// Function  : PE Memory Block for storing all information and performing VNU phase
//-----------------------------------------------------------------------------------

module PE_BLOCK 
#(
  parameter L=32,
  parameter K=6,
  parameter X=1,
  parameter Y=1,
  parameter ADDR_WIDTH=5,
  parameter RAM_DEPTH=1<<ADDR_WIDTH,
  parameter COUNT_FROM_1=0,
  parameter COUNT_FROM_2=0,
  parameter COUNT_FROM_3=0,
  parameter VNU_DELAY=3,
  parameter CNU_DELAY=5,
  parameter MESSAGE_WIDTH=5,
  parameter DECISION_WIDTH=1
)
(
  input  logic                     clk,               //clock
  input  logic                     clk_df,            //clock double frequency

  input  logic                     enable,            //enable pin

  output logic                     enable_cnu,        //CNU enable pin

  output wire                     f_id,              //frame id
  output wire       relay,
  input  logic                     pe_select,         //PE_Block select line    
  
  input logic                      column_select,     //column_select line for reading decoded data

  input  logic [ADDR_WIDTH-1:0]    read_add_in,       //read address input for reading hard decision 
  output logic [ADDR_WIDTH-1:0]    read_add_out,      //read address output for reading hard decision

  input  logic [ADDR_WIDTH-1:0]    load_add_in,       //load address input for storing intrinsic data
  output logic [ADDR_WIDTH-1:0]    load_add_out,      //load address output for storing intrinsic data

  input  logic [K-1:0]             dec_in,            //hard decision input from previous block
  output logic [K-1:0]             dec_out,           //hard decision output to next block

  input  logic [MESSAGE_WIDTH-1:0] int_in,            //intrinsic message input from previous block
  output logic [MESSAGE_WIDTH-1:0] int_out,           //intrinsic message output to next block

  input  logic [2:0][MESSAGE_WIDTH-1:0] cnu_data_in , //input extrinsic messages from CNU
  output logic [2:0][MESSAGE_WIDTH:0]   cnu_data_out  //output extrinsic messages to CNU
  
  
);

//------------Intrinsic RAM-----------------
logic [ADDR_WIDTH-1:0]    int_add      [0:1];               //addresses for Intrinsic RAMs (INT_RAM)
logic [MESSAGE_WIDTH-1:0] int_data_in  [0:1];               //data input for INT_RAMs  
logic                     int_we       [0:1];               //write enable for INT_RAMs
logic                     int_cs       [0:1];               //chip select for INT_RAMs   
logic [MESSAGE_WIDTH-1:0] int_data_out [0:1];               //data output for INT_RAMs

//------------Extrinsic RAM -----------------
logic [ADDR_WIDTH-1:0]    ext_add      [0:2];               //address for Extrinsic RAM (EXT_RAM) 
logic [MESSAGE_WIDTH:0]   ext_data_in  [0:2];               //data input for EXT_RAM  
logic                     ext_we            ;               //write enable for EXT_RAM  
logic                     ext_cs            ;               //chip select for EXT_RAM
logic [MESSAGE_WIDTH:0]   ext_data_out [0:2];               //data output for EXT_RAM

//------------Decision RAM------------------
logic [ADDR_WIDTH-1:0]     dec_add      [0:1];              //addresses for Decision RAMs (DEC_RAM)
logic [DECISION_WIDTH-1:0] dec_data_in  [0:1];              //data input for DEC_RAMs      
logic                      dec_we       [0:1];              //write enable for DEC_RAMs
logic                      dec_cs       [0:1];              //chip select for DEC_RAMs
logic [DECISION_WIDTH-1:0] dec_data_out [0:1];              //data output for DEC_RAMs

//---------Address Generator-----------------
logic                       ag_en            ;              //enable for address generator
logic [ADDR_WIDTH-1:0]      ag_out      [0:2];              //output for address generator
logic                       ag_reset         ;              //reset for address generator

//-----------------VNU------------------------
logic [2:0][MESSAGE_WIDTH-1:0] vnu_ext_in    ;              //Extrinsic data input for VNU
logic [MESSAGE_WIDTH-1:0]   vnu_int_in       ;              //Intrinsic data input for VNU
logic [2:0][MESSAGE_WIDTH:0]vnu_ext_out      ;              //Extrinsic data output from VNU
logic [DECISION_WIDTH-1:0]  vnu_dec_out      ;              //Decision data output from VNU
logic                       vnu_en           ;              //enable pin for VNU

//--------------Shift Registers----------------
logic [ADDR_WIDTH-1:0]      shift_add_cnu1 [0:CNU_DELAY-1];  //store address to write data during CNU phase after the CNU_DELAY clock cycles
logic [ADDR_WIDTH-1:0]      shift_add_cnu2 [0:CNU_DELAY-1];
logic [ADDR_WIDTH-1:0]      shift_add_cnu3 [0:CNU_DELAY-1];

logic [ADDR_WIDTH-1:0]      shift_add_vnu [0:VNU_DELAY-1];  //store address to write data during VNU phase after the VNU_DELAY clock cycles 


logic [ADDR_WIDTH-1:0]      write_add_cnu[0:2];             //delayed address to write data during CNU phase 
logic [ADDR_WIDTH-1:0]      write_add_vnu;             //delayed address to write data during VNU phase

logic [ADDR_WIDTH-1:0]      read_add_cnu [0:2];
logic [ADDR_WIDTH-1:0]      read_add_vnu;

logic                       rs          ;             //RAM selct to shift focus between data frames   
integer                     itr_count      ;             //count the number of iterations
logic extended;
logic [ADDR_WIDTH-1:0] mem_reg_add [0:3];
logic [DECISION_WIDTH-1:0] mem_reg_dec ;
logic [MESSAGE_WIDTH-1:0] mem_reg_int ;
logic [MESSAGE_WIDTH-1:0] mem_reg_extin [0:2] ;
logic [MESSAGE_WIDTH:0] mem_reg_extout [0:2] ;

logic [ADDR_WIDTH-1:0] mem_reg_add_cnu1[0:5];
logic [ADDR_WIDTH-1:0] mem_reg_add_cnu2[0:5];
logic [ADDR_WIDTH-1:0] mem_reg_add_cnu3[0:5];
logic [MESSAGE_WIDTH-1:0] mem_reg_cnu_extin [0:2] ;
logic [MESSAGE_WIDTH:0] mem_reg_cnu_extout [0:2] ;


assign f_id=rs;
assign enable_cnu= ~vnu_en;
assign relay=dec_data_out[~rs][0];
initial begin 
  rs=1'b0;
  itr_count=0;
  extended=0;
end

//---------------------------------------------------------------------------
//---------------------Module Instantiation ---------------------------------
//---------------------------------------------------------------------------

INT_RAM #(MESSAGE_WIDTH,ADDR_WIDTH,RAM_DEPTH) int_ram
(
  .clk      (clk),
  .address  (int_add),
  .data_in  (int_data_in),
  .we       (int_we),
  .cs       (int_cs),
  .data_out (int_data_out)
);


genvar i;
generate
  for(i=0;i<3;i=i+1)begin
    EXT_RAM #(MESSAGE_WIDTH+1,ADDR_WIDTH,RAM_DEPTH)ext_ram_i
    (
      .clk      (clk_df),
      .address  (ext_add[i]),
      .we       (ext_we),
      .cs       (ext_cs),
      .data_in  (ext_data_in[i]),
      .data_out (ext_data_out[i])
    );
  end
endgenerate


DEC_RAM #(DECISION_WIDTH,ADDR_WIDTH,RAM_DEPTH) dec_ram
(
  .clk      (clk),
  .address  (dec_add),
  .data_in  (dec_data_in),
  .we       (dec_we),
  .cs       (dec_cs),
  .data_out (dec_data_out)
);


ADDRESS_GENERATOR #(ADDR_WIDTH,COUNT_FROM_1) ag1
(
  .clk   (clk),
  .en    (ag_en),
  .reset (ag_reset),
  .out   (ag_out[0])
);

ADDRESS_GENERATOR #(ADDR_WIDTH,COUNT_FROM_2) ag2
(
  .clk   (clk),
  .en    (ag_en),
  .reset (ag_reset),
  .out   (ag_out[1])
);

ADDRESS_GENERATOR #(ADDR_WIDTH,COUNT_FROM_3) ag3
(
  .clk   (clk),
  .en    (ag_en),
  .reset (ag_reset),
  .out   (ag_out[2])
);

VNU vnu
(
  .X             (vnu_ext_in),
  .Z             (vnu_int_in),
  .clk           (clk),
  .Y             (vnu_ext_out),
  .hard_decision (vnu_dec_out),
  .en            (vnu_en)
);



//---------------------------------------------------------------------------
//---------------------Intrinsic Data Frame Loading--------------------------
//---------------------------------------------------------------------------

assign load_add_out=load_add_in;
assign int_out=int_in;


always @(posedge clk_df) begin
    if(!clk && pe_select) begin
        int_we[~rs] <= 1'b0;
        int_cs[~rs] <= 1'b1;
        int_add[~rs] <= load_add_in;
        int_data_in[~rs] <= int_in;
    end

    if(clk && pe_select) begin
        int_we[~rs] <= 1'b1;
        int_cs[~rs] <= 1'b0;
    end
end


//-----------------------------------------------------------------------------
//-----------------------Hard Decision Frame Reading---------------------------
//-----------------------------------------------------------------------------
assign read_add_out = read_add_in;

always @(posedge clk_df) begin
    if(!clk && column_select) begin
        dec_we[~rs] <= 1'b0;
        dec_cs[~rs] <= 1'b1;
        dec_add[~rs] <= read_add_in;
    end

    if(clk && column_select) begin
        dec_we[~rs] <= 1'b1;
        dec_cs[~rs] <= 1'b0;
        if(Y!=1) begin
            dec_out={dec_in[K:Y],dec_data_out[~rs],dec_in[(Y-2):0]};
          end
          else begin
            dec_out={dec_in[K:Y],dec_data_out[~rs]};
          end
    end
end


//------------------------------------------------------------------------------
//-----------------------Initializing PE_Block----------------------------------
//------------------------------------------------------------------------------
always @(enable) begin
  ag_en=1'b1;

  if(enable) begin
    ag_reset=1'b0;
    vnu_en=1'b0;
  end
  else begin
    ag_reset=1'b1;
    vnu_en=1'bz;
  end
end


//----------------------------------------------------------------------------
//-------------------------------CNU Phase------------------------------------
//----------------------------------------------------------------------------

always @(posedge clk_df) begin
  if(clk && enable && !vnu_en)  begin
      mem_reg_cnu_extout[0] <= ext_data_out[0];
      mem_reg_cnu_extout[1] <= ext_data_out[1];
      mem_reg_cnu_extout[2] <= ext_data_out[2];


      mem_reg_add_cnu1[1] <= mem_reg_add_cnu1[0];
      mem_reg_add_cnu1[2] <= mem_reg_add_cnu1[1];
      mem_reg_add_cnu1[3] <= mem_reg_add_cnu1[2];
      mem_reg_add_cnu1[4] <= mem_reg_add_cnu1[3];
      mem_reg_add_cnu1[5] <= mem_reg_add_cnu1[4];

      mem_reg_add_cnu2[1] <= mem_reg_add_cnu2[0];
      mem_reg_add_cnu2[2] <= mem_reg_add_cnu2[1];
      mem_reg_add_cnu2[3] <= mem_reg_add_cnu2[2];
      mem_reg_add_cnu2[4] <= mem_reg_add_cnu2[3];
      mem_reg_add_cnu2[5] <= mem_reg_add_cnu2[4];

      mem_reg_add_cnu3[1] <= mem_reg_add_cnu3[0];
      mem_reg_add_cnu3[2] <= mem_reg_add_cnu3[1];
      mem_reg_add_cnu3[3] <= mem_reg_add_cnu3[2];
      mem_reg_add_cnu3[4] <= mem_reg_add_cnu3[3];
      mem_reg_add_cnu3[5] <= mem_reg_add_cnu3[4];

      mem_reg_cnu_extin[0] <= cnu_data_in[0];
      mem_reg_cnu_extin[1] <= cnu_data_in[1];
      mem_reg_cnu_extin[2] <= cnu_data_in[2];

      
      if(extended) begin
          mem_reg_add_cnu1[0] <= 5'bz;   
          mem_reg_add_cnu2[0] <= 5'bz;
          mem_reg_add_cnu3[0] <= 5'bz;
      end
  
      else begin
          mem_reg_add_cnu1[0] <= ag_out[0];
          mem_reg_add_cnu2[0] <= ag_out[1];
          mem_reg_add_cnu3[0] <= ag_out[2];
      end
      
  end
end

always @(posedge clk_df) begin
  if(!clk && enable && !vnu_en) begin


      cnu_data_out[0] <= mem_reg_cnu_extout[0]; 
      cnu_data_out[1] <= mem_reg_cnu_extout[1]; 
      cnu_data_out[2] <= mem_reg_cnu_extout[2]; 


      ext_add[0] <= mem_reg_add_cnu1[5];
      ext_add[1] <= mem_reg_add_cnu2[5];
      ext_add[2] <= mem_reg_add_cnu3[5];
      ext_we <= 1'b1;
      ext_cs <= 1'b1;
      ext_data_in[0] <= {1'b0, mem_reg_cnu_extin[0]};
      ext_data_in[1] <= {1'b0, mem_reg_cnu_extin[1]};
      ext_data_in[2] <= {1'b0, mem_reg_cnu_extin[2]};

  end
end 

always @(negedge clk) begin
  if(enable && !vnu_en) begin
      ext_we <= 1'b0;
      ext_cs <= 1'b1;
      ext_add[0] <= mem_reg_add_cnu1[0];
      ext_add[1] <= mem_reg_add_cnu2[0];
      ext_add[2] <= mem_reg_add_cnu3[0];
      
  end

end


//---------------------------------------------------------------------------------
//------------------------------VNU Phase------------------------------------------
//---------------------------------------------------------------------------------

always @(posedge clk_df) begin
  if(clk && enable && vnu_en)  begin
      mem_reg_extin[0] <= ext_data_out[0][5:0];
      mem_reg_extin[1] <= ext_data_out[1][5:0];
      mem_reg_extin[2] <= ext_data_out[2][5:0];
      mem_reg_int <= int_data_out[rs];

      mem_reg_add[1] <= mem_reg_add[0];
      mem_reg_add[2] <= mem_reg_add[1];
      mem_reg_add[3] <= mem_reg_add[2];
      

      mem_reg_extout[0] <= vnu_ext_out[0];
      mem_reg_extout[1] <= vnu_ext_out[1];
      mem_reg_extout[2] <= vnu_ext_out[2];
      mem_reg_dec <= vnu_dec_out;
      
      if(extended) begin
          mem_reg_add[0] <= 5'bz;        
      end
  
      else begin
          mem_reg_add[0] <= ag_out[0];
      end
      
  end
end

always @(posedge clk_df) begin
  if(!clk && enable && vnu_en) begin
      vnu_ext_in[0] <= mem_reg_extin[0];
      vnu_ext_in[1] <= mem_reg_extin[1];
      vnu_ext_in[2] <= mem_reg_extin[2];
      vnu_int_in <= mem_reg_int;
      
      dec_add[rs] <= mem_reg_add[3];
      dec_cs[rs] <= 1'b1;
      dec_we[rs] <= 1'b1;
      dec_data_in[rs] <= mem_reg_dec;

      ext_add[0] <= mem_reg_add[3];
      ext_add[1] <= mem_reg_add[3];
      ext_add[2] <= mem_reg_add[3];
      ext_we <= 1'b1;
      ext_cs <= 1'b1;
      ext_data_in[0] <= mem_reg_extout[0];
      ext_data_in[1] <= mem_reg_extout[1];
      ext_data_in[2] <= mem_reg_extout[2];

  end
end 

always @(negedge clk) begin
  if(enable && vnu_en) begin
      ext_we <= 1'b0;
      ext_cs <= 1'b1;
      ext_add[0] <= mem_reg_add[0];
      ext_add[1] <= mem_reg_add[0];
      ext_add[2] <= mem_reg_add[0];

      int_we[rs] <= 1'b0;
      int_cs[rs] <= 1'b1;
      int_add[rs] <= mem_reg_add[0];        
  end

end


//-------------------------------------------------------------------------------------
//-----------------------Flipping between CNU phase and VNU phase----------------------
//-------------------------------------------------------------------------------------
always @(ag_out[0]) begin
  if(ag_out[0]== L-1) begin
    extended=1'b1;
    if(!vnu_en) begin
      repeat(CNU_DELAY)
      @(posedge clk);
      
    end

    else begin
      repeat(VNU_DELAY)
      @(posedge clk);
      
    end

    ag_reset=1'b1;
    @(posedge clk);
    ag_reset=1'b0;
    vnu_en= ~vnu_en;
    extended=1'b0;
  end
end


//-----------------------------------------------------------------------------------------
//--------------------------Flipping focus on data frames----------------------------------
//-----------------------------------------------------------------------------------------
always @(vnu_en) begin
  itr_count=itr_count+1;
  //$display("Itr_count = %d\n",itr_count);

  if(itr_count==36) begin
    rs= ~rs;
    itr_count=0; 
  end
  

end


endmodule
