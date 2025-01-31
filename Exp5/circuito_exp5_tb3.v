`timescale 1ns/1ns

module circuito_exp5_tb3;

    // Sinais para conectar com o DUT
    // valores iniciais para fins de simulacao (ModelSim)
    reg        clock_in   = 1;
    reg        reset_in   = 0;
    reg        iniciar_in = 0;
    reg  [3:0] chaves_in  = 4'b0000;

    wire       acertou_out;
    wire       errou_out  ;
    wire       pronto_out ;
    wire [3:0] leds_out   ;

    wire [3:0] db_memoria_out    ;
    wire [3:0] db_estado_out     ;
    wire [3:0] db_jogada_out     ;
    wire [3:0] db_endereco_out;
    wire       db_tem_jogada_out ;
    wire db_jogadaIgualMemoria_out;
    wire db_enderecoIgualSequencia_out;
    wire [3:0] db_sequencia_out;

    wire [6:0] display_sequencia_out, display_jogada_out, display_memoria_out, display_endereco_out, display_estado_out;

    // Configuração do clock
    parameter clockPeriod = 1_000_000; // in ns, f=1KHz

    // Identificacao do caso de teste
    reg [31:0] caso = 0;

    // Gerador de clock
    always #((clockPeriod / 2)) clock_in = ~clock_in;

    // instanciacao do DUT (Device Under Test)
    circuito_exp5 DUT (
        .clock(clock_in),
        .reset(reset_in),
        .jogar(iniciar_in),
        .botoes(chaves_in),
        .leds(leds_out),
        .pronto(pronto_out),
        .ganhou(acertou_out),
        .perdeu(errou_out),
        .db_jogadaIgualMemoria(db_jogadaIgualMemoria_out),
        .db_enderecoIgualSequencia(db_enderecoIgualSequencia_out),
        .db_tem_jogada(db_tem_jogada_out),  
        .db_sequencia (db_sequencia_out),
        .db_endereco (db_endereco_out),
        .db_memoria (db_memoria_out),
        .db_estado (db_estado_out),
        .db_jogada (db_jogada_out),
        .display_sequencia (display_sequencia_out),
        .display_jogada (display_jogada_out),
        .display_memoria (display_memoria_out),
        .display_endereco (display_endereco_out),
        .display_estado (display_estado_out),
        .db_fimS (db_fimS_out)
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
      #(10*clockPeriod);


      /*
       * Cenario de Teste
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

      // Teste 4. sequencia #1 (ajustar chaves para 0001 por 10 periodos de clock
      caso = 4;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 5. sequencia #2
      caso = 5;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 6. sequencia #3
      caso = 6;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 7. sequencia #4
      caso = 7;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      
      // Teste 8. sequencia #5
      caso = 8;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 9. sequencia #6
      caso = 9;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 10. sequencia #7
      caso = 10;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 11. sequencia #8
      caso = 11;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);  

      // Teste 12. sequencia #9
      caso = 12;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 13. sequencia #10
      caso = 13; 
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 14. sequencia #11
      caso = 14;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);


      // Teste 15. sequencia #12
      caso = 15;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 16. sequencia #13
      caso = 16;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 17. sequencia #14
      caso = 17;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 18. sequencia #15
      caso = 18;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);


      // Teste 19. sequencia #16
      caso = 19;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b1000;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 20. iniciar outro jogo
      caso = 20;
      iniciar_in = 1;
      #(5*clockPeriod);
      iniciar_in = 0;
      // espera
      #(10*clockPeriod);

      // Teste 21. sequencia #1
      caso = 21;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 22. sequencia #2
      caso = 22;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 23. sequencia #3
      caso = 23;
      @(negedge clock_in);
      chaves_in = 4'b0001;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0010;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);
      chaves_in = 4'b0100;
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      // espera entre jogadas
      #(10*clockPeriod);

      // Teste 24. sequencia #4
      caso = 24;
      @(negedge clock_in);
      chaves_in = 4'b0001; //primeira jogada
      #(10*clockPeriod);
      chaves_in = 4'b0000; 
      #(10*clockPeriod);
      chaves_in = 4'b1010; //segunda jogada, ERRADA
      #(10*clockPeriod);
      chaves_in = 4'b0000;
      #(10*clockPeriod);

      // final dos casos de teste da simulacao
      caso = 99;
      #100;
      $display("Fim da simulacao");
      $stop;
    end

  endmodule
