module mux_4x1 (
    input [3:0] in0, in1, in2, in3, // Entradas de 4 bits cada
    input [1:0] sel,               // Seleção de 2 bits
    output reg [3:0] out           // Saída de 4 bits
);

    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 4'b0000;
        endcase
    end
endmodule
