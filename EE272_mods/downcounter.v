module down_counter #(parameter N = 4) (
    input clk,
    input reset,
    output reg [N-1:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= {N{1'b1}};
        else
            q <= q - 1;
    end
endmodule
