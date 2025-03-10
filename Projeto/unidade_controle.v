module unidade_controle (
 input clock,
 input reset,
 input jogar,
 input fimS,
 input confirma,
 input nivel,
 input timeout,
 input tem_jogada,
 input acertouJogada,
 input jogadaAtualEQUALSacertoAnterior,
 input acertoAnteriorEQUALSzero,
 input fimPiscaLeds,
 input fimLedsOn,
 input fimLedsOff,
 output reg zeraT,
 output reg zeraR,
 output reg registraR,
 output reg zeraS,
 output reg contaS,
 output reg zeraA,
 output reg registraA,
 output reg contaA,
 output reg zeraN,
 output reg registraN,
 output reg zeraL,
 output reg registraL,
 output reg contaPiscaLeds,
 output reg [2:0] displayAddr,
 output reg pronto,
 output reg [3:0] db_estado,
 output reg contaLedsOn,
 output reg contaLedsOff,
 output reg contaPiscadas,
 output reg timeout_out
);


    // Define estados
    parameter inicial               = 4'b0000;  // 0
    parameter preparacao            = 4'b0001;  // 1
    parameter inicia_sequencia      = 4'b0010;  // 2
    parameter espera_jogada         = 4'b0011;  // 3
    parameter registra              = 4'b0100;  // 4
    parameter comparacao            = 4'b0101;  // 5
    parameter proximo               = 4'b0110;  // 6
    parameter acende_segundo_acerto = 4'b0111;  // 7
    parameter pisca_acertos_on      = 4'b1000;  // 8
    parameter pisca_acertos_off     = 4'b1100;  // C
    parameter is_ultima_sequencia   = 4'b1001;  // 9
    parameter proxima_sequencia     = 4'b1011;  // B
	parameter estado_timeout        = 4'b1110;  // E
    parameter final_com_acerto      = 4'b1010;  // A


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
            inicial:             Eprox = jogar ? preparacao : inicial;
            preparacao:          Eprox = timeout ? estado_timeout : confirma ? inicia_sequencia : preparacao;
            inicia_sequencia:    Eprox = timeout ? estado_timeout : espera_jogada;
            espera_jogada:       Eprox = timeout ? estado_timeout : tem_jogada ? registra : espera_jogada;
            registra:            Eprox = timeout ? estado_timeout : comparacao;
            comparacao:          Eprox = timeout ? estado_timeout : (~acertouJogada || acertouJogada && jogadaAtualEQUALSacertoAnterior) ? espera_jogada : acertouJogada && acertoAnteriorEQUALSzero ? proximo : (acertouJogada && ~acertoAnteriorEQUALSzero && ~jogadaAtualEQUALSacertoAnterior) ? acende_segundo_acerto : comparacao;
            acende_segundo_acerto: Eprox = timeout ? estado_timeout : pisca_acertos_on;
            pisca_acertos_on:    Eprox = timeout ? estado_timeout : fimLedsOn && fimPiscaLeds ? is_ultima_sequencia : fimLedsOn && ~fimPiscaLeds ? pisca_acertos_off : pisca_acertos_on;
            pisca_acertos_off:   Eprox = timeout ? estado_timeout : fimLedsOff ? pisca_acertos_on : pisca_acertos_off;
            proximo:             Eprox = timeout ? estado_timeout : espera_jogada;
            is_ultima_sequencia: Eprox = timeout ? estado_timeout : fimS ? final_com_acerto : proxima_sequencia;  
            proxima_sequencia:   Eprox = timeout ? estado_timeout : inicia_sequencia;
            final_com_acerto:    Eprox = jogar ? preparacao : final_com_acerto;
			estado_timeout:      Eprox = jogar ? preparacao : estado_timeout;
        
            default:             Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraR = (Eatual == preparacao || Eatual == final_com_acerto || Eatual == estado_timeout || Eatual == espera_jogada || Eatual == is_ultima_sequencia) ? 1'b1 : 1'b0;
        registraR = (Eatual == registra) ? 1'b1 : 1'b0;
        zeraS = (Eatual == preparacao) ? 1'b1 : 1'b0;
        contaS = (Eatual == proxima_sequencia) ? 1'b1 : 1'b0;
        zeraA = (Eatual == preparacao || Eatual == inicia_sequencia || Eatual == proxima_sequencia) ? 1'b1 : 1'b0;
        displayAddr = (Eatual == preparacao) ? 3'b000 : (Eatual == espera_jogada) ? 3'b001 : (Eatual == final_com_acerto) ? 3'b010 : (Eatual == estado_timeout) ? 3'b011 : 3'b111;
        pronto = (Eatual == final_com_acerto || Eatual == estado_timeout) ? 1'b1 : 1'b0;
        registraA = (Eatual == proximo) ? 1'b1 : 1'b0;
        contaA = (Eatual == proximo || Eatual == acende_segundo_acerto) ? 1'b1 : 1'b0;
        registraL = (Eatual == inicia_sequencia) ? 1'b1 : 1'b0;
        zeraT = (Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraN = (Eatual == inicial) ? 1'b1 : 1'b0;
        registraN = (Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraL = (Eatual == preparacao) ? 1'b1 : 1'b0;
        timeout_out = (Eatual == estado_timeout) ? 1'b1 : 1'b0;
		  
		  
        // Saida de depuracao (estado)
        case (Eatual)
            inicial              : db_estado <= 4'b0000;  // 0
            preparacao           : db_estado <= 4'b0001;  // 1
            inicia_sequencia     : db_estado <= 4'b0010;  // 2
            espera_jogada        : db_estado <= 4'b0011;  // 3
            registra             : db_estado <= 4'b0100;  // 4
            comparacao           : db_estado <= 4'b0101;  // 5
            proximo              : db_estado <= 4'b0110;  // 6
            acende_segundo_acerto: db_estado <= 4'b0111;  // 7
            pisca_acertos        : db_estado <= 4'b1000;  // 8
            is_ultima_sequencia  : db_estado <= 4'b1001;  // 9
            proxima_sequencia    : db_estado <= 4'b1011;  // B
            estado_timeout       : db_estado <= 4'b1110;  // E
            final_com_acerto     : db_estado <= 4'b1010;  // A
            default              : db_estado <= 4'bzzzz;  // alta impedância (erro)
        endcase
    end


endmodule