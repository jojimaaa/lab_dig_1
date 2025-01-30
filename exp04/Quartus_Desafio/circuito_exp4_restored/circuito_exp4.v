module circuito_exp4 (
 input clock,
 input reset,
 input iniciar,
 input [3:0] chaves,
 output acertou,
 output errou,
 output pronto,
 output [3:0] leds,
 output db_igual,
 output [6:0] db_contagem,
 output [6:0] db_memoria,
 output [6:0] db_estado,
 output [6:0] db_jogadafeita,
 output db_clock,
 output db_iniciar,
 output db_tem_jogada,
 output db_timeout,
 output db_estado_espera
);

wire zeraC, zeraR, registraR, contaC, fimC, igual, jogada;
wire [3:0] s_contagem, s_memoria, s_jogada, s_estado, s_timeout;

fluxo_dados FD(
    .clock(clock),
    .zeraC(zeraC),
    .contaC(contaC),
    .zeraR(zeraR),
	 .estado_espera(estado_espera),
    .registraR(registraR),
    .chaves(chaves),
    .igual(igual),
    .fimC(fimC),
    .jogada_feita(jogada),
    .db_tem_jogada(db_tem_jogada),
    .db_contagem(s_contagem),
    .db_memoria(s_memoria),
    .db_jogada(s_jogada),
	 .db_timeout(s_timeout),
	 .db_estado_espera(db_estado_espera)
);

unidade_controle UC(
	 .timeout(s_timeout),
    .clock(clock),
    .reset(reset),
    .iniciar(iniciar),
    .fim(fimC),
    .jogada(jogada),
    .igual(igual),
    .zeraC(zeraC),
    .contaC(contaC),
    .zeraR(zeraR),
    .registraR(registraR),
    .acertou(acertou),
    .errou(errou),
    .pronto(pronto),
    .db_estado(s_estado),
	 .estado_espera(estado_espera)
);

hexa7seg HEX0(
    .hexa(s_contagem),
    .display(db_contagem)
);

hexa7seg HEX1(
    .hexa(s_memoria),
    .display(db_memoria)
);

hexa7seg HEX2(
    .hexa(s_jogada),
    .display(db_jogadafeita)
);


hexa7seg HEX5(
    .hexa(s_estado),
    .display(db_estado)
);


assign
    db_clock = clock,
    db_iniciar = iniciar,
    db_igual = igual,
    leds = chaves,
	 db_timeout = s_timeout;
endmodule