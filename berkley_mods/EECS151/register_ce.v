// Register with clock enable
module REGISTER_CE(q, d, ce, clk);
  parameter N = 1;
  output reg [N-1:0] q;
  input [N-1:0]      d;
  input 	      ce, clk;
  initial q = {N{1'b0}};
  always @(posedge clk)
    if (ce) q <= d;
endmodule // REGISTER_CE