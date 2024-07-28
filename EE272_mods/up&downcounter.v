module up_down_counter #(parameter N = 4) (
    input clk,
    input reset,
    input up_down, // 1 for up, 0 for down
    output reg [N-1:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else if (up_down)
            q <= q + 1;
        else
            q <= q - 1;
    end
endmodule
