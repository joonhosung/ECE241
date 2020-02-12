vlib work

vlog HEX_display.v

vsim HEX_disp

log {/*}

add wave {/*}

#0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#2
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#3
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#4
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

#5
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

#6
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
run 10ns

#7
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
run 10ns

#8
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#9
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#A
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#b
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#C
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 10ns

#D
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 10ns

#E
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
run 10ns

#F
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
run 10ns