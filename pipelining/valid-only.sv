module valid_ready_pipeline #(
  parameter DATA_WIDTH = 32
)(
  input clk,
  input rst_n,

  input [DATA_WIDTH-1:0] i_data,
  input i_valid,
  output logic i_ready,

  output logic [DATA_WIDTH-1:0] o_data,
  output logic o_valid,
  input o_ready
);

logic [DATA_WIDTH-1:0] buffer_data;
logic buffer_valid;

always_ff @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    i_ready <= 1'b1;
    buffer_valid <= 1'b0;
  end
  else begin
    if (~o_ready & i_valid) begin
      i_ready <= 1'b0;
      buffer_data <= i_data;
      buffer_valid <= 1'b1;
    end
    else if (o_ready & buffer_valid) begin
      i_ready <= 1'b1;
      buffer_valid <= 1'b0;
    end
    else begin
      i_ready <= o_ready;
      buffer_valid <= buffer_valid;
    end
  end
end

always_comb begin
  if (buffer_valid) begin
    o_data = buffer_data;
    o_valid = 1'b1;
  end
  else begin
    o_data = i_data;
    o_valid = i_valid;
  end
end

endmodule