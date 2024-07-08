module bitnsubtractor #(
    parameter N = 4
) (
    input [N-1:0] x, y,
    input c_i,
    output [N-1:0] s,
    output c_o
);
    bitnadder #(.N(N)) ADD(
        .x(x),
        .y(~y+1),
        .c_i(c_i),
        .s(s),
        .c_o(c_o)
    );
endmodule