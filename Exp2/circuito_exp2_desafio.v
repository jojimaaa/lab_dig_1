module circuito_exp2_desafio (clock, zera, carrega, conta, chaves, 
                            menor, maior, igual, fim, db_contagem);
    input        clock;
    input        zera;
    input        carrega;
    input        conta;
    input  [3:0] chaves;
    output       menor;
    output       maior;
    output       igual;
    output       fim;
    output [6:0] db_contagem;

    wire   [3:0] s_contagem;  // sinal interno para interligacao dos componentes

    // contador_163
    contador_163 contador (
      .clock( clock ),
      .clr  ( ~zera ),
      .ld   ( ~carrega ),
      .ent  ( 1'b1 ),
      .enp  ( conta ),
      .D    ( chaves ),
      .Q    ( s_contagem ),
      .rco  ( fim )
    );

    // comparador_85
    comparador_85 comparador (
      .A   ( s_contagem ),
      .B   ( chaves ),
      .ALBi( 1'b0 ),
      .AGBi( 1'b0 ),
      .AEBi( 1'b1 ),
      .ALBo( menor ),
      .AGBo( maior ),
      .AEBo( igual )
    );

    // saida de depuracao
	 
hexa7seg hexa (
		.hexa    (s_contagem),
		.display (db_contagem),
);
 
endmodule

