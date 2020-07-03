// Convert number from Signed format to Two's complement

module S_to_T #(
  parameter DATA_WIDTH = 6
) 
(
  input wire  [DATA_WIDTH - 1 : 0] inp,
  output wire [DATA_WIDTH - 1 : 0] out
);

reg [DATA_WIDTH - 1 : 0] x;

always @* begin
  if (inp[DATA_WIDTH-1] == 1'b1)
    x = -inp[DATA_WIDTH-2:0];
  else
    x = inp;
end

assign out = x;

endmodule
