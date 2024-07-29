`define A4_FCW 24'd0
`define B4_FCW 24'd0
`define C5_FCW 24'd0
`define D5_FCW 24'd0

module fcw_ram(
    input clk,
    input rst,
    input wr_en,
    input [1:0] addr,
    input [23:0] d_in,
    output [23:0] d_out
);
    wire [23:0] ram [3:0];
    assign d_out = ram[addr];

    REGISTER_R #(.N(24), .INIT(`A4_FCW)) note_a_reg (
        .q(ram[0]),
        .d((wr_en && addr == 2'd0) ? d_in : ram[0]),
        .rst(rst),
        .clk(clk)
    );

    REGISTER_R #(.N(24), .INIT(`B4_FCW)) note_b_reg (
        .q(ram[1]),
        .d((wr_en && addr == 2'd1) ? d_in : ram[1]),
        .rst(rst),
        .clk(clk)
    );

    REGISTER_R #(.N(24), .INIT(`C5_FCW)) note_c_reg (
        .q(ram[2]),
        .d((wr_en && addr == 2'd2) ? d_in : ram[2]),
        .rst(rst),
        .clk(clk)
    );

    REGISTER_R #(.N(24), .INIT(`D5_FCW)) note_d_reg (
        .q(ram[3]),
        .d((wr_en && addr == 2'd3) ? d_in : ram[3]),
        .rst(rst),
        .clk(clk)
    );

endmodule