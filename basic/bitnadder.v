module bitnadder #(
    parameter N = 4
)(
    input [N-1:0] x, y,
    input c_i,
    output [N-1:0] s,
    output c_o
);
    wire [N:0] c; assign c[0] = c_i; assign c_o=c[N];
    generate
        genvar i;
        for (i=0; i<N; i=i+1)
        begin
            full_adder FA(
                .x(x[i]),
                .y(y[i]),
                .c(c[i]),
                .s(s[i]),
                .c_o(c[i+1])
            );
        end
    endgenerate
endmodule;
