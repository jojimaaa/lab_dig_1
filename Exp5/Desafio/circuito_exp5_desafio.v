module circuito_exp5_desafio (
 input clock,
 input reset,
 input jogar,
 input nivel,
 input [3:0] botoes,
 output [3:0] leds,
 output pronto,
 output ganhou,
 output perdeu,
 output db_jogadaIgualMemoria,
 output db_enderecoIgualSequencia,
 output db_tem_jogada,
 output db_timeout,
// output[3:0] db_sequencia,
// output[3:0] db_endereco,
// output[3:0] db_memoria,
// output[3:0] db_estado,
// output [3:0] db_jogada,
 output [6:0] display_sequencia, display_jogada, display_memoria, display_endereco, display_estado,
 output db_fimS
);

wire [3:0] s_endereco, 
				s_sequencia, 
				s_memoria, 
				s_jogada, 
				s_estado;
wire tem_jogada;
wire s_timeout;
wire fimS;
wire jogadaIgualMemoria;
wire enderecoIgualSequencia;
wire zeraE, contaE, zeraR, registraR, zeraS, contaS, s_estado_espera;
wire s_meioE;


unidade_controle_desafio UC (
 .clock(clock),
 .reset(reset),
 .iniciar(jogar),
 .fimS(fimS),
 .timeout(s_timeout),
 .nivel(nivel),
 .meioE(s_meioE),
 .enderecoIgualSequencia(enderecoIgualSequencia),
 .tem_jogada(tem_jogada),
 .jogadaIgualMemoria(jogadaIgualMemoria),
 .zeraE(zeraE),
 .contaE(contaE),
 .zeraR(zeraR),
 .registraR(registraR),
 .zeraS(zeraS),
 .contaS(contaS),
 .estado_espera(s_estado_espera),
 .acertou(ganhou),
 .errou(perdeu),
 .pronto(pronto),
 
 .db_estado(s_estado)
);

fluxo_dados_desafio FD (
 .clock(clock),
 .zeraE(zeraE),
 .contaE(contaE),
 .estado_espera(s_estado_espera),
 .zeraS(zeraS),
 .contaS(contaS),
 .zeraR(zeraR),
 .registraR(registraR),
 .chaves(botoes),
 .jogadaIgualMemoria(jogadaIgualMemoria),
 .enderecoIgualSequencia(enderecoIgualSequencia),
 .tem_jogada(tem_jogada),
 .fimS(fimS),
 .meioE(s_meioE),
 
 .db_endereco(s_endereco),
 .db_sequencia(s_sequencia),
 .db_memoria(s_memoria),  
 .db_jogada(s_jogada),
 .db_timeout(s_timeout)
);

//TODO
//Leds
assign leds = botoes;

//Sinais de depuração
assign db_tem_jogada = tem_jogada;
assign db_fimS = fimS;
assign db_timeout = s_timeout;
assign db_jogadaIgualMemoria = jogadaIgualMemoria;
assign db_enderecoIgualSequencia = enderecoIgualSequencia;

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