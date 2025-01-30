//------------------------------------------------------------------
// Arquivo   : exp3_unidade_controle.v
// Projeto   : Experiencia 3 - Projeto de uma Unidade de Controle
//------------------------------------------------------------------
// Descricao : Unidade de controle
//
// usar este codigo como template (modelo) para codificar 
// máquinas de estado de unidades de controle            
//------------------------------------------------------------------
// Revisoes  :
//     Data        Versao  Autor             Descricao
//     14/01/2024  1.0     Edson Midorikawa  versao inicial
//     12/01/2025  1.1     Edson Midorikawa  revisao
//------------------------------------------------------------------
//
module unidade_controle (
 input clock,
 input reset,
 input iniciar,
 input fim,
 input jogada,
 input igual,
 output reg zeraC,
 output reg contaC,
 output reg zeraR,
 output reg registraR,
 output reg acertou,
 output reg errou,
 output reg pronto,
 output reg [3:0] db_estado
);

    // Define estados
    parameter inicial          = 4'b0000;  // 0
    parameter preparacao       = 4'b0001;  // 1
    parameter registra         = 4'b0100;  // 4
    parameter comparacao       = 4'b0101;  // 5
	parameter final_com_erro   = 4'b0010;  // 2
    parameter proximo          = 4'b0110;  // 6
    parameter final_com_acerto = 4'b1111;  // F
    parameter espera_jogada    = 4'b0011;  // 3

    // Variaveis de estado
    reg [3:0] Eatual, Eprox;

    // Memoria de estado
    always @(posedge clock or posedge reset) begin
        if (reset)
            Eatual <= inicial;
        else
            Eatual <= Eprox;
    end

    // Logica de proximo estado
    always @* begin
        case (Eatual)
            inicial:          Eprox = iniciar ? preparacao : inicial;
            preparacao:       Eprox = espera_jogada;
            espera_jogada:    Eprox = jogada ? registra : espera_jogada;
            registra:         Eprox = comparacao;
            comparacao:       Eprox = ~fim && igual ? proximo : ~igual ? final_com_erro : final_com_acerto;
            proximo:          Eprox = espera_jogada;
            final_com_acerto: Eprox = iniciar ? preparacao : final_com_acerto;
			final_com_erro:   Eprox = iniciar ? preparacao : final_com_erro;
            default:          Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraC     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraR     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra) ? 1'b1 : 1'b0;
        contaC    = (Eatual == proximo) ? 1'b1 : 1'b0;
        pronto    = (Eatual == final_com_acerto || Eatual == final_com_erro) ? 1'b1 : 1'b0;
		errou = (Eatual == final_com_erro) ? 1'b1 : 1'b0;
        acertou = (Eatual == final_com_acerto) ? 1'b1 : 1'b0;
		  
		  
        // Saida de depuracao (estado)
        case (Eatual)
            inicial:          db_estado <= 4'b0000;  // 0
            preparacao:       db_estado <= 4'b0001;  // 1
            registra:         db_estado <= 4'b0100;  // 4
			final_com_erro:   db_estado <= 4'b0010;  // 2
            comparacao:       db_estado <= 4'b0101;  // 5
            proximo:          db_estado <= 4'b0110;  // 6
            final_com_acerto: db_estado <= 4'b1111;  // F
            espera_jogada:    db_estado <= 4'b0011;  // 3
            default:          db_estado <= 4'b1110;  // E (erro)
        endcase
    end

endmodule