module somador #(parameter N = 4) (
    input [N-1:0] a,
    input [N-1:0] b,
    input clk,
    input sum,
    input enable,
    output reg [N-1:0] result
);

always @(posedge clk) begin
    if (enable) begin
        if (sum)
            result <= a + b;
        else
            result <= a - b;
    end
end

endmodule