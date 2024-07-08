module mux2x1(
    input x1,
    input x2,
    input s,
    output f
);
    assign f = ~s&x1|s&x2;
endmodule
