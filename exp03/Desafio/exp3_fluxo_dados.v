
module exp3_fluxo_dados (
    input clock,
    input [3:0] chaves,
    input zeraR,
    input registraR,
    input contaC,
    input zeraC,
    output chavesIgualMemoria,
    output fimC,
    output [3:0] db_contagem,
    output [3:0] db_chaves,
    output [3:0] db_memoria
);

    wire[3:0] s_endereco, s_dado, s_chaves;  // sinal interno para interligacao dos componentes

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
      .AEBo(chavesIgualMemoria)
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

    // saida de depuracao
    assign db_contagem = s_endereco;
    assign db_memoria = s_dado;
    assign db_chaves = s_chaves;
endmodule