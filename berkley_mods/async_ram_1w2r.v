// Multi-port RAM with two asynchronous-read ports, one synchronous-write port
module ASYNC_RAM_1W2R(d0, addr0, we0, q1, addr1, q2, addr2, clk);
  parameter DWIDTH = 8;  // Data width
  parameter AWIDTH = 8;  // Address width
  parameter DEPTH = (1 << AWIDTH); // Memory depth
  parameter MIF_HEX = "";
  parameter MIF_BIN = "";
  input clk;

  input [DWIDTH-1:0] d0;    // Data input
  input [AWIDTH-1:0] addr0; // Address input
  input              we0;   // Write enable

  input [AWIDTH-1:0] addr1; // Address input
  output [DWIDTH-1:0] q1;

  input [AWIDTH-1:0] addr2; // Address input
  output [DWIDTH-1:0] q2;

  (* ram_style = "distributed" *) reg [DWIDTH-1:0] mem [0:DEPTH-1];

  integer i;
  initial begin
    if (MIF_HEX != "") begin
      $readmemh(MIF_HEX, mem);
    end
    else if (MIF_BIN != "") begin
      $readmemb(MIF_BIN, mem);
    end
    else begin
      for (i = 0; i < DEPTH; i = i + 1) begin
        mem[i] = 0;
      end
    end
  end

  always @(posedge clk) begin
    if (we0)
      mem[addr0] <= d0;
  end

  assign q1 = mem[addr1];
  assign q2 = mem[addr2];

endmodule // ASYNC_RAM_1W2R