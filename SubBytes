module SubBytes(
    input [3:0] a,
    output [3:0] y
    );
    assign y = (a == 4'd0) ? 4'd6:
               (a == 4'd1) ? 4'hB:
               (a == 4'd2) ? 4'd5:
               (a == 4'd3) ? 4'd4:
               (a == 4'd4) ? 4'd2:
               (a == 4'd5) ? 4'hE:
               (a == 4'd6) ? 4'd7:
               (a == 4'd7) ? 4'hA:
               (a == 4'd8) ? 4'd9:
               (a == 4'd9) ? 4'hD:
               (a == 4'hA) ? 4'hF:
               (a == 4'hB) ? 4'hC:
               (a == 4'hC) ? 4'd3:
               (a == 4'hD) ? 4'd1:
               (a == 4'hE) ? 4'd0:
               (a == 4'hF) ? 4'd8:
               4'd0;               
endmodule
