// Single-port RAM with synchronous read with write byte-enable
module SYNC_RAM_WBE(q, d, addr, en, wbe, clk);
  parameter DWIDTH = 8;             // Data width
  parameter AWIDTH = 8;             // Address width
  parameter DEPTH  = (1 << AWIDTH); // Memory depth
  parameter MIF_HEX = "";
  parameter MIF_BIN = "";

  input [DWIDTH-1:0]   d;    // Data input
  input [AWIDTH-1:0]   addr; // Address input
  input [DWIDTH/8-1:0] wbe;  // write-byte-enable
  input en;
  input clk;
  output [DWIDTH-1:0] q;

  (* ram_style = "block" *) reg [DWIDTH-1:0] mem [0:DEPTH-1];

  integer i;
  initial begin
    /* verilator lint_off WIDTH */
    if (MIF_HEX != "") begin
      $readmemh(MIF_HEX, mem);
    end
    else if (MIF_BIN != "") begin
      $readmemb(MIF_BIN, mem);
    end
    /* verilator lint_on WIDTH */
    else begin
      for (i = 0; i < DEPTH; i = i + 1) begin
        mem[i] = 0;
      end
    end
  end

  reg [DWIDTH-1:0] read_data_reg;
  always @(posedge clk) begin
    if (en) begin
      for (i = 0; i < DWIDTH/8; i = i+1) begin
        if (wbe[i])
          mem[addr][i*8 +: 8] <= d[i*8 +: 8];
        end
      read_data_reg <= mem[addr];
    end
  end

  assign q = read_data_reg;
endmodule // SYNC_RAM_WBE