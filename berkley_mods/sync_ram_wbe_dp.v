// Dual-port RAM with synchronous read with write byte-enable
module SYNC_RAM_DP_WBE(q0, d0, addr0, en0, wbe0, q1, d1, addr1, en1, wbe1, clk);
  parameter DWIDTH = 8;             // Data width
  parameter AWIDTH = 8;             // Address width
  parameter DEPTH  = (1 << AWIDTH); // Memory depth
  parameter MIF_HEX = "";
  parameter MIF_BIN = "";

  input clk;
  input [DWIDTH-1:0]   d0;    // Data input
  input [AWIDTH-1:0]   addr0; // Address input
  input [DWIDTH/8-1:0] wbe0;  // write-byte-enable
  input                en0;
  output [DWIDTH-1:0]  q0;

  input [DWIDTH-1:0]   d1;    // Data input
  input [AWIDTH-1:0]   addr1; // Address input
  input [DWIDTH/8-1:0] wbe1;  // write-byte-enable
  input                en1;
  output [DWIDTH-1:0]  q1;

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


  reg [DWIDTH-1:0] read_data0_reg;
  reg [DWIDTH-1:0] read_data1_reg;

  always @(posedge clk) begin
    if (en0) begin
      for (i = 0; i < 4; i = i+1) begin
        if (wbe0[i])
          mem[addr0][i*8 +: 8] <= d0[i*8 +: 8];
      end
      read_data0_reg <= mem[addr0];
    end
  end

  always @(posedge clk) begin
    if (en1) begin
      for (i = 0; i < 4; i = i+1) begin
        if (wbe1[i])
          mem[addr1][i*8 +: 8] <= d1[i*8 +: 8];
        end
      read_data1_reg <= mem[addr1];
    end
  end

  assign q0 = read_data0_reg;
  assign q1 = read_data1_reg;

endmodule // SYNC_RAM_DP_WBE