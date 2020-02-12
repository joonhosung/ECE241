onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /muxGates/SW
add wave -noupdate /muxGates/LEDR
add wave -noupdate {/muxGates/SW[0]}
add wave -noupdate {/muxGates/SW[1]}
add wave -noupdate {/muxGates/SW[9]}
add wave -noupdate /muxGates/w1
add wave -noupdate /muxGates/w2
add wave -noupdate /muxGates/w3
add wave -noupdate {/muxGates/LEDR[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {184 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {189 ns}
