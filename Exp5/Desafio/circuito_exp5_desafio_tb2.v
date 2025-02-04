/* --------------------------------------------------------------------
 * Arquivo   : circuito_exp4_tb-MODELO.v
 * Projeto   : Experiencia 4 - Desenvolvimento de Projeto de 
 *             Circuitos Digitais em FPGA
 * --------------------------------------------------------------------
 * Descricao : testbench Verilog MODELO para circuito da Experiencia 5 
 *
 *             1) Plano de teste com 4 jogadas certas  
 *                e erro na quinta jogada
 *
 * --------------------------------------------------------------------
 * Revisoes  :
 *     Data        Versao  Autor             Descricao
 *     27/01/2024  1.0     Edson Midorikawa  versao inicial
 *     16/01/2024  1.1     Edson Midorikawa  revisao
 * --------------------------------------------------------------------
 */

`timescale 1ns/1ns

module circuito_exp5_desafio_tb2;

    // Sinais para conectar com o DUT
    reg        nivel_in = 1'b0;
    reg        clock_in   = 1;
    reg        reset_in   = 0;
    reg        iniciar_in = 0;
    reg  [3:0] chaves_in  = 4'b0000;

    // valores iniciais para fins de simulacao (ModelSim)
    wire       acertou_out;
    wire       errou_out  ;
    wire       pronto_out ;
    wire [3:0] leds_out   ;

    wire [3:0] db_memoria_out    ;
    wire [3:0] db_estado_out     ;
    wire [3:0] db_jogada_out     ;
    wire [3:0] db_endereco_out;
    wire       db_tem_jogada_out ;
    wire       db_jogadaIgualMemoria_out;
    wire       db_enderecoIgualSequencia_out;
    wire [3:0] db_sequencia_out;
	  wire       db_timeout_out;
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
    circuito_exp5 DUT (
      .clock(clock_in),
      .reset(reset_in),
      .jogar(iniciar_in),
      .nivel(nivel_in)
      .botoes(chaves_in),
      .leds(leds_out),
      .pronto(pronto_out),
      .ganhou(acertou_out),
      .perdeu(errou_out),
      .db_jogadaIgualMemoria(db_jogadaIgualMemoria_out),
      .db_enderecoIgualSequencia(db_enderecoIgualSequencia_out),
      .db_tem_jogada(db_tem_jogada_out),
      .db_timeout(db_timeout_out)
      .display_sequencia(display_sequencia_out), 
      .display_jogada(display_jogada_out), 
      .display_memoria(display_memoria_out), 
      .display_endereco(display_endereco_out), 
      .display_estado(display_estado_out),
      .db_fimS(db_fimS_out)
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
       * Cenario de Teste 5 - acerta tudo com nível = 0 (até sequência 8)
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


      // final dos casos de teste da simulacao
      caso = 99;
      #100;
      $display("Fim da simulacao");
      $stop;
    end

  endmodule
