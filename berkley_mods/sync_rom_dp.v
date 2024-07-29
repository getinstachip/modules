// Dual-port ROM with synchronous read
module SYNC_ROM_DP(q0, addr0, en0, q1, addr1, en1, clk);
  parameter DWIDTH = 8;             // Data width
  parameter AWIDTH = 8;             // Address width
  parameter DEPTH  = (1 << AWIDTH); // Memory depth
  parameter MIF_HEX = "";
  parameter MIF_BIN = "";

  input 	            clk;
  input               en0, en1;     // ram-enable
  input  [AWIDTH-1:0] addr0, addr1; // address
  output [DWIDTH-1:0] q0, q1;       // read data

  (* rom_style = "block" *) reg [DWIDTH-1:0] mem [0:DEPTH-1];

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
      read_data0_reg <= mem[addr0];
    end
  end

  always @(posedge clk) begin
    if (en1) begin
      read_data1_reg <= mem[addr1];
    end
  end

  assign q0 = read_data0_reg;
  assign q1 = read_data1_reg;
endmodule // SYNC_ROM_DP