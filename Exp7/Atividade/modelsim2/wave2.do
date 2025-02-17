onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 23 /tb2/clockPeriod
add wave -noupdate -height 23 -radix unsigned /tb2/caso
add wave -noupdate -divider entradas
add wave -noupdate -height 23 /tb2/clock_in
add wave -noupdate -height 23 /tb2/reset_in
add wave -noupdate -height 23 /tb2/iniciar_in
add wave -noupdate -color {Violet Red} -height 23 /tb2/chaves_in
add wave -noupdate -color {Violet Red} -height 23 /tb2/memoria_in
add wave -noupdate -color {Violet Red} -height 23 /tb2/nivel_in
add wave -noupdate -divider saídas
add wave -noupdate -color Yellow -height 23 /tb2/acertou_out
add wave -noupdate -color Yellow -height 23 /tb2/errou_out
add wave -noupdate -color Yellow -height 23 /tb2/pronto_out
add wave -noupdate -color Yellow -height 23 /tb2/timeout_out
add wave -noupdate -color {Cornflower Blue} -height 23 /tb2/leds_out
add wave -noupdate -divider depuração
add wave -noupdate -color Cyan -height 23 /tb2/db_tem_jogada_out
add wave -noupdate -color Cyan -height 23 /tb2/db_jogadaIgualMemoria_out
add wave -noupdate -color Cyan -height 23 /tb2/db_enderecoIgualSequencia_out
add wave -noupdate -color Cyan -height 23 /tb2/db_fimS_out
add wave -noupdate -color Violet -height 23 /tb2/DUT/s_endereco
add wave -noupdate -color Violet -height 23 /tb2/DUT/s_sequencia
add wave -noupdate -color Violet -height 23 /tb2/DUT/s_memoria
add wave -noupdate -color Violet -height 23 /tb2/DUT/s_jogada
add wave -noupdate -color Violet -height 23 -radix hexadecimal /tb2/DUT/s_estado
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20222373987 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {20338011675 ns} {20441688661 ns}
