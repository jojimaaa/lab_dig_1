onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 21 /tb1/clockPeriod
add wave -noupdate -height 21 -radix unsigned /tb1/caso
add wave -noupdate -height 21 /tb1/clock_in
add wave -noupdate -divider entradas
add wave -noupdate -color Red -height 21 /tb1/chaves_in
add wave -noupdate -height 21 /tb1/reset_in
add wave -noupdate -height 21 /tb1/iniciar_in
add wave -noupdate -height 21 /tb1/confirma_in
add wave -noupdate -height 21 /tb1/nivel_in
add wave -noupdate -divider saídas
add wave -noupdate -color Cyan -height 21 /tb1/leds_out
add wave -noupdate -color {Cornflower Blue} -height 21 /tb1/pronto_out
add wave -noupdate -color {Cornflower Blue} -height 21 /tb1/timeout_out
add wave -noupdate -color {Green Yellow} /tb1/acertos_out
add wave -noupdate -divider depuração
add wave -noupdate -color Plum -height 21 -radix hexadecimal /tb1/db_estado
add wave -noupdate -color Plum -height 21 /tb1/db_acertouJogada
add wave -noupdate -color Plum -height 21 /tb1/db_jogadaAtualEQUALSacertoAnterior
add wave -noupdate -color Plum -height 21 /tb1/db_acertoAnteriorEQUALSzero
add wave -noupdate -color Plum -height 21 /tb1/db_jogada
add wave -noupdate -color Plum -height 21 /tb1/db_sequencia
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88832237 us} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {81325013 us} {89830265 us}
