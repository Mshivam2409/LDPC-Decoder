// This file is generated from a python script, do not edit it by hand.

/*
 Inputs from CNU and unshuffled to PE blocks 
*/

module PI_3_unshuffle #(
     parameter DATA_WIDTH = 6,
    parameter START_STATE = 3
)
(
    input wire [DATA_WIDTH-1 : 0] data_in [0 : 36-1],
    input wire clk,
    input wire reset,
    output reg [DATA_WIDTH-1 : 0] data_out [0 : 36-1]
);

reg [4 : 0] state;
always @(posedge clk) begin
if(reset==1'b0)
    state <= START_STATE;
else
    state <= state + 1;
end

always @(*) begin
if (state == 0) begin

data_out[1] <= data_in[0];
data_out[15] <= data_in[1];
data_out[18] <= data_in[2];
data_out[24] <= data_in[3];
data_out[30] <= data_in[4];
data_out[31] <= data_in[5];
data_out[7] <= data_in[6];
data_out[8] <= data_in[7];
data_out[12] <= data_in[8];
data_out[19] <= data_in[9];
data_out[25] <= data_in[10];
data_out[27] <= data_in[11];
data_out[2] <= data_in[12];
data_out[11] <= data_in[13];
data_out[13] <= data_in[14];
data_out[14] <= data_in[15];
data_out[20] <= data_in[16];
data_out[33] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[21] <= data_in[20];
data_out[32] <= data_in[21];
data_out[34] <= data_in[22];
data_out[35] <= data_in[23];
data_out[4] <= data_in[24];
data_out[6] <= data_in[25];
data_out[10] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[29] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[16] <= data_in[32];
data_out[17] <= data_in[33];
data_out[23] <= data_in[34];
data_out[26] <= data_in[35];
end

else if (state == 1) begin

data_out[6] <= data_in[0];
data_out[12] <= data_in[1];
data_out[18] <= data_in[2];
data_out[19] <= data_in[3];
data_out[24] <= data_in[4];
data_out[30] <= data_in[5];
data_out[1] <= data_in[6];
data_out[3] <= data_in[7];
data_out[7] <= data_in[8];
data_out[13] <= data_in[9];
data_out[25] <= data_in[10];
data_out[31] <= data_in[11];
data_out[5] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[20] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[21] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[2] <= data_in[24];
data_out[10] <= data_in[25];
data_out[16] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[23] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 2) begin

data_out[0] <= data_in[0];
data_out[1] <= data_in[1];
data_out[6] <= data_in[2];
data_out[15] <= data_in[3];
data_out[23] <= data_in[4];
data_out[31] <= data_in[5];
data_out[8] <= data_in[6];
data_out[11] <= data_in[7];
data_out[18] <= data_in[8];
data_out[19] <= data_in[9];
data_out[27] <= data_in[10];
data_out[30] <= data_in[11];
data_out[7] <= data_in[12];
data_out[13] <= data_in[13];
data_out[20] <= data_in[14];
data_out[25] <= data_in[15];
data_out[29] <= data_in[16];
data_out[33] <= data_in[17];
data_out[3] <= data_in[18];
data_out[10] <= data_in[19];
data_out[16] <= data_in[20];
data_out[17] <= data_in[21];
data_out[22] <= data_in[22];
data_out[32] <= data_in[23];
data_out[4] <= data_in[24];
data_out[9] <= data_in[25];
data_out[12] <= data_in[26];
data_out[21] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[2] <= data_in[30];
data_out[5] <= data_in[31];
data_out[14] <= data_in[32];
data_out[24] <= data_in[33];
data_out[26] <= data_in[34];
data_out[28] <= data_in[35];
end

else if (state == 3) begin

data_out[15] <= data_in[0];
data_out[18] <= data_in[1];
data_out[23] <= data_in[2];
data_out[24] <= data_in[3];
data_out[25] <= data_in[4];
data_out[31] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[12] <= data_in[8];
data_out[14] <= data_in[9];
data_out[27] <= data_in[10];
data_out[30] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[13] <= data_in[14];
data_out[19] <= data_in[15];
data_out[29] <= data_in[16];
data_out[33] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[17] <= data_in[20];
data_out[22] <= data_in[21];
data_out[26] <= data_in[22];
data_out[34] <= data_in[23];
data_out[4] <= data_in[24];
data_out[6] <= data_in[25];
data_out[10] <= data_in[26];
data_out[21] <= data_in[27];
data_out[28] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[11] <= data_in[32];
data_out[16] <= data_in[33];
data_out[20] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 4) begin

data_out[0] <= data_in[0];
data_out[1] <= data_in[1];
data_out[5] <= data_in[2];
data_out[6] <= data_in[3];
data_out[12] <= data_in[4];
data_out[24] <= data_in[5];
data_out[7] <= data_in[6];
data_out[13] <= data_in[7];
data_out[25] <= data_in[8];
data_out[30] <= data_in[9];
data_out[31] <= data_in[10];
data_out[33] <= data_in[11];
data_out[8] <= data_in[12];
data_out[14] <= data_in[13];
data_out[17] <= data_in[14];
data_out[19] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[3] <= data_in[18];
data_out[4] <= data_in[19];
data_out[9] <= data_in[20];
data_out[10] <= data_in[21];
data_out[21] <= data_in[22];
data_out[27] <= data_in[23];
data_out[2] <= data_in[24];
data_out[15] <= data_in[25];
data_out[16] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[11] <= data_in[30];
data_out[18] <= data_in[31];
data_out[20] <= data_in[32];
data_out[23] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 5) begin

data_out[0] <= data_in[0];
data_out[1] <= data_in[1];
data_out[3] <= data_in[2];
data_out[5] <= data_in[3];
data_out[6] <= data_in[4];
data_out[30] <= data_in[5];
data_out[8] <= data_in[6];
data_out[9] <= data_in[7];
data_out[18] <= data_in[8];
data_out[19] <= data_in[9];
data_out[23] <= data_in[10];
data_out[31] <= data_in[11];
data_out[7] <= data_in[12];
data_out[11] <= data_in[13];
data_out[13] <= data_in[14];
data_out[20] <= data_in[15];
data_out[25] <= data_in[16];
data_out[26] <= data_in[17];
data_out[10] <= data_in[18];
data_out[21] <= data_in[19];
data_out[22] <= data_in[20];
data_out[32] <= data_in[21];
data_out[33] <= data_in[22];
data_out[35] <= data_in[23];
data_out[4] <= data_in[24];
data_out[12] <= data_in[25];
data_out[15] <= data_in[26];
data_out[27] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[2] <= data_in[30];
data_out[14] <= data_in[31];
data_out[16] <= data_in[32];
data_out[17] <= data_in[33];
data_out[24] <= data_in[34];
data_out[29] <= data_in[35];
end

else if (state == 6) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[19] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[9] <= data_in[6];
data_out[11] <= data_in[7];
data_out[12] <= data_in[8];
data_out[13] <= data_in[9];
data_out[30] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[7] <= data_in[13];
data_out[8] <= data_in[14];
data_out[21] <= data_in[15];
data_out[25] <= data_in[16];
data_out[29] <= data_in[17];
data_out[3] <= data_in[18];
data_out[4] <= data_in[19];
data_out[10] <= data_in[20];
data_out[16] <= data_in[21];
data_out[22] <= data_in[22];
data_out[32] <= data_in[23];
data_out[15] <= data_in[24];
data_out[20] <= data_in[25];
data_out[27] <= data_in[26];
data_out[28] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[2] <= data_in[31];
data_out[14] <= data_in[32];
data_out[17] <= data_in[33];
data_out[18] <= data_in[34];
data_out[26] <= data_in[35];
end

else if (state == 7) begin

data_out[1] <= data_in[0];
data_out[3] <= data_in[1];
data_out[19] <= data_in[2];
data_out[24] <= data_in[3];
data_out[30] <= data_in[4];
data_out[31] <= data_in[5];
data_out[7] <= data_in[6];
data_out[9] <= data_in[7];
data_out[12] <= data_in[8];
data_out[14] <= data_in[9];
data_out[23] <= data_in[10];
data_out[33] <= data_in[11];
data_out[11] <= data_in[12];
data_out[13] <= data_in[13];
data_out[17] <= data_in[14];
data_out[20] <= data_in[15];
data_out[21] <= data_in[16];
data_out[25] <= data_in[17];
data_out[4] <= data_in[18];
data_out[15] <= data_in[19];
data_out[16] <= data_in[20];
data_out[22] <= data_in[21];
data_out[26] <= data_in[22];
data_out[35] <= data_in[23];
data_out[2] <= data_in[24];
data_out[6] <= data_in[25];
data_out[10] <= data_in[26];
data_out[27] <= data_in[27];
data_out[29] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[8] <= data_in[32];
data_out[18] <= data_in[33];
data_out[28] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 8) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[15] <= data_in[2];
data_out[18] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[3] <= data_in[6];
data_out[8] <= data_in[7];
data_out[11] <= data_in[8];
data_out[19] <= data_in[9];
data_out[25] <= data_in[10];
data_out[30] <= data_in[11];
data_out[2] <= data_in[12];
data_out[5] <= data_in[13];
data_out[7] <= data_in[14];
data_out[13] <= data_in[15];
data_out[32] <= data_in[16];
data_out[33] <= data_in[17];
data_out[4] <= data_in[18];
data_out[10] <= data_in[19];
data_out[17] <= data_in[20];
data_out[21] <= data_in[21];
data_out[27] <= data_in[22];
data_out[34] <= data_in[23];
data_out[9] <= data_in[24];
data_out[12] <= data_in[25];
data_out[20] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[14] <= data_in[31];
data_out[16] <= data_in[32];
data_out[23] <= data_in[33];
data_out[26] <= data_in[34];
data_out[29] <= data_in[35];
end

else if (state == 9) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[30] <= data_in[5];
data_out[3] <= data_in[6];
data_out[7] <= data_in[7];
data_out[13] <= data_in[8];
data_out[18] <= data_in[9];
data_out[25] <= data_in[10];
data_out[31] <= data_in[11];
data_out[5] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[19] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[10] <= data_in[20];
data_out[15] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[2] <= data_in[24];
data_out[16] <= data_in[25];
data_out[21] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[20] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 10) begin

data_out[0] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[18] <= data_in[3];
data_out[25] <= data_in[4];
data_out[30] <= data_in[5];
data_out[1] <= data_in[6];
data_out[9] <= data_in[7];
data_out[13] <= data_in[8];
data_out[19] <= data_in[9];
data_out[23] <= data_in[10];
data_out[31] <= data_in[11];
data_out[2] <= data_in[12];
data_out[7] <= data_in[13];
data_out[8] <= data_in[14];
data_out[11] <= data_in[15];
data_out[20] <= data_in[16];
data_out[26] <= data_in[17];
data_out[3] <= data_in[18];
data_out[15] <= data_in[19];
data_out[21] <= data_in[20];
data_out[22] <= data_in[21];
data_out[32] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[16] <= data_in[26];
data_out[27] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[5] <= data_in[30];
data_out[14] <= data_in[31];
data_out[17] <= data_in[32];
data_out[24] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 11) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[23] <= data_in[2];
data_out[24] <= data_in[3];
data_out[25] <= data_in[4];
data_out[31] <= data_in[5];
data_out[7] <= data_in[6];
data_out[9] <= data_in[7];
data_out[12] <= data_in[8];
data_out[13] <= data_in[9];
data_out[30] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[19] <= data_in[15];
data_out[21] <= data_in[16];
data_out[29] <= data_in[17];
data_out[3] <= data_in[18];
data_out[4] <= data_in[19];
data_out[10] <= data_in[20];
data_out[16] <= data_in[21];
data_out[26] <= data_in[22];
data_out[27] <= data_in[23];
data_out[2] <= data_in[24];
data_out[15] <= data_in[25];
data_out[22] <= data_in[26];
data_out[28] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[18] <= data_in[33];
data_out[20] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 12) begin

data_out[0] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[18] <= data_in[3];
data_out[24] <= data_in[4];
data_out[30] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[13] <= data_in[8];
data_out[19] <= data_in[9];
data_out[25] <= data_in[10];
data_out[31] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[20] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[21] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[16] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[5] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[23] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 13) begin

data_out[3] <= data_in[0];
data_out[6] <= data_in[1];
data_out[18] <= data_in[2];
data_out[19] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[14] <= data_in[8];
data_out[25] <= data_in[9];
data_out[30] <= data_in[10];
data_out[33] <= data_in[11];
data_out[8] <= data_in[12];
data_out[13] <= data_in[13];
data_out[17] <= data_in[14];
data_out[20] <= data_in[15];
data_out[21] <= data_in[16];
data_out[26] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[27] <= data_in[21];
data_out[34] <= data_in[22];
data_out[35] <= data_in[23];
data_out[2] <= data_in[24];
data_out[10] <= data_in[25];
data_out[12] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[29] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[11] <= data_in[32];
data_out[16] <= data_in[33];
data_out[23] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 14) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[18] <= data_in[3];
data_out[24] <= data_in[4];
data_out[30] <= data_in[5];
data_out[13] <= data_in[6];
data_out[19] <= data_in[7];
data_out[23] <= data_in[8];
data_out[25] <= data_in[9];
data_out[31] <= data_in[10];
data_out[33] <= data_in[11];
data_out[7] <= data_in[12];
data_out[14] <= data_in[13];
data_out[17] <= data_in[14];
data_out[20] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[3] <= data_in[18];
data_out[4] <= data_in[19];
data_out[9] <= data_in[20];
data_out[10] <= data_in[21];
data_out[15] <= data_in[22];
data_out[21] <= data_in[23];
data_out[2] <= data_in[24];
data_out[16] <= data_in[25];
data_out[22] <= data_in[26];
data_out[27] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[8] <= data_in[32];
data_out[11] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 15) begin

data_out[1] <= data_in[0];
data_out[15] <= data_in[1];
data_out[19] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[3] <= data_in[6];
data_out[12] <= data_in[7];
data_out[14] <= data_in[8];
data_out[25] <= data_in[9];
data_out[27] <= data_in[10];
data_out[30] <= data_in[11];
data_out[5] <= data_in[12];
data_out[7] <= data_in[13];
data_out[8] <= data_in[14];
data_out[13] <= data_in[15];
data_out[29] <= data_in[16];
data_out[33] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[10] <= data_in[20];
data_out[16] <= data_in[21];
data_out[17] <= data_in[22];
data_out[26] <= data_in[23];
data_out[2] <= data_in[24];
data_out[6] <= data_in[25];
data_out[21] <= data_in[26];
data_out[22] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[11] <= data_in[31];
data_out[18] <= data_in[32];
data_out[20] <= data_in[33];
data_out[28] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 16) begin

data_out[0] <= data_in[0];
data_out[12] <= data_in[1];
data_out[15] <= data_in[2];
data_out[18] <= data_in[3];
data_out[23] <= data_in[4];
data_out[24] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[14] <= data_in[8];
data_out[25] <= data_in[9];
data_out[30] <= data_in[10];
data_out[31] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[13] <= data_in[14];
data_out[19] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[10] <= data_in[20];
data_out[17] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[6] <= data_in[25];
data_out[16] <= data_in[26];
data_out[21] <= data_in[27];
data_out[22] <= data_in[28];
data_out[34] <= data_in[29];
data_out[5] <= data_in[30];
data_out[11] <= data_in[31];
data_out[20] <= data_in[32];
data_out[28] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 17) begin

data_out[0] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[18] <= data_in[3];
data_out[25] <= data_in[4];
data_out[31] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[9] <= data_in[8];
data_out[13] <= data_in[9];
data_out[19] <= data_in[10];
data_out[30] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[20] <= data_in[15];
data_out[21] <= data_in[16];
data_out[29] <= data_in[17];
data_out[3] <= data_in[18];
data_out[15] <= data_in[19];
data_out[26] <= data_in[20];
data_out[27] <= data_in[21];
data_out[33] <= data_in[22];
data_out[34] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[16] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[35] <= data_in[29];
data_out[5] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[23] <= data_in[33];
data_out[24] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 18) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[24] <= data_in[2];
data_out[25] <= data_in[3];
data_out[30] <= data_in[4];
data_out[31] <= data_in[5];
data_out[9] <= data_in[6];
data_out[11] <= data_in[7];
data_out[12] <= data_in[8];
data_out[13] <= data_in[9];
data_out[19] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[7] <= data_in[13];
data_out[14] <= data_in[14];
data_out[20] <= data_in[15];
data_out[21] <= data_in[16];
data_out[29] <= data_in[17];
data_out[3] <= data_in[18];
data_out[4] <= data_in[19];
data_out[15] <= data_in[20];
data_out[16] <= data_in[21];
data_out[22] <= data_in[22];
data_out[26] <= data_in[23];
data_out[2] <= data_in[24];
data_out[10] <= data_in[25];
data_out[27] <= data_in[26];
data_out[28] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[8] <= data_in[31];
data_out[17] <= data_in[32];
data_out[18] <= data_in[33];
data_out[23] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 19) begin

data_out[0] <= data_in[0];
data_out[3] <= data_in[1];
data_out[6] <= data_in[2];
data_out[18] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[1] <= data_in[6];
data_out[8] <= data_in[7];
data_out[19] <= data_in[8];
data_out[23] <= data_in[9];
data_out[25] <= data_in[10];
data_out[30] <= data_in[11];
data_out[2] <= data_in[12];
data_out[7] <= data_in[13];
data_out[13] <= data_in[14];
data_out[20] <= data_in[15];
data_out[21] <= data_in[16];
data_out[32] <= data_in[17];
data_out[9] <= data_in[18];
data_out[15] <= data_in[19];
data_out[16] <= data_in[20];
data_out[22] <= data_in[21];
data_out[33] <= data_in[22];
data_out[35] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[12] <= data_in[26];
data_out[27] <= data_in[27];
data_out[29] <= data_in[28];
data_out[34] <= data_in[29];
data_out[5] <= data_in[30];
data_out[11] <= data_in[31];
data_out[14] <= data_in[32];
data_out[17] <= data_in[33];
data_out[26] <= data_in[34];
data_out[28] <= data_in[35];
end

else if (state == 20) begin

data_out[1] <= data_in[0];
data_out[3] <= data_in[1];
data_out[6] <= data_in[2];
data_out[18] <= data_in[3];
data_out[25] <= data_in[4];
data_out[30] <= data_in[5];
data_out[7] <= data_in[6];
data_out[9] <= data_in[7];
data_out[14] <= data_in[8];
data_out[19] <= data_in[9];
data_out[31] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[8] <= data_in[13];
data_out[13] <= data_in[14];
data_out[20] <= data_in[15];
data_out[29] <= data_in[16];
data_out[32] <= data_in[17];
data_out[4] <= data_in[18];
data_out[15] <= data_in[19];
data_out[17] <= data_in[20];
data_out[21] <= data_in[21];
data_out[26] <= data_in[22];
data_out[27] <= data_in[23];
data_out[2] <= data_in[24];
data_out[10] <= data_in[25];
data_out[12] <= data_in[26];
data_out[16] <= data_in[27];
data_out[22] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[11] <= data_in[31];
data_out[23] <= data_in[32];
data_out[24] <= data_in[33];
data_out[28] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 21) begin

data_out[0] <= data_in[0];
data_out[3] <= data_in[1];
data_out[12] <= data_in[2];
data_out[19] <= data_in[3];
data_out[23] <= data_in[4];
data_out[24] <= data_in[5];
data_out[1] <= data_in[6];
data_out[8] <= data_in[7];
data_out[11] <= data_in[8];
data_out[30] <= data_in[9];
data_out[31] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[7] <= data_in[13];
data_out[13] <= data_in[14];
data_out[25] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[10] <= data_in[20];
data_out[17] <= data_in[21];
data_out[21] <= data_in[22];
data_out[22] <= data_in[23];
data_out[6] <= data_in[24];
data_out[15] <= data_in[25];
data_out[20] <= data_in[26];
data_out[27] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[2] <= data_in[30];
data_out[14] <= data_in[31];
data_out[16] <= data_in[32];
data_out[18] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 22) begin

data_out[0] <= data_in[0];
data_out[6] <= data_in[1];
data_out[18] <= data_in[2];
data_out[24] <= data_in[3];
data_out[30] <= data_in[4];
data_out[31] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[12] <= data_in[8];
data_out[13] <= data_in[9];
data_out[19] <= data_in[10];
data_out[25] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[20] <= data_in[15];
data_out[21] <= data_in[16];
data_out[26] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[16] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[22] <= data_in[26];
data_out[28] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[5] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[23] <= data_in[33];
data_out[29] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 23) begin

data_out[0] <= data_in[0];
data_out[1] <= data_in[1];
data_out[6] <= data_in[2];
data_out[12] <= data_in[3];
data_out[24] <= data_in[4];
data_out[30] <= data_in[5];
data_out[3] <= data_in[6];
data_out[7] <= data_in[7];
data_out[13] <= data_in[8];
data_out[19] <= data_in[9];
data_out[25] <= data_in[10];
data_out[31] <= data_in[11];
data_out[5] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[20] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[21] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[2] <= data_in[24];
data_out[10] <= data_in[25];
data_out[16] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[11] <= data_in[30];
data_out[17] <= data_in[31];
data_out[18] <= data_in[32];
data_out[23] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 24) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[18] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[9] <= data_in[6];
data_out[11] <= data_in[7];
data_out[12] <= data_in[8];
data_out[13] <= data_in[9];
data_out[19] <= data_in[10];
data_out[30] <= data_in[11];
data_out[2] <= data_in[12];
data_out[7] <= data_in[13];
data_out[14] <= data_in[14];
data_out[21] <= data_in[15];
data_out[25] <= data_in[16];
data_out[29] <= data_in[17];
data_out[3] <= data_in[18];
data_out[10] <= data_in[19];
data_out[16] <= data_in[20];
data_out[22] <= data_in[21];
data_out[26] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[15] <= data_in[25];
data_out[27] <= data_in[26];
data_out[28] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[8] <= data_in[32];
data_out[17] <= data_in[33];
data_out[20] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 25) begin

data_out[0] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[18] <= data_in[3];
data_out[23] <= data_in[4];
data_out[24] <= data_in[5];
data_out[1] <= data_in[6];
data_out[7] <= data_in[7];
data_out[13] <= data_in[8];
data_out[25] <= data_in[9];
data_out[30] <= data_in[10];
data_out[31] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[19] <= data_in[15];
data_out[26] <= data_in[16];
data_out[32] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[21] <= data_in[20];
data_out[22] <= data_in[21];
data_out[27] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[15] <= data_in[26];
data_out[16] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[5] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[20] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 26) begin

data_out[0] <= data_in[0];
data_out[3] <= data_in[1];
data_out[19] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[1] <= data_in[6];
data_out[11] <= data_in[7];
data_out[12] <= data_in[8];
data_out[14] <= data_in[9];
data_out[30] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[7] <= data_in[13];
data_out[13] <= data_in[14];
data_out[21] <= data_in[15];
data_out[25] <= data_in[16];
data_out[26] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[10] <= data_in[20];
data_out[17] <= data_in[21];
data_out[22] <= data_in[22];
data_out[34] <= data_in[23];
data_out[2] <= data_in[24];
data_out[6] <= data_in[25];
data_out[15] <= data_in[26];
data_out[27] <= data_in[27];
data_out[28] <= data_in[28];
data_out[35] <= data_in[29];
data_out[8] <= data_in[30];
data_out[16] <= data_in[31];
data_out[18] <= data_in[32];
data_out[20] <= data_in[33];
data_out[29] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 27) begin

data_out[1] <= data_in[0];
data_out[3] <= data_in[1];
data_out[12] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[25] <= data_in[5];
data_out[7] <= data_in[6];
data_out[8] <= data_in[7];
data_out[9] <= data_in[8];
data_out[30] <= data_in[9];
data_out[31] <= data_in[10];
data_out[33] <= data_in[11];
data_out[5] <= data_in[12];
data_out[13] <= data_in[13];
data_out[14] <= data_in[14];
data_out[19] <= data_in[15];
data_out[26] <= data_in[16];
data_out[29] <= data_in[17];
data_out[4] <= data_in[18];
data_out[17] <= data_in[19];
data_out[21] <= data_in[20];
data_out[22] <= data_in[21];
data_out[27] <= data_in[22];
data_out[32] <= data_in[23];
data_out[6] <= data_in[24];
data_out[10] <= data_in[25];
data_out[15] <= data_in[26];
data_out[20] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[2] <= data_in[31];
data_out[11] <= data_in[32];
data_out[16] <= data_in[33];
data_out[18] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 28) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[12] <= data_in[2];
data_out[23] <= data_in[3];
data_out[24] <= data_in[4];
data_out[31] <= data_in[5];
data_out[3] <= data_in[6];
data_out[7] <= data_in[7];
data_out[13] <= data_in[8];
data_out[18] <= data_in[9];
data_out[25] <= data_in[10];
data_out[30] <= data_in[11];
data_out[5] <= data_in[12];
data_out[8] <= data_in[13];
data_out[14] <= data_in[14];
data_out[19] <= data_in[15];
data_out[26] <= data_in[16];
data_out[33] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[10] <= data_in[20];
data_out[15] <= data_in[21];
data_out[16] <= data_in[22];
data_out[27] <= data_in[23];
data_out[2] <= data_in[24];
data_out[21] <= data_in[25];
data_out[22] <= data_in[26];
data_out[28] <= data_in[27];
data_out[34] <= data_in[28];
data_out[35] <= data_in[29];
data_out[0] <= data_in[30];
data_out[11] <= data_in[31];
data_out[17] <= data_in[32];
data_out[20] <= data_in[33];
data_out[29] <= data_in[34];
data_out[32] <= data_in[35];
end

else if (state == 29) begin

data_out[0] <= data_in[0];
data_out[1] <= data_in[1];
data_out[6] <= data_in[2];
data_out[12] <= data_in[3];
data_out[18] <= data_in[4];
data_out[30] <= data_in[5];
data_out[7] <= data_in[6];
data_out[13] <= data_in[7];
data_out[19] <= data_in[8];
data_out[25] <= data_in[9];
data_out[27] <= data_in[10];
data_out[31] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[11] <= data_in[14];
data_out[14] <= data_in[15];
data_out[20] <= data_in[16];
data_out[26] <= data_in[17];
data_out[3] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[21] <= data_in[21];
data_out[32] <= data_in[22];
data_out[33] <= data_in[23];
data_out[4] <= data_in[24];
data_out[10] <= data_in[25];
data_out[16] <= data_in[26];
data_out[22] <= data_in[27];
data_out[28] <= data_in[28];
data_out[34] <= data_in[29];
data_out[5] <= data_in[30];
data_out[17] <= data_in[31];
data_out[23] <= data_in[32];
data_out[24] <= data_in[33];
data_out[29] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 30) begin

data_out[1] <= data_in[0];
data_out[6] <= data_in[1];
data_out[19] <= data_in[2];
data_out[24] <= data_in[3];
data_out[30] <= data_in[4];
data_out[31] <= data_in[5];
data_out[3] <= data_in[6];
data_out[7] <= data_in[7];
data_out[12] <= data_in[8];
data_out[13] <= data_in[9];
data_out[25] <= data_in[10];
data_out[27] <= data_in[11];
data_out[2] <= data_in[12];
data_out[8] <= data_in[13];
data_out[11] <= data_in[14];
data_out[14] <= data_in[15];
data_out[17] <= data_in[16];
data_out[33] <= data_in[17];
data_out[4] <= data_in[18];
data_out[9] <= data_in[19];
data_out[15] <= data_in[20];
data_out[16] <= data_in[21];
data_out[21] <= data_in[22];
data_out[32] <= data_in[23];
data_out[10] <= data_in[24];
data_out[20] <= data_in[25];
data_out[22] <= data_in[26];
data_out[28] <= data_in[27];
data_out[29] <= data_in[28];
data_out[34] <= data_in[29];
data_out[0] <= data_in[30];
data_out[5] <= data_in[31];
data_out[18] <= data_in[32];
data_out[23] <= data_in[33];
data_out[26] <= data_in[34];
data_out[35] <= data_in[35];
end

else if (state == 31) begin

data_out[0] <= data_in[0];
data_out[1] <= data_in[1];
data_out[6] <= data_in[2];
data_out[12] <= data_in[3];
data_out[23] <= data_in[4];
data_out[31] <= data_in[5];
data_out[9] <= data_in[6];
data_out[11] <= data_in[7];
data_out[13] <= data_in[8];
data_out[18] <= data_in[9];
data_out[19] <= data_in[10];
data_out[30] <= data_in[11];
data_out[7] <= data_in[12];
data_out[8] <= data_in[13];
data_out[20] <= data_in[14];
data_out[21] <= data_in[15];
data_out[25] <= data_in[16];
data_out[29] <= data_in[17];
data_out[3] <= data_in[18];
data_out[10] <= data_in[19];
data_out[22] <= data_in[20];
data_out[32] <= data_in[21];
data_out[33] <= data_in[22];
data_out[34] <= data_in[23];
data_out[4] <= data_in[24];
data_out[15] <= data_in[25];
data_out[16] <= data_in[26];
data_out[27] <= data_in[27];
data_out[28] <= data_in[28];
data_out[35] <= data_in[29];
data_out[2] <= data_in[30];
data_out[5] <= data_in[31];
data_out[14] <= data_in[32];
data_out[17] <= data_in[33];
data_out[24] <= data_in[34];
data_out[26] <= data_in[35];
end

end

endmodule