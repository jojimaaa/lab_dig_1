module contadorMaisMenos (
    input clock,      // Clock
    input reset,      // Reset
    input mais,     // Incrementa
    input menos,    // Decrementa
    input enable,
    output reg [1:0] Q // Contador de 2 bits (00 a 11)
);

    always @(posedge clock or posedge reset) begin
        if (reset)
            Q <= 2'b00;
        else if (enable && mais && !menos && Q < 2'b11)
            Q <= Q + 1;
        else if (enable && menos && !mais && Q > 2'b00)
            Q <= Q - 1;
        else Q <= Q;
    end
endmodule