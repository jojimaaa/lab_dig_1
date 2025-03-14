module decodificadorAcertos (
    input [1:0] acertosBin,
    output reg [1:0] acertosLeds
);

always @(*) begin
    case (acertosBin)
        2'b00: acertosLeds <= 2'b00;
        2'b01: acertosLeds <= 2'b10;
        2'b10: acertosLeds <= 2'b11;
        2'b11: acertosLeds <= 2'bzz;
        default: acertosLeds <= 2'b00;
    endcase
end

endmodule