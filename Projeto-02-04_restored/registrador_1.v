// Autor: Enzo Koichi Jojima - 14568285
// Adaptado do módulo registrador_4.v do Prof. Dr. Edson Midorikawa
module registrador_1 (
    input        clock,
    input        clear,
    input        enable,
    input   D,
    output  Q
);

    reg IQ;

    always @(posedge clock or posedge clear) begin
        if (clear)
            IQ <= 0;
        else if (enable)
            IQ <= D;
    end

    assign Q = IQ;

endmodule