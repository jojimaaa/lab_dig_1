//Autores: Enzo Koichi Jojima - 14568285
//         Eduardo Ribeiro do Amparo Rodrigues de Souza - 14567346
module divisorClockFPGA (
    input clock,
    input rst,
    output reg clockDiv
);

reg [15:0] clk_div;

    always @(posedge clock or posedge rst) begin
    if (rst) begin
        clk_div <= 0;
        clockDiv <= 0;
    end else begin
        if (clk_div == 25000) begin
            clk_div <= 0;
            clockDiv <= ~clockDiv; 
        end else begin
            clk_div <= clk_div + 1;
        end
    end
end

endmodule