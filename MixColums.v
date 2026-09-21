odule MixColumns(
    input [15:0] column_in,
    output [15:0] column_out
    );
    
    wire [3:0] a0,a1,a2,a3;
    assign a0=column_in[15:12];
    assign a1=column_in[11:8];
    assign a2=column_in[7:4];
    assign a3=column_in[3:0];
    
    //mult by 2
    wire [3:0] a0_x2,a1_x2,a2_x2,a3_x2;
    assign a0_x2= a0[3]? ((a0<<1)^4'b0011) :(a0<<1);      
    assign a1_x2= a1[3]? ((a1<<1)^4'b0011) :(a1<<1);      
    assign a2_x2= a2[3]? ((a2<<1)^4'b0011) :(a2<<1);      
    assign a3_x2= a3[3]? ((a3<<1)^4'b0011) :(a3<<1);      
    
    //mult by 3
    wire [3:0] a0_x3,a1_x3,a2_x3,a3_x3;
    assign a0_x3= a0_x2 ^ a0;      
    assign a1_x3= a1_x2 ^ a1;      
    assign a2_x3= a2_x2 ^ a2;      
    assign a3_x3= a3_x2 ^ a3;  
    
    //mul with matrix
    wire [3:0] b0,b1,b2,b3;
    assign b0 = a0_x2 ^ a1_x3 ^ a2 ^ a3;
    assign b1 = a0 ^ a1_x2 ^ a2_x3 ^ a3;
    assign b2 = a0 ^ a1 ^ a2_x2 ^ a3_x3;
    assign b3 = a0_x3 ^ a1 ^ a2 ^ a3_x2;
    
    assign column_out={b0,b1,b2,b3};
        
endmodule
