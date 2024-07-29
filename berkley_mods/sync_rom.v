// Single-port ROM with synchronous read
module SYNC_ROM(q, addr, en, clk);
  parameter DWIDTH = 8;             // Data width
  parameter AWIDTH = 8;             // Address width
  parameter DEPTH  = (1 << AWIDTH); // Memory depth
  parameter MIF_HEX = "";
  parameter MIF_BIN = "";

  input 	            clk;
  input               en;   // ram-enable
  input  [AWIDTH-1:0] addr; // address
  output [DWIDTH-1:0] q;    // read data

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

  reg [DWIDTH-1:0] read_data_reg;
  always @(posedge clk) begin
    if (en) begin
      read_data_reg <= mem[addr];
    end
  end

  assign q = read_data_reg;
endmodule // SYNC_ROM