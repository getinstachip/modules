module encoder_2NxN #(
    parameter N=2
)(
    input en, [2<<N-1:0] w,
    output reg [N-1:0] y
);
    integer i;
    always_ff @(w,en) begin
        y='bx
        if (en)
            for (i=0; i<N; i=i+1)
                if (w[i]) y=i;
    end
endmodule;
