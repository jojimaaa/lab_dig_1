`timescale 1ns/1ns

module jogo_tb2;

    // Sinais para conectar com o DUT
    // valores iniciais para fins de simulacao (ModelSim)
    //reg        nivel_in = 1'b1;
    reg        clock_in   = 1;
    reg        reset_in   = 0;
    reg        iniciar_in = 0;
    reg  [3:0] chaves_in  = 4'b0000;

    wire       acertou_out;
    wire       errou_out  ;
    wire       pronto_out ;
    wire [3:0] leds_out   ;
	  wire       timeout_out;

    wire       db_tem_jogada_out ;
    wire       db_jogadaIgualMemoria_out;
    wire       db_enderecoIgualSequencia_out;
    wire       db_fimS_out;
    
    wire [6:0] display_sequencia_out, 
               display_jogada_out, 
               display_memoria_out, 
               display_endereco_out, 
               display_estado_out;

    // Configuração do clock
    parameter clockPeriod = 1_000_000; // in ns, f=1KHz

    // Identificacao do caso de teste
    reg [31:0] caso = 0;

    // Gerador de clock
    always #((clockPeriod / 2)) clock_in = ~clock_in;

    // instanciacao do DUT (Device Under Test)
    jogo_desafio_memoria DUT (
        .clock(clock_in),
        .reset(reset_in),
        .jogar(iniciar_in),
        .botoes(chaves_in),
        .leds(leds_out),
        .ganhou(acertou_out),
        .perdeu(errou_out),
        .pronto(pronto_out),
        .timeout(timeout_out),
        .db_jogadaIgualMemoria(db_jogadaIgualMemoria_out),
        .db_enderecoIgualSequencia(db_enderecoIgualSequencia_out),
        .db_tem_jogada(db_tem_jogada_out),
        .db_fimS(db_fimS_out),
        .display_sequencia(display_sequencia_out),
        .display_jogada(display_jogada_out),
        .display_memoria(display_memoria_out),
        .display_endereco(display_endereco_out),
        .display_estado(display_estado_out)
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
      #clockPeriod;


      /*
       * Cenario de Teste 3
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

      // Teste 2. Aguardar alguns segundos
      caso = 2;
      #(10*clockPeriod);

      // Teste 3. iniciar=1 por 5 periodos de clock
      caso = 3;
      iniciar_in = 1;
      #(5*clockPeriod);
      iniciar_in = 0;
      // espera
      #(10*clockPeriod);

      #(3000*clockPeriod);
      // Teste 4. jogada #1 (ajustar chaves para 0001 por 10 periodos de clock
      caso = 4;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      #(3000*clockPeriod);
      // Teste 5. timeout
      caso = 5;
      @(negedge clock_in);
      chaves_in = 4'b0000;
      #(900000000*clockPeriod);
      


      // final dos casos de teste da simulacao
      #100;
      $display("Fim da simulacao");
      $stop;
    end

  endmodule