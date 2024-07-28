module ripple_counter #(parameter N = 4) (
    input clk,
    input reset,
    output reg [N-1:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= q + 1;
    end
endmodule
