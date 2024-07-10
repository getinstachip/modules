module pipeline(
    input rst, clk, in_vld, in_data_common, type_a, type_b, in_data_a, in_data_b, en,
    output reg out_vld, out_data_common, out_data_a, out_data_b
);
    always_ff @(posedge clk) begin
        out_vld <= rst ? in_vld : '0;
        if(en) begin
            out_data_common <= in_data_common;
            if(in_vld&&type_b) out_data_b <= in_data_b;
            if(in_vld&&type_a) out_data_a <= in_data_a;
        end
    end 
endmodule;
