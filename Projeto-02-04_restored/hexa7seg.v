/* ----------------------------------------------------------------
 * Arquivo   : hexa7seg.v
 * Projeto   : Experiencia 2 - Um Fluxo de Dados Simples
 *--------------------------------------------------------------
 * Descricao : decodificador hexadecimal para 
 *             display de 7 segmentos 
 * 
 * entrada : hexa - codigo binario de 4 bits hexadecimal
 * saida   : sseg - codigo de 7 bits para display de 7 segmentos
 *
 * baseado no componente bcd7seg.v da Intel FPGA
 *--------------------------------------------------------------
 * dica de uso: mapeamento para displays da placa DE0-CV
 *              bit 6 mais significativo é o bit a esquerda
 *              p.ex. sseg(6) -> HEX0[6] ou HEX06
 *--------------------------------------------------------------
 * Revisoes  :
 *     Data        Versao  Autor             Descricao
 *     24/12/2023  1.0     Edson Midorikawa  criacao
 *--------------------------------------------------------------
 */

module hexa7seg (hexa, display);
    input      [3:0] hexa;
    output reg [6:0] display;

    /*
     *    ---
     *   | 0 |
     * 5 |   | 1
     *   |   |
     *    ---
     *   | 6 |
     * 4 |   | 2
     *   |   |
     *    ---
     *     3
     */
        
    always @(hexa)
    case (hexa)
        4'h0:    display = 7'b0111111; // 0
        4'h1:    display = 7'b0000110; // 1
        4'h2:    display = 7'b1011011; // 2
        4'h3:    display = 7'b1001111; // 3
        4'h4:    display = 7'b1100110; // 4
        4'h5:    display = 7'b1101101; // 5
        4'h6:    display = 7'b1111101; // 6
        4'h7:    display = 7'b0000111; // 7
        4'h8:    display = 7'b1111111; // 8
        4'h9:    display = 7'b1101111; // 9
        4'ha:    display = 7'b1110011; // A
        4'hb:    display = 7'b1111001; // b
        4'hc:    display = 7'b0111101; // C
        4'hd:    display = 7'b1011110; // d
        4'he:    display = 7'b1111000; // E
        4'hf:    display = 7'b1110000; // F
        default: display = 7'b1111111; // Default to all segments off
    endcase
endmodule
