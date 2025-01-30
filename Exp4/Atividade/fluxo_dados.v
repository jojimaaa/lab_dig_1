module fluxo_dados (
 input clock,
 input zeraC,
 input contaC,
 input zeraR,
 input registraR,
 input [3:0] chaves,
 output igual,
 output fimC,
 output jogada_feita,
 output db_tem_jogada,
 output [3:0] db_contagem,
 output [3:0] db_memoria,
 output [3:0] db_jogada
);

    wire[3:0] s_endereco, s_dado, s_chaves;  // sinal interno para interligacao dos componentes

    wire s_tem_jogada;

    // contador_163
    contador_163 contador (
      .clock(clock),
      .clr(~zeraC),
      .ld(1'b1),
      .ent(1'b1),
      .enp(contaC),
      .D(4'b0000),
      .Q(s_endereco),
      .rco(fimC)
    );

    // comparador_85
    comparador_85 comparador (
      .A(s_dado),
      .B(s_chaves),
      .ALBi(1'b0),
      .AGBi(1'b0),
      .AEBi(1'b1),
      .ALBo(),
      .AGBo(),
      .AEBo(igual)
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
        .pulso(jogada_feita)
    );
    assign s_tem_jogada = chaves[3] || chaves[2] || chaves[1] || chaves[0];

    // saida de depuracao
    assign db_contagem = s_endereco;
    assign db_memoria = s_dado;
    assign db_jogada = s_chaves;
    assign db_tem_jogada = s_tem_jogada;
endmodule