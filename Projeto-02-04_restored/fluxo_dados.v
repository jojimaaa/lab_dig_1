module fluxo_dados (
 input clock,
 input contaT,
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
 input mais,
 input menos,
 input registraR,
 input zeraL,
 input registraL,
 input displayFromMem,
 input [3:0] botoes,
 input [1:0] displayAddr,
 input apagarAcertos,
 input contaM,
 input zeraM,
 input [3:0] db_estado,
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
				  estado,

// saida de depuracao
  output[3:0]  db_jogada,
  output[3:0]  db_sequencia
);


  wire[1:0] s_acertosBin,
            s_acertosDecodificados;

  wire[3:0] s_sequencia,
            s_memoriaLEDs0,
            s_memoriaLEDs1,
            s_memoriaLEDs2,
            s_memoriaLEDs3,
            s_memoriaLEDs,
            s_memoria0,
            s_memoria1,
            s_memoria2,
            s_memoria3,
            s_expected,
            s_jogadaAtual,  // sinal interno para interligacao dos componentes
            s_acertoAnterior,
            s_acertouJogada,
            s_centenas,
            s_dezenas,
            s_unidades,
            s_regLeds; // indica o que o registrador de Leds está guardando
	
  wire [6:0] memHEX0, 
             memHEX1, 
             memHEX2, 
             memHEX3, 
             memHEX4, 
             memHEX5,
             timerHEX5,
             timerHEX4,
             timerHEX3;

  wire [8:0] s_timerOutput,
             s_timerDisplay;

  wire      s_tem_jogada, 
            s_timeout, // sinal interno para interligacao dos componentes
            s_contaPiscadasPulso,
            s_maisPulso,
            s_menosPulso,
            s_clockDiv;

  wire [1:0] s_modo;  


    edge_detector detectorMais (
        .clock(clock),
        .reset(),
        .sinal(mais),
        .pulso(s_maisPulso)
    );

    edge_detector detectorMenos (
        .clock(clock),
        .reset(),
        .sinal(menos),
        .pulso(s_menosPulso)
    );    

    contadorMaisMenos contadorModo(
        .clock(clock),
        .reset(zeraM),
        .enable(contaM),
        .mais(s_maisPulso),
        .menos(s_menosPulso),
        .Q(s_modo)
    );

    divisorClock divisorClock (
        .clock(clock),
        .rst(zeraT),
        .clockDiv(s_clockDiv)
    );

    // contador_m timer do timeout
   contador_m #(.M(300), .N(9)) contadorTimeout (
       .clock(s_clockDiv),
       .zera_as(zeraT),
       .zera_s(),
       .conta(contaT),
       .Q(s_timerOutput),
       .fim(s_timeout),
       .meio()
    );

    somador #(.N(9)) subtratorTimer7Seg (
        .a(9'd300),
        .b(s_timerOutput),
        .clk(clock),
        .sum(1'b0),
        .enable(contaT),
        .result(s_timerDisplay)
    );

    binaryTObcd binaryTObcd (
        .bin(s_timerDisplay),
        .clock(clock),
        .rst(zeraT),
        .centenas(s_centenas),
        .dezenas(s_dezenas),
        .unidades(s_unidades)
    );

    displayMem displayMem (
        .clock(clock),
        .displayAddr(displayAddr),
        .modo(s_modo),

        .HEX0(memHEX0),
        .HEX1(memHEX1),
        .HEX2(memHEX2),
        .HEX3(memHEX3),
        .HEX4(memHEX4),
        .HEX5(memHEX5)
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
      .rco(),
      .meio(fimS)
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
    memoriaLEDs0 memoriaLEDs0 (
        .clock(clock),
        .address(s_sequencia),
        .data_out(s_memoriaLEDs0)
    );

    memoriaLEDs1 memoriaLEDs1 (
        .clock(clock),
        .address(s_sequencia),
        .data_out(s_memoriaLEDs1)
    );

    memoriaLEDs2 memoriaLEDs2 (
        .clock(clock),
        .address(s_sequencia),
        .data_out(s_memoriaLEDs2)
    );

    memoriaLEDs3 memoriaLEDs3 (
        .clock(clock),
        .address(s_sequencia),
        .data_out(s_memoriaLEDs3)
    );

    //memóriaJogadas
    memoria0 memoria0 (
      .clock(clock),
      .address(s_memoriaLEDs),
      .data_out(s_memoria0)
    );

    memoria1 memoria1 (
      .clock(clock),
      .address(s_memoriaLEDs),
      .data_out(s_memoria1)
    );

    memoria2 memoria2 (
      .clock(clock),
      .address(s_memoriaLEDs),
      .data_out(s_memoria2)
    );

    memoria3 memoria3 (
      .clock(clock),
      .address(s_memoriaLEDs),
      .data_out(s_memoria3)
    );

    mux_4x1 muxLEDS (
        .in0(s_memoriaLEDs0),
        .in1(s_memoriaLEDs1),
        .in2(s_memoriaLEDs2),
        .in3(s_memoriaLEDs3),
        .sel(s_modo),
        .out(s_memoriaLEDs)
    );

    mux_4x1 muxMemorias (
        .in0(s_memoria0),
        .in1(s_memoria1),
        .in2(s_memoria2),
        .in3(s_memoria3),
        .sel(s_modo),
        .out(s_expected)
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

	 

    hexa7seg hex3_converter (
        .hexa(s_unidades),
        .display(timerHEX3)
    );

    hexa7seg hex4_converter (
        .hexa(s_dezenas),
        .display(timerHEX4)
    );

    hexa7seg hex5_converter (
        .hexa(s_centenas),
        .display(timerHEX5)
    );


	 hexa7seg state_converter (
        .hexa(db_estado),
        .display(estado)
    );


    //MUX acertos
    assign acertos = apagarAcertos ? 2'b00 : s_acertosDecodificados; 


    //MUX display
    assign HEX0 = memHEX0;
    assign HEX1 = memHEX1;
    assign HEX2 = memHEX2;
    assign HEX3 = displayFromMem ? memHEX3 : contaT ? timerHEX3 : 7'b1111111;
    assign HEX4 = displayFromMem ? memHEX4 : contaT ? timerHEX4 : 7'b1111111;
    assign HEX5 = displayFromMem ? memHEX5 : contaT ? timerHEX5 : 7'b1111111;


    // saida de depuracao
    assign db_jogada = s_jogadaAtual;
    assign db_sequencia = s_sequencia;
    //assign timeout = s_timeout;
    //assign leds = s_regLeds;
	 assign leds = s_memoriaLEDs;
    assign acertoAnterior = s_acertoAnterior;

endmodule