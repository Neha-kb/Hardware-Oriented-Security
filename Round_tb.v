module Round_tb();

    reg [63:0] round_in;
    reg [63:0] round_key;
    reg last_round;

    wire [63:0] round_out;
    Round uut (
        .round_in(round_in),
        .round_key(round_key),
        .last_round(last_round),
        .round_out(round_out)
    );

    initial begin


        round_in = 64'h1234_5678_9ABC_DEF0;
        round_key = 64'hEDCC_1233_1233_7455;
        last_round = 1'b0;

        #10;

        $display("INPUT = %h", round_in);
        $display("KEY = %h", round_key);
        $display("OUTPUT = %h", round_out);

        last_round = 1'b1;

        $display("LAST ROUND OUTPUT = %h", round_out);

        $finish;
    end

endmodule
