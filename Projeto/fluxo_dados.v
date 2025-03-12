module fluxo_dados (
 input clock,
 input zeraT,
 input zeraS,
 input contaS,
 input zeraR,
 input zeraA,
 input registraA,
 input contaA,
 input contaPiscadas,
 input contaLedsOn,
 input contaLedsOff,
 input nivel,
 input registraR,
 input zeraL,
 input registraL,
 input [3:0] botoes,
 input apagarAcertos,
 output acertouJogada,
 output jogadaAtualEQUALSacertoAnterior,
 output acertoAnteriorEQUALSzero,
 output tem_jogada,
 output fimS,
 output fimLedsOff,
 output fimLedsOn,
 output fimPiscaLeds,
 output [3:0] leds, //novo output
 output [1:0] acertos,
 output timeout,

//display 7 seg
 output [6:0] HEX0,
              HEX1, 
              HEX2, 
              HEX3, 
              HEX4,
              HEX5,

// saida de depuracao
  output[3:0]  db_jogada,
  output[3:0]  db_sequencia
);


  wire[1:0] s_acertosBin,
            s_acertosDecodificados;

  wire[3:0] s_sequencia, 
            s_memoriaLEDs,
            s_expected,
            s_jogadaAtual,  // sinal interno para interligacao dos componentes
            s_acertoAnterior,
            s_acertouJogada,
            s_regLeds; // indica o que o registrador de Leds está guardando
	

  wire      s_tem_jogada, 
            s_timeout, // sinal interno para interligacao dos componentes
            s_contaPiscadasPulso,
            s_nivel;  


    // contador_m timer do timeout
   contador_m #(.M(300000), .N(32)) contadorTimeout (
       .clock(clock),
       .zera_as(zeraT),
       .zera_s(),
       .conta(1'b1),
       .Q(),
       .fim(s_timeout),
       .meio()
    );

    // contador_m timer dos leds ligados
    contador_m #(.M(500), .N(9)) contadorLedsON (
        .clock(clock),
        .zera_as(zeraA),
        .zera_s(contaLedsOff),
        .conta(contaLedsOn),
        .Q(),
        .fim(fimLedsOn),
        .meio()
    );

    // contador_m timer dos leds desligados
    contador_m #(.M(500), .N(9)) contadorLedsOFF (
        .clock(clock),
        .zera_as(zeraA),
        .zera_s(contaLedsOn),
        .conta(contaLedsOff),
        .Q(),
        .fim(fimLedsOff),
        .meio()
    );

    contador_m #(.M(3), .N(2)) contadorPiscadas (
        .clock(clock),
        .zera_as(zeraA),
        .zera_s(),
        .conta(s_contaPiscadasPulso),
        .Q(),
        .fim(fimPiscaLeds),
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

    //contador acertos
    contador_m #(.M(3), .N(2)) contadorAcertos (
       .clock(clock),
       .zera_as(zeraA),
       .zera_s(),
       .conta(contaA),
       .Q(s_acertosBin),
       .fim(),
       .meio()
    );

    //decodificador acertos
    decodificadorAcertos decodificadorAcertos(
        .acertosBin(s_acertosBin),
        .acertosLeds(s_acertosDecodificados)
    );

    comparador_85 comparador_jogadaAtual_acertoAnterior (
      .A(s_jogadaAtual),
      .B(s_acertoAnterior),
      .ALBi(1'b0),
      .AGBi(1'b0),
      .AEBi(1'b1),
      .ALBo(),
      .AGBo(),
      .AEBo(jogadaAtualEQUALSacertoAnterior)
    );

    comparador_85 comparador_acertoAnterior_zero (
      .A(4'b0000),
      .B(s_acertoAnterior),
      .ALBi(1'b0),
      .AGBi(1'b0),
      .AEBi(1'b1),
      .ALBo(),
      .AGBo(),
      .AEBo(acertoAnteriorEQUALSzero)
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



    edge_detector detectorContaPiscadas (
        .clock(clock),
        .reset(),
        .sinal(contaPiscadas),
        .pulso(s_contaPiscadasPulso)
    );

	 
    hexa7seg hex0_converter (
        .hexa(),
        .display(HEX0)
    );

    hexa7seg hex1_converter (
        .hexa(),
        .display(HEX1)
    );

    hexa7seg hex2_converter (
        .hexa(),
        .display(HEX2)
    );

    hexa7seg hex3_converter (
        .hexa(),
        .display(HEX3)
    );

    hexa7seg hex4_converter (
        .hexa(),
        .display(HEX4)
    );

    hexa7seg hex5_converter (
        .hexa(),
        .display(HEX5)
    );



    //MUX acertos
    assign acertos = apagarAcertos ? 2'b00 : s_acertosDecodificados; 



    // saida de depuracao
    assign db_jogada = s_jogadaAtual;
    assign db_sequencia = s_sequencia;
    //assign timeout = s_timeout;
    assign leds = s_regLeds;
    assign acertoAnterior = s_acertoAnterior;

endmodule