module circuito_exp5 (
 input clock,
 input reset,
 input jogar,
 input [3:0] botoes,
 output [3:0] leds,
 output pronto,
 output ganhou,
 output perdeu,
 output db_jogadaIgualMemoria,
 output db_enderecoIgualSequencia,
 output db_tem_jogada,
 output[3:0] db_sequencia,
 output[3:0] db_endereco,
 output[3:0] db_memoria,
 output[3:0] db_estado,
 output [3:0] db_jogada,
 output [6:0] display_sequencia, display_jogada, display_memoria, display_endereco, display_estado,
 output db_fimS
);

wire[3:0] s_endereco, s_sequencia, s_dado, s_chaves;
wire tem_jogada;
wire fimS;
wire jogadaIgualMemoria;
wire enderecoIgualSequencia;
wire zeraE, contaE, zeraR, registraR, zeraS, contaS;


unidade_controle UC (
 .clock(clock),
 .reset(reset),
 .iniciar(jogar),
 .fimS(fimS),
 .enderecoIgualSequencia(enderecoIgualSequencia),
 .tem_jogada(tem_jogada),
 .jogadaIgualMemoria(jogadaIgualMemoria),
 .zeraE(zeraE),
 .contaE(contaE),
 .zeraR(zeraR),
 .registraR(registraR),
 .zeraS(zeraS),
 .contaS(contaS),
 .acertou(ganhou),
 .errou(perdeu),
 .pronto(pronto),
 .db_estado(db_estado)
);

fluxo_dados FD (
 .clock(clock),
 .zeraE(zeraE),
 .contaE(contaE),
 .zeraS(zeraS),
 .contaS(contaS),
 .zeraR(zeraR),
 .registraR(registraR),
 .chaves(botoes),
 .jogadaIgualMemoria(jogadaIgualMemoria),
 .enderecoIgualSequencia(enderecoIgualSequencia),
 .tem_jogada(tem_jogada),
 .fimS(fimS),
 .db_endereco(db_endereco),
 .db_sequencia(db_sequencia),
 .db_memoria(db_memoria),  
 .db_jogada(db_jogada)
);

//TODO
//Leds
assign leds = botoes;

//Sinais de depuração
assign db_tem_jogada = tem_jogada;
assign db_fimS = fimS;
assign db_sequencia = s_sequencia;
assign db_jogadaIgualMemoria = jogadaIgualMemoria;
assign db_enderecoIgualSequencia = enderecoIgualSequencia;

hexa7seg HEX0 (
    .hexa(db_endereco),
    .display(display_endereco)
);

hexa7seg HEX1 (
    .hexa(db_memoria),
    .display(display_memoria)
);

hexa7seg HEX2 (
    .hexa(db_jogada),
    .display(display_jogada)
);

hexa7seg HEX3 (
    .hexa(db_sequencia),
    .display(display_sequencia)
);

hexa7seg HEX5 (
    .hexa(db_estado),
    .display(display_estado)
);

endmodule