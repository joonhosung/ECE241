vlib work
vlog Lab_3.v
vsim Lab_3
log {/*}
add wave {/*}

#Input, MuxSelect

#MuxSelect 000
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
run 10ns

force {SW[0]} 1
run 10ns