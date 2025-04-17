module neurosync (    
input clock,
input reset,
input jogar,
input mais,
input menos,
input confirma,
input [3:0] botoes,

output [3:0] leds,
output [3:0] db_botoes,
output db_mais,
output db_menos,
output db_confirma,
output db_jogar,
output db_reset,
output db_clock,
output [1:0] acertos,
output pronto,
output timeout,

//depuração
output [6:0] estado,
//output db_acertouJogada,
//output db_jogadaAtualEQUALSacertoAnterior,
//output db_acertoAnteriorEQUALSzero,
//output [3:0] db_jogada,
//output [3:0] db_sequencia,

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
     w_apagarAcertos,
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
     w_zeraL,
     w_contaT,
     w_displayFromMem,
     w_contaM,
     w_zeraM,
     w_registraL;

wire [1:0] w_displayAddr;
wire s_clockDiv;

assign db_botoes = botoes;
assign db_confirma = confirma;
assign db_mais = mais;
assign db_menos = menos;
assign db_jogar = jogar;
assign db_reset = reset;

wire [3:0] w_estado;


//    divisorClockFPGA divisorClockFPGA (
//        .clock(clock),
//        .rst(),
//        .clockDiv(s_clockDiv)
//    );

	assign s_clockDiv = clock;
	 
	 assign db_clock = s_clockDiv;


unidade_controle UC (
 .clock(s_clockDiv),
 .reset(~reset),
 .jogar(~jogar),
 .fimS(w_fimS),
 .confirma(~confirma),
 .timeout(w_timeout),
 .tem_jogada(w_tem_jogada),
 .acertouJogada(w_acertouJogada),
 .jogadaAtualEQUALSacertoAnterior(w_jogadaAtualEQUALSacertoAnterior),
 .acertoAnteriorEQUALSzero(w_acertoAnteriorEQUALSzero),
 .fimPiscaLeds(w_fimPiscaLeds),
 .fimLedsOn(w_fimLedsOn),
 .fimLedsOff(w_fimLedsOff),
 .zeraT(w_zeraT),
 .contaT(w_contaT),
 .zeraR(w_zeraR),
 .registraR(w_registraR),
 .zeraS(w_zeraS),
 .contaS(w_contaS),
 .zeraA(w_zeraA),
 .registraA(w_registraA),
 .contaA(w_contaA),
 .zeraL(w_zeraL),
 .registraL(w_registraL),
 .displayAddr(w_displayAddr),
 .displayFromMem(w_displayFromMem),
 .pronto(pronto),
 .contaLedsOn(w_contaLedsOn),
 .contaLedsOff(w_contaLedsOff),
 .contaPiscadas(w_contaPiscadas),
 .timeout_out(timeout),
 .apagarAcertos(w_apagarAcertos),
 .contaM(w_contaM),
 .zeraM(w_zeraM),

    //depuração
 .db_estado(w_estado)
);

//TODO atualizar conexões
fluxo_dados FD (
 .clock(s_clockDiv),
 .zeraT(w_zeraT),
 .contaT(w_contaT),
 .zeraS(w_zeraS),
 .contaS(w_contaS),
 .zeraR(w_zeraR),
 .zeraA(w_zeraA),
 .registraA(w_registraA),
 .contaA(w_contaA),
 .contaPiscadas(w_contaPiscadas),
 .contaLedsOn(w_contaLedsOn),
 .contaLedsOff(w_contaLedsOff),
 .mais(~mais),
 .menos(~menos),
 .registraR(w_registraR),
 .zeraL(w_zeraL),
 .registraL(w_registraL),
 .displayFromMem(w_displayFromMem),
 .botoes(~botoes),
 .displayAddr(w_displayAddr),
 .apagarAcertos(w_apagarAcertos),
 .contaM(w_contaM),
 .zeraM(w_zeraM),
 .db_estado(w_estado),
 .acertouJogada(w_acertouJogada),
 .jogadaAtualEQUALSacertoAnterior(w_jogadaAtualEQUALSacertoAnterior),
 .acertoAnteriorEQUALSzero(w_acertoAnteriorEQUALSzero),
 .tem_jogada(w_tem_jogada),
 .fimS(w_fimS),
 .fimLedsOff(w_fimLedsOff),
 .fimLedsOn(w_fimLedsOn),
 .fimPiscaLeds(w_fimPiscaLeds),
 .leds(leds),
 .acertos(acertos),
 .timeout(w_timeout),
 .estado(estado),

//display 7 seg
 .HEX0(HEX0),
 .HEX1(HEX1), 
 .HEX2(HEX2), 
 .HEX3(HEX3), 
 .HEX4(HEX4),
 .HEX5(HEX5)

// saida de depuracao
// .db_jogada(db_jogada),
// .db_sequencia(db_sequencia)
);

//assign db_acertouJogada = w_acertouJogada;
//assign db_jogadaAtualEQUALSacertoAnterior = w_jogadaAtualEQUALSacertoAnterior;
//assign db_acertoAnteriorEQUALSzero = w_acertoAnteriorEQUALSzero;


endmodule