module bit4adder(
    input [3:0] x, y,
    input c_i,
    output [3:0] s,
    output c_o,
);
    wire [3:0] c;
    full_adder FA0(
        .x(x[0]),
        .y(y[0]),
        .c_i(c_i),
        .s(s[0]),
        .c_o(c[1])
    );
    full_adder FA1(
        .x(x[1]),
        .y(y[1]),
        .c_i(c[1]),
        .s(s[1]),
        .c_o(c[2])
    );
    full_adder FA2(
        .x(x[2]),
        .y(y[2]),
        .c_i(c[2]),
        .s(s[2]),
        .c_o(c[3])
    );
    full_adder FA3(
        .x(x[3]),
        .y(y[3]),
        .c_i(c[3]),
        .s(s[3]),
        .c_o(c_o)
    );
endmodule;
