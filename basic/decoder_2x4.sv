module decoder_NxN2 #(
    parameter N = 2
)(
    input en, [N-1:0] w,
    output reg [2 << N - 1:0] y
);
    assign y = en ? 1 << w : '0;
endmodule;
