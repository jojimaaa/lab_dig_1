onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 21 /tb1/clockPeriod
add wave -noupdate -height 21 -radix unsigned -childformat {{{/tb1/caso[31]} -radix unsigned} {{/tb1/caso[30]} -radix unsigned} {{/tb1/caso[29]} -radix unsigned} {{/tb1/caso[28]} -radix unsigned} {{/tb1/caso[27]} -radix unsigned} {{/tb1/caso[26]} -radix unsigned} {{/tb1/caso[25]} -radix unsigned} {{/tb1/caso[24]} -radix unsigned} {{/tb1/caso[23]} -radix unsigned} {{/tb1/caso[22]} -radix unsigned} {{/tb1/caso[21]} -radix unsigned} {{/tb1/caso[20]} -radix unsigned} {{/tb1/caso[19]} -radix unsigned} {{/tb1/caso[18]} -radix unsigned} {{/tb1/caso[17]} -radix unsigned} {{/tb1/caso[16]} -radix unsigned} {{/tb1/caso[15]} -radix unsigned} {{/tb1/caso[14]} -radix unsigned} {{/tb1/caso[13]} -radix unsigned} {{/tb1/caso[12]} -radix unsigned} {{/tb1/caso[11]} -radix unsigned} {{/tb1/caso[10]} -radix unsigned} {{/tb1/caso[9]} -radix unsigned} {{/tb1/caso[8]} -radix unsigned} {{/tb1/caso[7]} -radix unsigned} {{/tb1/caso[6]} -radix unsigned} {{/tb1/caso[5]} -radix unsigned} {{/tb1/caso[4]} -radix unsigned} {{/tb1/caso[3]} -radix unsigned} {{/tb1/caso[2]} -radix unsigned} {{/tb1/caso[1]} -radix unsigned} {{/tb1/caso[0]} -radix unsigned}} -subitemconfig {{/tb1/caso[31]} {-radix unsigned} {/tb1/caso[30]} {-radix unsigned} {/tb1/caso[29]} {-radix unsigned} {/tb1/caso[28]} {-radix unsigned} {/tb1/caso[27]} {-radix unsigned} {/tb1/caso[26]} {-radix unsigned} {/tb1/caso[25]} {-radix unsigned} {/tb1/caso[24]} {-radix unsigned} {/tb1/caso[23]} {-radix unsigned} {/tb1/caso[22]} {-radix unsigned} {/tb1/caso[21]} {-radix unsigned} {/tb1/caso[20]} {-radix unsigned} {/tb1/caso[19]} {-radix unsigned} {/tb1/caso[18]} {-radix unsigned} {/tb1/caso[17]} {-radix unsigned} {/tb1/caso[16]} {-radix unsigned} {/tb1/caso[15]} {-radix unsigned} {/tb1/caso[14]} {-radix unsigned} {/tb1/caso[13]} {-radix unsigned} {/tb1/caso[12]} {-radix unsigned} {/tb1/caso[11]} {-radix unsigned} {/tb1/caso[10]} {-radix unsigned} {/tb1/caso[9]} {-radix unsigned} {/tb1/caso[8]} {-radix unsigned} {/tb1/caso[7]} {-radix unsigned} {/tb1/caso[6]} {-radix unsigned} {/tb1/caso[5]} {-radix unsigned} {/tb1/caso[4]} {-radix unsigned} {/tb1/caso[3]} {-radix unsigned} {/tb1/caso[2]} {-radix unsigned} {/tb1/caso[1]} {-radix unsigned} {/tb1/caso[0]} {-radix unsigned}} /tb1/caso
add wave -noupdate -height 21 /tb1/clock_in
add wave -noupdate -expand -group Entradas -color Red -height 21 /tb1/chaves_in
add wave -noupdate -expand -group Entradas -height 21 /tb1/reset_in
add wave -noupdate -expand -group Entradas -height 21 /tb1/iniciar_in
add wave -noupdate -expand -group Entradas -height 21 /tb1/confirma_in
add wave -noupdate -expand -group Entradas -height 21 /tb1/nivel_in
add wave -noupdate -expand -group Saidas -color Cyan -height 21 /tb1/leds_out
add wave -noupdate -expand -group Saidas -color {Green Yellow} /tb1/acertos_out
add wave -noupdate -expand -group Saidas -color {Cornflower Blue} -height 21 /tb1/pronto_out
add wave -noupdate -expand -group Saidas -color {Cornflower Blue} -height 21 /tb1/timeout_out
add wave -noupdate -group {Displays 7 Seg} -color Gold -height 21 /tb1/DUT/HEX5
add wave -noupdate -group {Displays 7 Seg} -color Gold -height 21 /tb1/DUT/HEX4
add wave -noupdate -group {Displays 7 Seg} -color Gold -height 21 /tb1/DUT/HEX3
add wave -noupdate -group {Displays 7 Seg} -color Gold -height 21 /tb1/DUT/HEX2
add wave -noupdate -group {Displays 7 Seg} -color Gold -height 21 /tb1/DUT/HEX1
add wave -noupdate -group {Displays 7 Seg} -color Gold -height 21 /tb1/DUT/HEX0
add wave -noupdate -expand -group Debug -color Plum -height 21 -radix hexadecimal /tb1/db_estado
add wave -noupdate -expand -group Debug -color Plum -height 21 /tb1/db_acertouJogada
add wave -noupdate -expand -group Debug -color Plum -height 21 /tb1/db_jogadaAtualEQUALSacertoAnterior
add wave -noupdate -expand -group Debug -color Plum -height 21 /tb1/db_acertoAnteriorEQUALSzero
add wave -noupdate -expand -group Debug -color Plum -height 21 -subitemconfig {{/tb1/db_jogada[3]} {-color Plum} {/tb1/db_jogada[2]} {-color Plum} {/tb1/db_jogada[1]} {-color Plum} {/tb1/db_jogada[0]} {-color Plum}} /tb1/db_jogada
add wave -noupdate -expand -group Debug -color Plum -height 21 /tb1/db_sequencia
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {92519000 us} 0} {{Cursor 2} {93519000 us} 0}
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
WaveRestoreZoom {0 us} {101374980 us}
