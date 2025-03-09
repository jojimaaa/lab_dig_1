module fluxo_dados (
 input clock,
 input zeraT,
 input zeraS,
 input contaS,
 input zeraR,
 input zeraA,
 input registraA,
 input nivel,
 input registraR,
 input zeraL,
 input registraL,
 input [3:0] botoes,
 output [3:0] acertoAnterior,
 output [3:0] jogadaAtual,
 output acertouJogada,
 output tem_jogada,
 output fimS,
 output [3:0] leds, //novo output
 output timeout,

//display 7 seg
 output [6:0] HEX0,
              HEX1, 
              HEX2, 
              HEX3, 
              HEX4,
              HEX5
);

  wire[3:0] s_sequencia, 
            s_memoriaLEDs,
            s_expected,
            s_jogadaAtual,  // sinal interno para interligacao dos componentes
            s_acertoAnterior,
            s_acertouJogada,
            s_regLeds; // indica o que o registrador de Leds está guardando
	

  wire      s_tem_jogada, 
            s_timeout, // sinal interno para interligacao dos componentes
            s_nivel;  


    // contador_m timer do timeout
   contador_m contadorm (
       .clock(clock),
       .zera_as(zeraT),
       .zera_s(),
       .conta(1'b1),
       .Q(),
       .fim(s_timeout),
       .meio()
    );

    // contador sequencia
    contador_163 contadorS (
      .clock(clock),
      .clr(~zeraS),
      .ld(1'b1),
      .ent(1'b1),
      .enp(contaS),
      .D(4'b0000),
      .Q(s_sequencia),
      .rco(fimS),
      .meio()
    );



    //memóriaLEDs
    memoriaLEDs0 memoria_0 (
        .clock(clock),
        .address(s_sequencia),
        .data_out(s_memoriaLEDs)
    );

    //memóriaJogadas
    memoriaFacil memoria_1 (
      .clock(clock),
      .address(s_memoriaLEDs),
      .data_out(s_expected)
    );


    //registrador_4 registra as botoes/jogada
    registrador_4 registrador (
        .clock(clock),
        .clear(zeraR),
        .enable(registraR),
        .D(botoes),
        .Q(s_jogadaAtual)
    );


    registrador_4 registradorAcertoAnterior (
        .clock(clock),
        .clear(zeraA),
        .enable(registraA),
        .D(s_jogadaAtual),
        .Q(s_acertoAnterior)
    );

    bigAND expectedANDbotoes (
        .A(s_jogadaAtual),
        .B(s_expected),
        .AandB(acertouJogada)
    );

    //registrador_4 registra o que será exibido nos leds
    registrador_4 registradorLeds (
        .clock(clock),
        .clear(zeraL),
        .enable(registraL),
        .D(s_memoriaLEDs),
        .Q(s_regLeds)
    );

    // registrador_4 registra o timeout
    registrador_1 registradorTimeout (
        .clock(clock),
        .clear(zeraT),
        .enable(s_timeout),
        .D(s_timeout),
        .Q(timeout)
    );


    //registrador para o nível
    registrador_1 registradorNivel (
        .clock(clock),
        .clear(zeraN),
        .enable(registraN),
        .D(nivel),
        .Q(s_nivel)
    );


    // edge_detector
    edge_detector detectorJogada (
        .clock(clock),
        .reset(),
        .sinal(s_tem_jogada),
        .pulso(tem_jogada)
    );
    assign s_tem_jogada = botoes[3] || botoes[2] || botoes[1] || botoes[0];


/*     edge_detector detectorAcertouJogada (
        .clock(clock),
        .reset(),
        .sinal(s_acertouJogada),
        .pulso(acertouJogada)
    ); */

	 
    hexa7seg hex0_converter (
        .hexa(w_endereco),
        .display(HEX0)
    );

    hexa7seg hex1_converter (
        .hexa(w_memoria),
        .display(HEX1)
    );

    hexa7seg hex2_converter (
        .hexa(w_jogada),
        .display(HEX2)
    );

    hexa7seg hex3_converter (
        .hexa(w_sequencia),
        .display(HEX3)
    );

    hexa7seg hex4_converter (
        .hexa(w_estado),
        .display(HEX4)
    );

    hexa7seg hex5_converter (
        .hexa(7'b0000001),
        .display(HEX5)
    );





    // saida de depuracao
    assign db_jogada = jogadaAtual;
    assign db_sequencia = s_sequencia;
    //assign timeout = s_timeout;
    assign leds = s_regLeds;
    assign acertoAnterior = s_acertoAnterior;
    assign jogadaAtual = s_jogadaAtual;

endmodule