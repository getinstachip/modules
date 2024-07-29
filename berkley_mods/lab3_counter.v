module lab3_counter #(
    parameter CYCLES_PER_SECOND = 125_000_000
)(
    input clk,
    input [3:0] buttons,
    output [3:0] leds
);
    wire [3:0] count;
    reg [3:0] d;
    assign leds = count;

    always @(*) begin
        if (buttons[0])
            d = count + 4'd1;
        else if (buttons[1])
            d = count - 4'd1;
        else if (buttons[3])
            d = 4'd0;
        else
            d = count;
    end

    REGISTER #(4) counter (.q(count), .d(d), .clk(clk));
endmodule