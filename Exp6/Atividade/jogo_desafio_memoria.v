module jogo_desafio_memoria (
input clock,
input reset,
input jogar,
input [3:0] botoes,
output [3:0] leds,
output ganhou,
output perdeu,
output pronto,
output timeout,

// acrescentar saidas de depuracao
output db_jogadaIgualMemoria,
output db_enderecoIgualSequencia,
output db_tem_jogada,
output db_fimS,

//display 7 segmentos
output [6:0] display_sequencia,
             display_jogada, 
             display_memoria, 
             display_endereco, 
             display_estado
);

//display 7 segmentos
wire [3:0]  s_endereco, 
		    s_sequencia, 
		    s_memoria, 
		    s_jogada, 
		    s_estado;

//ligação entre sinais
wire w_fimS,
     w_fimLedsOn,
     w_fimLedsOff,
     w_timeout,
     w_enderecoIgualSequencia,
     w_jogadaIgualMemoria,
     w_tem_jogada,
     w_zeraE,
     w_contaE,
     w_zeraR,
     w_registraR,
     w_zeraS,
     w_contaS,
     w_estado_espera,
     w_estado_ledsOn,
     w_estado_ledsOff;



unidade_controle UC (
 .clock(clock),
 .reset(reset),
 .iniciar(jogar),
 .fimS(w_fimS),
 .fimLedsOn(w_fimLedsOn),  //novo input
 .fimLedsOff(w_fimLedsOff), //novo input
 //input meioE, - caso precise de nível
 //input nivel, - caso precise de nível
 .timeout(w_timeout),
 .enderecoIgualSequencia(w_enderecoIgualSequencia),
 .tem_jogada(w_tem_jogada),
 .jogadaIgualMemoria(w_jogadaIgualMemoria),
 .zeraE(w_zeraE),
 .contaE(w_contaE),
 .zeraR(w_zeraR),
 .registraR(w_registraR),
 .zeraS(w_zeraS),
 .contaS(w_contaS),
 .acertou(ganhou), //ligação direta no output
 .errou(perdeu), //ligação direta no output
 .pronto(pronto), //ligaçao direta no output	
 .estado_espera(w_estado_espera),
 .estado_ledsOn(w_estado_ledsOn), //novo output
 .estado_ledsOff(w_estado_ledsOff), //novo output
 .db_estado(s_estado) //display
);

//TODO atualizar conexões
fluxo_dados FD (
 .clock(clock),
 .zeraE(w_zeraE),
 .contaE(w_contaE),
 .zeraS(w_zeraS),
 .contaS(w_contaS),
 .zeraR(w_zeraR),
 .estado_espera(w_estado_espera),
 .estado_ledsOn(w_estado_ledsOn), //novo input
 .estado_ledsOff(w_estado_ledsOff), //novo input
 .registraR(w_registraR),
 .chaves(botoes), //ligação direta no input
 .jogadaIgualMemoria(w_jogadaIgualMemoria),
 .enderecoIgualSequencia(w_enderecoIgualSequencia),
 .tem_jogada(w_tem_jogada),
 .fimS(w_fimS),
 .fimLedsOn(w_fimLedsOn), //novo output
 .fimLedsOff(w_fimLedsOff), //novo output
 .leds(leds), //novo output - ligação direta no output
 .timeout(w_timeout),
 //output meioE, - caso precise de nível
 .db_endereco(s_endereco), //display
 .db_sequencia(s_sequencia), //display
 .db_memoria(s_memoria), //display
 .db_jogada(s_jogada) //display
);


assign timeout = w_timeout;
//Sinais de depuração
assign db_tem_jogada = w_tem_jogada;
assign db_fimS = w_fimS;
assign db_jogadaIgualMemoria = w_jogadaIgualMemoria;
assign db_enderecoIgualSequencia = w_enderecoIgualSequencia;

hexa7seg HEX0 (
    .hexa(s_endereco),
    .display(display_endereco)
);

hexa7seg HEX1 (
    .hexa(s_memoria),
    .display(display_memoria)
);

hexa7seg HEX2 (
    .hexa(s_jogada),
    .display(display_jogada)
);

hexa7seg HEX3 (
    .hexa(s_sequencia),
    .display(display_sequencia)
);

hexa7seg HEX5 (
    .hexa(s_estado),
    .display(display_estado)
);


endmodule