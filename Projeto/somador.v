module somador (
    input [3:0] a,
    input [3:0] b,
    input clk,
    input enable,
    output reg [4:0] sum
);

always @(posedge clk) begin
    if (enable) begin
        sum <= a + b;
    end
end

endmodule