module neurosync (
input clock,
input reset,
input jogar,
input nivel,
input confirma,
input [3:0] botoes,
output [3:0] leds,
output pronto,
output timeout,

//display 7 segmentos
output [6:0] HEX0,
             HEX1, 
             HEX2, 
             HEX3, 
             HEX4,
             HEX5
);

//ligação entre sinais
wire w_fimS,
     w_timeout,
     w_tem_jogada,
     w_acertouJogada,
     w_zeraT,
     w_zeraR,
     w_registraR,
     w_zeraS,
     w_contaS,
     w_zeraA,
     w_registraA,
     w_zeraN,
     w_registraN,
     w_zeraL,
     w_registraL;

wire [3:0] w_jogadaAtual,
          w_acertoAnterior;



unidade_controle UC (
 .clock(clock),
 .reset(reset),
 .jogar(jogar),
 .fimS(w_fimS),
 .confirma(confirma),
 .nivel(nivel),
 .timeout(w_timeout),
 .acertoAnterior(w_acertoAnterior),
 .jogadaAtual(w_jogadaAtual),
 .tem_jogada(w_tem_jogada),
 .acertouJogada(w_acertouJogada),
 .zeraT(w_zeraT),
 .zeraR(w_zeraR),
 .registraR(w_registraR),
 .zeraS(w_zeraS),
 .contaS(w_contaS),
 .zeraA(w_zeraA),
 .registraA(w_registraA),
 .zeraN(w_zeraN),
 .registraN(w_registraN),
 .zeraL(w_zeraL),
 .registraL(w_registraL),
 .displayAddr(),
 .pronto(pronto),
 .db_estado(),
 .timeout_out(timeout)
);

//TODO atualizar conexões
fluxo_dados FD (
 .clock(clock),
 .zeraT(w_zeraT),
 .zeraS(w_zeraS),
 .contaS(w_contaS),
 .zeraR(w_zeraR),
 .zeraA(w_zeraA),
 .registraA(w_registraA),
 .nivel(nivel),
 .registraR(w_registraR),
 .zeraL(w_zeraL),
 .registraL(w_registraL),
 .botoes(botoes),
 .acertoAnterior(w_acertoAnterior),
 .jogadaAtual(w_jogadaAtual),
 .acertouJogada(w_acertouJogada),
 .tem_jogada(w_tem_jogada),
 .fimS(w_fimS),
 .leds(leds),
 .timeout(w_timeout),

//display 7 seg
 .HEX0(HEX0),
 .HEX1(HEX1), 
 .HEX2(HEX2), 
 .HEX3(HEX3), 
 .HEX4(HEX4),
 .HEX5(HEX5)
);


endmodule