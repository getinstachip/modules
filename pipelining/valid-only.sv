module IC_valid_ready_pipeline #(
    parameter N = 32;
) (
    input clk,
    input rst_n,
    input [N-1:0] i_data,
    input i_valid,
    output logic i_ready,

    output logic [N-1:0] o_data,
    output logic o_valid,
    input o_ready
);
    
endmodule