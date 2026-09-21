`timescale 1ns / 1ps

module AES_Encrypt(

    input  [63:0] plaintext,
    input  [63:0] key,
    output [63:0] ciphertext

    );


//   ROUND KEYS

wire [63:0] key1;
wire [63:0] key2;
wire [63:0] key3;
wire [63:0] key4;
wire [63:0] key5;
wire [63:0] key6;
wire [63:0] key7;
wire [63:0] key8;
wire [63:0] key9;
wire [63:0] key10;



//   KEY EXPANSION

KeySchedule ks1 (
    .round(4'd1),
    .prev_key(key),
    .next_key(key1)
);

KeySchedule ks2 (
    .round(4'd2),
    .prev_key(key1),
    .next_key(key2)
);

KeySchedule ks3 (
    .round(4'd3),
    .prev_key(key2),
    .next_key(key3)
);

KeySchedule ks4 (
    .round(4'd4),
    .prev_key(key3),
    .next_key(key4)
);

KeySchedule ks5 (
    .round(4'd5),
    .prev_key(key4),
    .next_key(key5)
);

KeySchedule ks6 (
    .round(4'd6),
    .prev_key(key5),
    .next_key(key6)
);

KeySchedule ks7 (
    .round(4'd7),
    .prev_key(key6),
    .next_key(key7)
);

KeySchedule ks8 (
    .round(4'd8),
    .prev_key(key7),
    .next_key(key8)
);

KeySchedule ks9 (
    .round(4'd9),
    .prev_key(key8),
    .next_key(key9)
);

KeySchedule ks10 (
    .round(4'd10),
    .prev_key(key9),
    .next_key(key10)
);


 //  INITIAL ADDROUNDKEY


wire [63:0] state0;

assign state0 = plaintext ^ key;



//   ROUND STATES

wire [63:0] state1;
wire [63:0] state2;
wire [63:0] state3;
wire [63:0] state4;
wire [63:0] state5;
wire [63:0] state6;
wire [63:0] state7;
wire [63:0] state8;
wire [63:0] state9;
wire [63:0] state10;



// 10 ROUNDS


Round r1 (
    .round_in(state0),
    .round_key(key1),
    .last_round(1'b0),
    .round_out(state1)
);

Round r2 (
    .round_in(state1),
    .round_key(key2),
    .last_round(1'b0),
    .round_out(state2)
);

Round r3 (
    .round_in(state2),
    .round_key(key3),
    .last_round(1'b0),
    .round_out(state3)
);

Round r4 (
    .round_in(state3),
    .round_key(key4),
    .last_round(1'b0),
    .round_out(state4)
);

Round r5 (
    .round_in(state4),
    .round_key(key5),
    .last_round(1'b0),
    .round_out(state5)
);

Round r6 (
    .round_in(state5),
    .round_key(key6),
    .last_round(1'b0),
    .round_out(state6)
);

Round r7 (
    .round_in(state6),
    .round_key(key7),
    .last_round(1'b0),
    .round_out(state7)
);

Round r8 (
    .round_in(state7),
    .round_key(key8),
    .last_round(1'b0),
    .round_out(state8)
);

Round r9 (
    .round_in(state8),
    .round_key(key9),
    .last_round(1'b0),
    .round_out(state9)
);

Round r10 (
    .round_in(state9),
    .round_key(key10),
    .last_round(1'b1),
    .round_out(state10)
);


assign ciphertext = state10;


endmodule
