module fluxo_dados (
 input clock,
 input zeraE,
 input contaE,
 input zeraS,
 input contaS,
 input zeraR,
 input registraR,
 input [3:0] chaves,
 output jogadaIgualMemoria,
 output enderecoIgualSequencia,
 //output fimE,
 output tem_jogada,
 output fimS,
 output [3:0] db_endereco,
 output [3:0] db_sequencia,
 output [3:0] db_memoria,
 output [3:0] db_jogada
);

  wire[3:0] s_endereco, s_sequencia, s_dado, s_chaves;  // sinal interno para interligacao dos componentes
	wire s_tem_jogada;
	 
	 
    // contador endereço
    contador_163 contadorE (
      .clock(clock),
      .clr(~zeraE),
      .ld(1'b1),
      .ent(1'b1),
      .enp(contaE),
      .D(4'b0000),
      .Q(s_endereco),
      .rco()
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
      .rco(fimS)
    );

    // comparador jogada com memoria
    comparador_85 comparadorJ_M (
      .A(s_dado),
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



    //memória
    sync_rom_16x4 memoria (
        .clock(clock),
        .address(s_endereco),
        .data_out(s_dado)
    );


    //registrador_4
    registrador_4 registrador (
        .clock(clock),
        .clear(zeraR),
        .enable(registraR),
        .D(chaves),
        .Q(s_chaves)
    );


    // edge_detector
    edge_detector detector (
        .clock(clock),
        .reset(),
        .sinal(s_tem_jogada),
        .pulso(tem_jogada)
    );
    assign s_tem_jogada = chaves[3] || chaves[2] || chaves[1] || chaves[0];

	 
    // saida de depuracao
    assign db_endereco = s_endereco;
    assign db_memoria = s_dado;
    assign db_jogada = s_chaves;
    assign db_sequencia = s_sequencia;

endmodule