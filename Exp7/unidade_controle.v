module unidade_controle (
 input clock,
 input reset,
 input iniciar,
 input fimS,
 input fimLedsOn,  //novo input
 input fimLedsOff, //novo input
 input meioE,      // - caso precise de nível
 input nivel,      // - caso precise de nível
 input timeout,
 input enderecoIgualSequencia,
 input tem_jogada,
 input jogadaIgualMemoria,
 input nivelChange, //novo input exp7 - nivelChange
 input memoriaChange, //novo input exp7 - memoriaChange
 output reg zeraE,
 output reg contaE,
 output reg zeraR,
 output reg registraR,
 output reg zeraS,
 output reg contaS,
 output reg acertou,
 output reg errou,
 output reg pronto,
 output reg estado_espera,
 output reg estado_ledsOn, //novo output
 output reg estado_ledsOff, //novo output
 output reg macro_exibicao, //novo output - exp7
 output reg macro_jogadas, //novo output - exp7
 output reg [3:0] db_estado
);

    // Define estados
    parameter inicial               = 4'b0000;  // 0
    parameter preparacao            = 4'b0001;  // 1
    parameter inicia_sequencia      = 4'b0010;  // 2
    parameter espera_jogada         = 4'b0011;  // 3
    parameter registra              = 4'b0100;  // 4
    parameter comparacao            = 4'b0101;  // 5
    parameter proximo               = 4'b0110;  // 6
    parameter is_ultima_sequencia   = 4'b0111;  // 7
    parameter proxima_sequencia     = 4'b1000;  // 8
	parameter final_com_erro        = 4'b1110;  // E
    parameter final_com_acerto      = 4'b1010;  // A

    //novos estados - exp6
    parameter leds_on               = 4'b1001;  // 9
    parameter leds_off              = 4'b1011;  // B
    parameter is_ultimo_led         = 4'b1100;  // C
    parameter proximo_led           = 4'b1101;  // D
    parameter zera_endereco         = 4'b1111;  // F

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
            inicial:             Eprox = iniciar ? preparacao : inicial;
            preparacao:          Eprox = (nivelChange || memoriaChange) ? final_com_erro : leds_on;
            inicia_sequencia:    Eprox = (nivelChange || memoriaChange) ? final_com_erro : leds_on;
            espera_jogada:       Eprox = (nivelChange || memoriaChange) ? final_com_erro : timeout ? final_com_erro : tem_jogada ? registra : espera_jogada;
            registra:            Eprox = (nivelChange || memoriaChange) ? final_com_erro : comparacao;
            comparacao:          Eprox = (nivelChange || memoriaChange || ~jogadaIgualMemoria) ? final_com_erro : enderecoIgualSequencia ? is_ultima_sequencia : proximo;
            proximo:             Eprox = (nivelChange || memoriaChange) ? final_com_erro : espera_jogada;
            
            is_ultima_sequencia: Eprox = (nivelChange || memoriaChange) ? final_com_erro : nivel ? (fimS ? final_com_acerto : proxima_sequencia) : meioE ? final_com_acerto : proxima_sequencia;

            //is_ultima_sequencia: Eprox = (nivelChange || memoriaChange) ? final_com_erro : fimS ? final_com_acerto : proxima_sequencia;   
            proxima_sequencia:   Eprox = (nivelChange || memoriaChange) ? final_com_erro : inicia_sequencia;
            final_com_acerto:    Eprox = iniciar ? preparacao : final_com_acerto;
			final_com_erro:      Eprox = iniciar ? preparacao : final_com_erro;
            
            //novos estados - exp6
            leds_on:             Eprox = (nivelChange || memoriaChange) ? final_com_erro : fimLedsOn ? leds_off : leds_on;
            leds_off:            Eprox = (nivelChange || memoriaChange) ? final_com_erro : fimLedsOff ? is_ultimo_led : leds_off;
            is_ultimo_led:       Eprox = (nivelChange || memoriaChange) ? final_com_erro : enderecoIgualSequencia ? zera_endereco : proximo_led;
            zera_endereco:       Eprox = (nivelChange || memoriaChange) ? final_com_erro : espera_jogada;
            proximo_led:         Eprox = (nivelChange || memoriaChange) ? final_com_erro : leds_on;
            default:             Eprox = inicial;
        endcase
    end

    // Logica de saida (maquina Moore)
    always @* begin
        zeraE           = (Eatual == inicial || Eatual == preparacao || Eatual == inicia_sequencia || Eatual == zera_endereco) ? 1'b1 : 1'b0;
        zeraS           = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        zeraR           = (Eatual == inicial || Eatual == preparacao) ? 1'b1 : 1'b0;
        registraR       = (Eatual == registra) ? 1'b1 : 1'b0;
        contaE          = (Eatual == proximo || Eatual == proximo_led) ? 1'b1 : 1'b0;
        contaS          = (Eatual == proxima_sequencia) ? 1'b1 : 1'b0;
        pronto          = (Eatual == final_com_acerto || Eatual == final_com_erro) ? 1'b1 : 1'b0;
		errou           = (Eatual == final_com_erro) ? 1'b1 : 1'b0;
        acertou         = (Eatual == final_com_acerto) ? 1'b1 : 1'b0;
        estado_espera   = (Eatual == espera_jogada) ? 1'b1 : 1'b0;
        estado_ledsOn   = (Eatual == leds_on) ? 1'b1 : 1'b0;
        estado_ledsOff  = (Eatual == leds_off) ? 1'b1 : 1'b0;
        macro_exibicao  = (Eatual == leds_on || Eatual == leds_off || Eatual == proximo_led || Eatual == is_ultimo_led) ? 1'b1 : 1'b0;
        macro_jogadas   = (Eatual == espera_jogada || Eatual == registra || Eatual == comparacao || Eatual == proximo || Eatual == is_ultima_sequencia || Eatual == proxima_sequencia) ? 1'b1 : 1'b0;



		  
		  
        // Saida de depuracao (estado)
        case (Eatual)
            inicial:             db_estado <= 4'b0000;  // 0
            preparacao:          db_estado <= 4'b0001;  // 1
            inicia_sequencia:    db_estado <= 4'b0010;  // 2
            espera_jogada:       db_estado <= 4'b0011;  // 3
            registra:            db_estado <= 4'b0100;  // 4
            comparacao:          db_estado <= 4'b0101;  // 5
            proximo:             db_estado <= 4'b0110;  // 6
            is_ultima_sequencia: db_estado <= 4'b0111;  // 7
            proxima_sequencia:   db_estado <= 4'b1000;  // 8
            final_com_acerto:    db_estado <= 4'b1010;  // A
            final_com_erro:      db_estado <= 4'b1110;  // E
            
            //novos estados
            leds_on:             db_estado <= 4'b1001;  // 9
            leds_off:            db_estado <= 4'b1011;  // B
            is_ultimo_led:       db_estado <= 4'b1100;  // C
            proximo_led:         db_estado <= 4'b1101;  // D
            zera_endereco:       db_estado <= 4'b1111;  // F
            default:             db_estado <= 4'bzzzz;  // alta impedância (erro)
        endcase
    end


endmodule