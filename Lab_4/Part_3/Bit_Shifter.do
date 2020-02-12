vlib work
vlog Bit_Shifter.v
vsim Bit_Shifter
log {/*}
add wave {/*}

# Clock
force {KEY[0]} 1
# ParallelLoadn  
force {KEY[1]} 1
# RotateRight
force {KEY[2]} 1
# ASRight
force {KEY[3]} 1
run 10ns

force {KEY[0]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 10ns

#00010100
force {KEY[0]} 0
run 10ns
force {KEY[1]} 0
force {KEY[0]} 1
run 10ns

#00101000
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#01010000
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#10100000
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#11010000
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#11101000
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#01110100
force {KEY[3]} 1
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#00111010
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

#00000000
force {SW[9]} 1
force {KEY[0]} 0
run 10ns