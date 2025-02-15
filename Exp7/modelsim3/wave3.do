onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 23 sim:/tb3/clockPeriod
add wave -noupdate -height 23 -radix unsigned sim:/tb3/caso
add wave -noupdate -divider entradas
add wave -noupdate -height 23 sim:/tb3/clock_in
add wave -noupdate -height 23 sim:/tb3/reset_in
add wave -noupdate -height 23 sim:/tb3/iniciar_in
add wave -noupdate -color {Violet Red} -height 23 sim:/tb3/chaves_in
add wave -noupdate -color {Violet Red} -height 23 sim:/tb3/memoria_in
add wave -noupdate -color {Violet Red} -height 23 sim:/tb3/nivel_in
add wave -noupdate -divider saídas
add wave -noupdate -color Yellow -height 23 sim:/tb3/acertou_out
add wave -noupdate -color Yellow -height 23 sim:/tb3/errou_out
add wave -noupdate -color Yellow -height 23 sim:/tb3/pronto_out
add wave -noupdate -color Yellow -height 23 sim:/tb3/timeout_out
add wave -noupdate -color {Cornflower Blue} -height 23 sim:/tb3/leds_out
add wave -noupdate -divider depuração
add wave -noupdate -color Cyan -height 23 sim:/tb3/db_tem_jogada_out
add wave -noupdate -color Cyan -height 23 sim:/tb3/db_jogadaIgualMemoria_out
add wave -noupdate -color Cyan -height 23 sim:/tb3/db_enderecoIgualSequencia_out
add wave -noupdate -color Cyan -height 23 sim:/tb3/db_fimS_out
add wave -noupdate -color Violet -height 23 sim:/tb3/DUT/s_endereco
add wave -noupdate -color Violet -height 23 sim:/tb3/DUT/s_sequencia
add wave -noupdate -color Violet -height 23 sim:/tb3/DUT/s_memoria
add wave -noupdate -color Violet -height 23 sim:/tb3/DUT/s_jogada
add wave -noupdate -color Violet -height 23 -radix hexadecimal sim:/tb3/DUT/s_estado
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4258000000 ns} 0} {{Cursor 2} {9259000000 ns} 0}
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
WaveRestoreZoom {3949007486 ns} {7864831943 ns}
