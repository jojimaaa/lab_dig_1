module fluxo_dados_desafio  (
 input clock,
 input zeraE,
 input contaE,
 input zeraS,
 input contaS,
 input zeraR,
 input memoria, //novo input DESAFIO
 input nivel, //novo input exp7 - nivel
 input estado_espera,
 input estado_ledsOn, //novo input
 input estado_ledsOff, //novo input
 input macro_exibicao, //novo input exp7
 input macro_jogadas, //novo input exp7
 input registraR,
 input [3:0] chaves,
 input wildcard, //novo input DESAFIO P1
 output nivelChange, //novo output exp7 - nivelChange
 output memoriaChange, //novo output exp7 - memoriaChange
 output jogadaIgualMemoria,
 output enderecoIgualSequencia,
 output tem_jogada,
 output fimS,
 output fimLedsOn, //novo output
 output fimLedsOff, //novo output
 output [3:0] leds, //novo output
 output timeout,
 output meioE,      // - caso precise de nível
 output tem_coringa, //novo output DESAFIO P1
 output [3:0] db_endereco,
 output [3:0] db_sequencia,
 output [3:0] db_memoria,
 output [3:0] db_jogada
);

  wire[3:0] s_endereco, 
            s_sequencia, 
            s_memoria,
            s_memoria0,
            s_memoria1, 
            s_chaves,  // sinal interno para interligacao dos componentes
            s_regLeds; // indica o que o registrador de Leds está guardando
	
  wire zeraRegLed; //sinal para zerar o registrador de leds

  wire      s_jogada,
            s_tem_coringa,
            s_tem_jogada,
            w_zeraTimeout,
            s_timeout;  
	 
	 
    // contador endereço, também usado para o display dos leds
    contador_163 contadorE (
      .clock(clock),
      .clr(~zeraE),
      .ld(1'b1),
      .ent(1'b1),
      .enp(contaE),
      .D(4'b0000),
      .Q(s_endereco), 
      .rco(),
      .meio(meioE) // - caso precise de nível
    );


    // contador_m timer dos leds ligados
    contador_m #(.M(50), .N(9)) contadorLedsON (
        .clock(clock),
        .zera_as(zeraS),
        .zera_s(estado_ledsOff),
        .conta(estado_ledsOn),
        .Q(),
        .fim(fimLedsOn),
        .meio()
    );

    // contador_m timer dos leds desligados
    contador_m #(.M(50), .N(9)) contadorLedsOFF (
        .clock(clock),
        .zera_as(zeraS),
        .zera_s(estado_ledsOn),
        .conta(estado_ledsOff),
        .Q(),
        .fim(fimLedsOff),
        .meio()
    );

    // contador_m timer do timeout
   contador_m contadorm (
       .clock(clock),
       .zera_as(zeraE),
       .zera_s(w_zeraTimeout),
       .conta(estado_espera),
       .Q(),
       .fim(s_timeout),
       .meio()
    );
   assign w_zeraTimeout = s_tem_coringa || s_tem_jogada;

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

    // comparador jogada com memoria
    comparador_85 comparadorJ_M (
      .A(s_memoria),
      .B(s_chaves),
      .ALBi(1'b0),
      .AGBi(1'b0),
      .AEBi(1'b1),
      .ALBo(),
      .AGBo(),
      .AEBo(jogadaIgualMemoria)
    );

    // comparador endereço com sequencia
    comparador_85 comparadorE_S (
      .A(s_sequencia),
      .B(s_endereco),
      .ALBi(1'b0),
      .AGBi(1'b0),
      .AEBi(1'b1),
      .ALBo(),
      .AGBo(),
      .AEBo(enderecoIgualSequencia)
    );



    //memória0
    sync_rom_16x4 memoria_0 (
        .clock(clock),
        .address(s_endereco),
        .data_out(s_memoria0)
    );

    //memória1
    memoria1 memoria_1 (
      .clock(clock),
      .address(s_endereco),
      .data_out(s_memoria1)
    );


    //registrador_4 registra as chaves/jogada
    registrador_4 registrador (
        .clock(clock),
        .clear(zeraR),
        .enable(registraR),
        .D(chaves),
        .Q(s_chaves)
    );

    //registrador_4 registra o que será exibido nos leds
    registrador_4 registradorLeds (
        .clock(clock),
        .clear(zeraRegLed),
        .enable(estado_ledsOn),
        .D(s_memoria),
        .Q(s_regLeds)
    );

    // registrador_4 registra o timeout
    registrador_1 registradorTimeout (
        .clock(clock),
        .clear(zeraR),
        .enable(s_timeout),
        .D(s_timeout),
        .Q(timeout)
    );


    // edge_detector coringa
    edge_detector coringaDetector (
        .clock(clock),
        .reset(),
        .sinal(wildcard),
        .pulso(s_tem_coringa)
    );


    // edge_detector jogada
    edge_detector detector (
        .clock(clock),
        .reset(),
        .sinal(s_jogada),
        .pulso(s_tem_jogada)
    );
    assign s_jogada = chaves[3] || chaves[2] || chaves[1] || chaves[0];


    // full edge detector para o nivel
    full_edge_detector detectorNivel (
        .clock(clock),
        .reset(),
        .sinal(nivel),
        .pulso(nivelChange)
    );

    // full edge detector para a memoria
    full_edge_detector detectorMemoria (
        .clock(clock),
        .reset(),
        .sinal(memoria),
        .pulso(memoriaChange)
    );
	 
    // saida de depuracao
    assign db_endereco = s_endereco;
    assign db_memoria = s_memoria;
    assign db_jogada = s_chaves;
    assign db_sequencia = s_sequencia;
    assign leds = macro_exibicao ? s_regLeds : macro_jogadas ? chaves : 4'b1111;
    assign zeraRegLed = zeraR || estado_ledsOff || estado_espera;
   assign tem_coringa = s_tem_coringa;
   assign tem_jogada = s_tem_jogada;

   assign s_memoria = memoria ? s_memoria1 : s_memoria0;

endmodule