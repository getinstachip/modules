module bitnsubtractor #(
    parameter N = 4
) (
    input [N-1:0] x, y,
    input c_i,
    output [N-1:0] s,
    output c_o,
    output overflow
);
    wire [N-1:0] tcy = ~y+1; 
    assign overflow = (x[N-1]&tcy[N-1]&~s[N-1]&~tcy[N-1]&s[N-1]);
    bitnadder #(.N(N)) ADD(
        .x(x),
        .y(tcy),
        .c_i(c_i),
        .s(s),
        .c_o(c_o)
    );
endmodule
