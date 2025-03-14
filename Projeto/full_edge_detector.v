//Autor Enzo Koichi Jojima - 14568285
//Adaptado do módulo edge_detector do Prof. Dr. Edson Midorikawa
 
module full_edge_detector (
    input  clock,
    input  reset,
    input  sinal,
    output pulso
);

    reg reg0;
    reg reg1;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            reg0 <= 1'b0;
            reg1 <= 1'b0;
        end else if (clock) begin
            reg0 <= sinal;
            reg1 <= reg0;
        end
    end

    // ~reg1 & reg0 detecta bordas de subida
    // reg1 & ~reg0 detecta bordas de descida
    assign pulso = ~reg1 & reg0 || reg1 & ~reg0;

endmodule
