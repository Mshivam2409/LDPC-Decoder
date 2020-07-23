/*-------------------------------------------------------------------------------
This module converts the input, represented in sign-magnitude format, to two's complement format.
For example: input = 100110  
             the first bit of the input being one indicates that it is a negative number.
             the output in this case will be the negative(two's complement) of 000110 (absolute value of input) which is 111010.
             output= 111010
--------------------------------------------------------------------------------*/

module S_to_T #(
  parameter DATA_WIDTH = 5             
) 
  //port declarations
(
  //input port
  input wire  [DATA_WIDTH - 1 : 0] inp,
  
  //output port
  output wire [DATA_WIDTH - 1 : 0] out
);
  
  //register to store values assigned in the procedural block
  reg [DATA_WIDTH - 1 : 0] x;      

//procedural block  
always @* begin
  if (inp[DATA_WIDTH-1] == 1'b1)    //if number is negative:
    x = -inp[DATA_WIDTH-2:0];       //two's complement of all the bits except the sign bit
  else
    x = inp;                        //representation of a positive number is same in both formats
end

assign out = x;                     //outputs the value stored in register x 

endmodule
