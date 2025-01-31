module unidade_controle (
 input clock,
 input reset,
 input iniciar,
 input fimS,
 input enderecoIgualSequencia,
 input tem_jogada,
 input jogadaIgualMemoria,
 output reg zeraE,
 output reg contaE,
 output reg zeraR,
 output reg registraR,
 output reg zeraS,
 output reg contaS,
 output reg acertou,
 output reg errou,
 output reg pronto,
 output reg [3:0] db_estado
);

    // Define estados
    parameter inicial          = 4'b0000;  // 0
    parameter preparacao       = 4'b0001;  // 1
    parameter inicia_sequencia = 4'b0010;  // 2
    parameter espera_jogada    = 4'b0011;  // 3
    parameter registra         = 4'b0100;  // 4
    parameter comparacao       = 4'b0101;  // 5
    parameter proximo          = 4'b0110;  // 6
    parameter is_ultima_sequencia   = 4'b0111;  // 7
    parameter proxima_sequencia = 4'b1000;  // 8
	parameter final_com_erro   = 4'b1110;  // E
    parameter final_com_acerto = 4'b1010;  // A

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
            inicia_sequencia: Eprox = espera_jogada;
            espera_jogada:    Eprox = tem_jogada ? registra : espera_jogada;
            registra:         Eprox = comparacao;
            comparacao:       Eprox = ~jogadaIgualMemoria ? final_com_erro : enderecoIgualSequencia ? is_ultima_sequencia : proximo;
            proximo:          Eprox = espera_jogada;
            is_ultima_sequencia: Eprox = fimS ? final_com_acerto : proxima_sequencia;
            proxima_sequencia: Eprox = inicia_sequencia;
            final_com_acerto: Eprox = iniciar ? preparacao : final_com_acerto;
			final_com_erro:   Eprox = iniciar ? preparacao : final_com_erro;
            default:          Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraE     = (Eatual == inicial || Eatual == preparacao || Eatual == inicia_sequencia) ? 1'b1 : 1'b0;
        zeraS     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraR     = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra) ? 1'b1 : 1'b0;
        contaE    = (Eatual == proximo) ? 1'b1 : 1'b0;
        contaS    = (Eatual == proxima_sequencia) ? 1'b1 : 1'b0;
        pronto    = (Eatual == final_com_acerto || Eatual == final_com_erro) ? 1'b1 : 1'b0;
		errou = (Eatual == final_com_erro) ? 1'b1 : 1'b0;
        acertou = (Eatual == final_com_acerto) ? 1'b1 : 1'b0;

		  
		  
        // Saida de depuracao (estado)
        case (Eatual)
            inicial:          db_estado <= 4'b0000;  // 0
            preparacao:       db_estado <= 4'b0001;  // 1
            inicia_sequencia: db_estado <= 4'b0010;  // 2
            espera_jogada:    db_estado <= 4'b0011;  // 3
            registra:         db_estado <= 4'b0100;  // 4
            comparacao:       db_estado <= 4'b0101;  // 5
            proximo:          db_estado <= 4'b0110;  // 6
            is_ultima_sequencia: db_estado <= 4'b0111;  // 7
            proxima_sequencia: db_estado <= 4'b1000;  // 8
            final_com_acerto: db_estado <= 4'b1010;  // A
            final_com_erro:   db_estado <= 4'b1110;  // E
            default:          db_estado <= 4'b1111;  // F (erro)
        endcase
    end


endmodule