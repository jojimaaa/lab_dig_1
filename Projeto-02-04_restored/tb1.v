// Autor: Enzo Koichi Jojima - 14568285
// Adaptado do modelo de testbench do Prof. Dr. Edson Midorikawa
`timescale 1us/1us

module tb1;

    // Sinais para conectar com o DUT
    // valores iniciais para fins de simulacao (ModelSim)
    reg        clock_in   = 1;
    reg        reset_in   = 0;
    reg        iniciar_in = 0;
    reg        confirma_in = 0;
    reg  [3:0] chaves_in  = 4'b0000;
    reg        mais_in   = 0;
    reg        menos_in = 0;

    wire       pronto_out ;
    wire [3:0] leds_out   ;
	  wire       timeout_out;
    wire [1:0] acertos_out;

    // Sinais de depuracao
    wire [3:0] db_estado;
    wire       db_acertouJogada;
    wire       db_jogadaAtualEQUALSacertoAnterior;
    wire       db_acertoAnteriorEQUALSzero;
    wire [3:0] db_jogada;
    wire [3:0] db_sequencia;

    // Configuração do clock
    parameter clockPeriod = 1_000; // f=1KHz

    // Identificacao do caso de teste
    reg [31:0] caso = 0;

    // Gerador de clock
    always #((clockPeriod / 2)) clock_in = ~clock_in;

    // instanciacao do DUT (Device Under Test)
    neurosync DUT (

        // sinais de entrada
        .clock(clock_in),
        .reset(reset_in),
        .jogar(iniciar_in),
        .mais(mais_in),
        .menos(menos_in),
        .confirma(confirma_in),
        .botoes(chaves_in),
        .acertos(acertos_out),

        // sinais de saida
        .leds(leds_out),
        .pronto(pronto_out),
        .timeout(timeout_out),

        // sinais de depuracao
        //.db_estado(db_estado),
        //.db_acertouJogada(db_acertouJogada),
        //.db_jogadaAtualEQUALSacertoAnterior(db_jogadaAtualEQUALSacertoAnterior),
       // .db_acertoAnteriorEQUALSzero(db_acertoAnteriorEQUALSzero),
       // .db_jogada(db_jogada),
        //.db_sequencia(db_sequencia),

        // sinais de display 7 segmentos
        .HEX0(),
        .HEX1(),
        .HEX2(),
        .HEX3(),
        .HEX4(),
        .HEX5()
    );

    // geracao dos sinais de entrada (estimulos)
    initial begin
      $display("Inicio da simulacao");

      // condicoes iniciais
      caso       = 0;
      clock_in   = 1;
      reset_in   = 0;
      iniciar_in = 0;
      chaves_in  = 4'b0000;
      mais_in   = 0;
      menos_in = 0;
      confirma_in = 0;
      #clockPeriod;
       
       
       /*
       * Teste
       */

       // Teste 1. resetar circuito
      caso = 1;
      // gera pulso de reset
      @(negedge clock_in);
      reset_in = 1;
      #(clockPeriod);
      reset_in = 0;
      // espera
      #(10*clockPeriod);


      // Teste 2. iniciar=1 por 5 periodos de clock
      caso = 2;
      iniciar_in = 1;
      #(5*clockPeriod);
      iniciar_in = 0;
      // espera
      #(5000*clockPeriod);

      // Teste 3. configurar nível
      caso = 3;
      mais_in   = 1;
      #(10*clockPeriod);
      mais_in   = 0;
      #(10*clockPeriod);
      mais_in = 1;
      #(10*clockPeriod);
      mais_in = 0;
      #(10*clockPeriod);
      menos_in = 1;
      #(10*clockPeriod);
      menos_in = 0;
      #(10*clockPeriod);
		menos_in = 1;
      #(10*clockPeriod);
      menos_in = 0;
      #(10*clockPeriod);
      confirma_in = 1;
      #(10*clockPeriod);
      confirma_in = 0;
      #(1000*clockPeriod);

      // Teste 4. fazer primeira jogada
        caso = 4;
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 5. fazer a mesma jogada jogada
        caso = 5;
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 6. fazer a segunda jogada
        caso = 6;
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 7. fazer a segunda rodada
        caso = 7;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0010;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 8. fazer a terceira rodada
        caso = 8;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 9. fazer a quarta rodada
        caso = 9;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 10. fazer a quinta rodada
        caso = 10;
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 11. fazer a sexta rodada
        caso = 11;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0010;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 12. fazer a sétima rodada
        caso = 12;
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);


        // Teste 13. fazer a oitava rodada
        caso = 13;
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 14. fazer a nona rodada
        caso = 14;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0010;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 15. fazer a décima rodada
        caso = 15;
        chaves_in = 4'b0010;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);  
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 16. fazer a décima primeira rodada
        caso = 16;
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 17. fazer a décima segunda rodada
        caso = 17;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 18. fazer a décima terceira rodada
        caso = 18;
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 19. fazer a décima quarta rodada
        caso = 19;
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 20. fazer a décima quinta rodada
        caso = 20;
        chaves_in = 4'b1000;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 21. fazer a décima sexta rodada
        caso = 21;
        chaves_in = 4'b0001;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(10*clockPeriod);
        chaves_in = 4'b0100;
        #(10*clockPeriod);
        chaves_in = 4'b0000;
        #(5000*clockPeriod);

        // Teste 22. timeout
        caso = 22;
        iniciar_in = 1;
        #(10*clockPeriod);
        iniciar_in = 0;
        #(10*clockPeriod);
        confirma_in = 1;
        #(10*clockPeriod);
        confirma_in = 0;
        #(10*clockPeriod);

      // final dos casos de teste da simulacao
      #100;
      $display("Fim da simulacao");
      $stop;
    end

  endmodule