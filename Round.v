module Round(
    input [63:0] round_in,
    input [63:0] round_key,
    input last_round,
    output [63:0] round_out
    );

    wire [63:0] sub_out;

    SubBytes s0 (.a(round_in[63:60]), .y(sub_out[63:60]));
    SubBytes s1 (.a(round_in[59:56]), .y(sub_out[59:56]));
    SubBytes s2 (.a(round_in[55:52]), .y(sub_out[55:52]));
    SubBytes s3 (.a(round_in[51:48]), .y(sub_out[51:48]));

    SubBytes s4 (.a(round_in[47:44]), .y(sub_out[47:44]));
    SubBytes s5 (.a(round_in[43:40]), .y(sub_out[43:40]));
    SubBytes s6 (.a(round_in[39:36]), .y(sub_out[39:36]));
    SubBytes s7 (.a(round_in[35:32]), .y(sub_out[35:32]));

    SubBytes s8 (.a(round_in[31:28]), .y(sub_out[31:28]));
    SubBytes s9 (.a(round_in[27:24]), .y(sub_out[27:24]));
    SubBytes s10 (.a(round_in[23:20]), .y(sub_out[23:20]));
    SubBytes s11 (.a(round_in[19:16]), .y(sub_out[19:16]));

    SubBytes s12 (.a(round_in[15:12]), .y(sub_out[15:12]));
    SubBytes s13 (.a(round_in[11:8]), .y(sub_out[11:8]));
    SubBytes s14 (.a(round_in[7:4]), .y(sub_out[7:4]));
    SubBytes s15 (.a(round_in[3:0]), .y(sub_out[3:0]));


wire [3:0] s[0:15];

assign s[0]  = sub_out[63:60];
assign s[1]  = sub_out[59:56];
assign s[2]  = sub_out[55:52];
assign s[3]  = sub_out[51:48];

assign s[4]  = sub_out[47:44];
assign s[5]  = sub_out[43:40];
assign s[6]  = sub_out[39:36];
assign s[7]  = sub_out[35:32];

assign s[8]  = sub_out[31:28];
assign s[9]  = sub_out[27:24];
assign s[10] = sub_out[23:20];
assign s[11] = sub_out[19:16];

assign s[12] = sub_out[15:12];
assign s[13] = sub_out[11:8];
assign s[14] = sub_out[7:4];
assign s[15] = sub_out[3:0];

wire [63:0] shift_out;

assign shift_out = {
    s[0],  s[5],  s[10], s[15],
    s[4],  s[9],  s[14], s[3],
    s[8],  s[13], s[2],  s[7],
    s[12], s[1],  s[6],  s[11]
};

//***************************************************************
    wire [15:0] mc0, mc1, mc2, mc3;

    MixColumns u0 (.column_in(shift_out[63:48]), .column_out(mc0));
    MixColumns u1 (.column_in(shift_out[47:32]), .column_out(mc1));
    MixColumns u2 (.column_in(shift_out[31:16]), .column_out(mc2));
    MixColumns u3 (.column_in(shift_out[15:0]), .column_out(mc3));

    wire [63:0] mix_out;
    assign mix_out = {mc0, mc1, mc2, mc3};


    wire [63:0] state_out;

    assign state_out = (last_round) ? shift_out : mix_out;
    //assign state_out=sub_out;

    assign round_out = state_out ^ round_key;

endmodule

