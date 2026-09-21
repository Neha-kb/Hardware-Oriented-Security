`timescale 1ns / 1ps


module KeySchedule(
    input [3:0] round,
    input [63:0] prev_key,
    output [63:0] next_key
    );      

// Round Constant
wire[15:0] k0,k1,k2,k3;

assign k0 = prev_key[63:48];
assign k1 = prev_key[47:32];
assign k2 = prev_key[31:16];
assign k3 = prev_key[15:0];

// SubByted on last column
wire[3:0] s0,s1,s2,s3;
SubBytes sub0 (.a(prev_key[15:12]), .y(s0));
SubBytes sub1 (.a(prev_key[11:8]), .y(s1));
SubBytes sub2 (.a(prev_key[7:4]), .y(s2));
SubBytes sub3 (.a(prev_key[3:0]), .y(s3));

wire[15:0] temp_sub;
assign temp_sub = {s3,s2,s1,s0};

// rcon
wire[3:0] rcon;
assign rcon = (round ==4'd1)? 4'b0001:
(round ==4'd2)? 4'b0010:
(round ==4'd3)? 4'b0100                                                                                                                                            :
(round ==4'd4)? 4'b1000:
(round ==4'd5)? 4'b0011:
(round ==4'd6)? 4'b0110:
(round ==4'd7)? 4'b1100:
(round ==4'd8)? 4'b1011:
(round ==4'd9)? 4'b0101:
                4'b1010;
/*             
// XOR rcon
wire[15:0] temp_final;
assign temp_final= {temp_rot[15:12] ^ rcon, temp_rot[11:0]};
*/

// New Columns
wire [15:0] nk0,nk1,nk2,nk3;
assign nk0 = k0 ^ {rcon,12'b0}^temp_sub;
assign nk1 = k1 ^ nk0;
assign nk2 = k2 ^ nk1;
assign nk3 = k3 ^ nk2;

assign next_key = {nk0,nk1,nk2,nk3};

endmodule
