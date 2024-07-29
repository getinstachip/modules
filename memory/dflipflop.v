module dff(d,clk,q);
    parameter N = 1;
    output reg [N-1:0] q;
    input [N-1:0] d;
    input clk;

    initial q = {N{1'b0}};
    always @(posedge clk)
        q <= d;
endmodule