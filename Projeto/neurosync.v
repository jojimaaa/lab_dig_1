module neurosync (
input clock,
input reset,
input jogar,
input nivel,
input confirma,
input [3:0] botoes,
output [3:0] leds,
output [1:0] acertos,
output pronto,
output timeout,

//depuração
output [3:0] db_estado,
output db_acertouJogada,

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
     w_fimLedsOff,
     w_fimLedsOn,
     w_fimPiscaLeds,
     w_contaA,
     w_contaPiscadas,
     w_contaLedsOn,
     w_contaLedsOff,
     w_jogadaAtualEQUALSacertoAnterior,
     w_acertoAnteriorEQUALSzero,
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
 .jogadaAtualEQUALSacertoAnterior(),
 .acertoAnteriorEQUALSzero(),
 .fimPiscaLeds(w_fimPiscaLeds),
 .fimLedsOn(w_fimLedsOn),
 .fimLedsOff(w_fimLedsOff),
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
 .timeout_out(timeout),


 .db_estado(db_estado)
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
 .contaA(),
 .contaPiscadas(),
 .contaLedsOn(),
 .contaLedsOff(),
 .nivel(nivel),
 .registraR(w_registraR),
 .zeraL(w_zeraL),
 .registraL(w_registraL),
 .botoes(botoes),
 .jogadaAtualEQUALSacertoAnterior(),
 .acertoAnteriorEQUALSzero(),
 .acertouJogada(w_acertouJogada),
 .tem_jogada(w_tem_jogada),
 .fimS(w_fimS),
 .fimLedsOff(),
 .fimLedsOn(),
 .leds(leds),
 .acertos(acertos),
 .timeout(w_timeout),

//display 7 seg
 .HEX0(HEX0),
 .HEX1(HEX1), 
 .HEX2(HEX2), 
 .HEX3(HEX3), 
 .HEX4(HEX4),
 .HEX5(HEX5),

// saida de depuracao
 .db_jogada(),
 .db_sequencia()
);

assign db_acertouJogada = w_acertouJogada;

endmodule