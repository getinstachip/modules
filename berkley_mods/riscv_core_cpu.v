module cpu #(
    parameter CPU_CLOCK_FREQ = 50_000_000,
    parameter RESET_PC = 32'h4000_0000,
    parameter BAUD_RATE = 115200,
    parameter BIOS_MIF_HEX = ""
) (
    input clk,
    input rst,
    input bp_enable,
    input serial_in,
    output serial_out
);

   localparam DWIDTH = 32;
   localparam BEWIDTH = DWIDTH / 8;

   // BIOS Memory
   // Synchronous read: read takes one cycle
   // Synchronous write: write takes one cycle
   localparam BIOS_AWIDTH = 12;
   wire [BIOS_AWIDTH-1:0] bios_addra, bios_addrb;
   wire [DWIDTH-1:0]      bios_douta, bios_doutb;
   wire                   bios_ena, bios_enb;
   SYNC_ROM_DP #(.AWIDTH(BIOS_AWIDTH),
                 .DWIDTH(DWIDTH),
                 .MIF_HEX(BIOS_MIF_HEX))
   bios_mem(.q0(bios_douta),
            .addr0(bios_addra),
            .en0(bios_ena),
            .q1(bios_doutb),
            .addr1(bios_addrb),
            .en1(bios_enb),
            .clk(clk));

   // Data Memory
   // Synchronous read: read takes one cycle
   // Synchronous write: write takes one cycle
   // Write-byte-enable: select which of the four bytes to write
   localparam DMEM_AWIDTH = 14;
   wire [DMEM_AWIDTH-1:0] dmem_addra;
   wire [DWIDTH-1:0]      dmem_dina, dmem_douta;
   wire [BEWIDTH-1:0]     dmem_wbea;
   wire                   dmem_ena;
   SYNC_RAM_WBE #(.AWIDTH(DMEM_AWIDTH),
                  .DWIDTH(DWIDTH))
   dmem (.q(dmem_douta),
         .d(dmem_dina),
         .addr(dmem_addra),
         .wbe(dmem_wbea),
         .en(dmem_ena),
         .clk(clk));

   // Instruction Memory
   // Synchronous read: read takes one cycle
   // Synchronous write: write takes one cycle
   // Write-byte-enable: select which of the four bytes to write
   localparam IMEM_AWIDTH = 14;
   wire [IMEM_AWIDTH-1:0] imem_addra, imem_addrb;
   wire [DWIDTH-1:0]      imem_douta, imem_doutb;
   wire [DWIDTH-1:0]      imem_dina, imem_dinb;
   wire [BEWIDTH:0]       imem_wbea, imem_wbeb;
   wire                   imem_ena, imem_enb;
   SYNC_RAM_DP_WBE #(.AWIDTH(IMEM_AWIDTH),
                     .DWIDTH(DWIDTH))
   imem (.q0(imem_douta),
         .d0(imem_dina),
         .addr0(imem_addra),
         .wbe0(imem_wbea),
         .en0(imem_ena),
         .q1(imem_doutb),
         .d1(imem_dinb),
         .addr1(imem_addrb),
         .wbe1(imem_wbeb),
         .en1(imem_enb),
         .clk(clk));

   // Register file
   // Asynchronous read: read data is available in the same cycle
   // Synchronous write: write takes one cycle
   localparam RF_AWIDTH = 5;
   wire [RF_AWIDTH-1:0]   wa, ra1, ra2;
   wire [DWIDTH-1:0]      wd, rd1, rd2;
   wire                   we;
   ASYNC_RAM_1W2R # (.AWIDTH(RF_AWIDTH),
                     .DWIDTH(DWIDTH))
   rf (.addr0(wa),
       .d0(wd),
       .we0(we),
       .q1(rd1),
       .addr1(ra1),
       .q2(rd2),
       .addr2(ra2),
       .clk(clk));

   // On-chip UART
   //// UART Receiver
   wire [7:0]             uart_rx_data_out;
   wire                   uart_rx_data_out_valid;
   wire                   uart_rx_data_out_ready;
   //// UART Transmitter
   wire [7:0]             uart_tx_data_in;
   wire                   uart_tx_data_in_valid;
   wire                   uart_tx_data_in_ready;
   uart #(.CLOCK_FREQ(CPU_CLOCK_FREQ),
          .BAUD_RATE(BAUD_RATE))
   on_chip_uart (.clk(clk),
                 .reset(rst),
                 .serial_in(serial_in),
                 .data_out(uart_rx_data_out),
                 .data_out_valid(uart_rx_data_out_valid),
                 .data_out_ready(uart_rx_data_out_ready),
                 .serial_out(serial_out),
                 .data_in(uart_tx_data_in),
                 .data_in_valid(uart_tx_data_in_valid),
                 .data_in_ready(uart_tx_data_in_ready));

   // CSR
   wire [DWIDTH-1:0]      csr_dout, csr_din;
   wire                   csr_we;
   REGISTER_R_CE #(.N(DWIDTH))
   csr (.q(csr_dout),
        .d(csr_din),
        .rst(rst),
        .ce(csr_we),
        .clk(clk));

   // TODO: Your code to implement a fully functioning RISC-V core
   // Add as many modules as you want
   // Feel free to move the memory modules around

endmodule