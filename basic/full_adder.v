module full_adder(
    input x, y, c_i,
    output s, c_o
);
    wire s1, c1, c2;
    half_adder HA0(
        .x(x),
        .y(y),
        .s(s1),
        .c(c1)
    );
    half_adder HA1(
        .x(c_i),
        .y(s1),
        .s(s),
        .c(c2)
    );
    assign c_o = c1|c2;
endmodule
