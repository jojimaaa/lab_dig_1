

module circuito_exp3 (
    input clock,
    input reset,
    input iniciar,
    input [3:0] chaves,
    output pronto,
    output db_igual,
    output db_iniciar,
	 output db_zeraC,
	 output db_contaC,
	 output db_fimC,
	 output db_zeraR,
	 output db_registraR,
    output [6:0] db_contagem,
    output [6:0] db_memoria,
    output [6:0] db_chaves,
    output [6:0] db_estado
);

    wire contaC, zeraC, zeraR, registraR, fimC;
    wire [3:0] s_contagem, s_memoria, s_chaves, s_estado;

    exp3_unidade_controle uc (
        .clock(clock),
        .reset(reset),
        .iniciar(iniciar),
        .fimC(fimC),
        .zeraC(zeraC),
        .contaC(contaC),
        .zeraR(zeraR),
        .registraR(registraR),
        .pronto(pronto),
        .db_estado(s_estado)
    );

    exp3_fluxo_dados fd (
        .clock(clock),
        .chaves(chaves),
        .zeraR(zeraR),
        .registraR(registraR),
        .contaC(contaC),
        .zeraC(zeraC),
        .chavesIgualMemoria(db_igual),
        .fimC(fimC),
        .db_contagem(s_contagem),
        .db_chaves(s_chaves),
        .db_memoria(s_memoria)
    );

    hexa7seg HEX2 (
        .hexa(s_chaves),
        .display(db_chaves)
    );

    hexa7seg HEX0 (
        .hexa(s_contagem),
        .display(db_contagem)
    );

    hexa7seg HEX1 (
        .hexa(s_memoria),
        .display(db_memoria)
    );

    hexa7seg HEX5 (
        .hexa(s_estado),
        .display(db_estado)
    );
	 
	 assign db_zeraC = zeraC;
	 assign db_contaC = contaC;
	 assign db_fimC = fimC;
	 assign db_zeraR = zeraR;
	 assign db_registraR = registraR;
	 assign db_iniciar = iniciar;
	 

endmodule