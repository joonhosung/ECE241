vlib work
vlog ALU_Register.v
vlog ALU.v
vsim ALU_Register
log {/*}
add wave {/*}

# Adder Ripple Carry

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns

force {SW[9]} 1

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 80ns
# Should end up with 0000101 

# Reset
force {SW[9]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[9]} 1

# A XNOR B, A NAND B
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 40ns
# 10101111 -> 01011010

# Reset
force {SW[9]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[9]} 1
#00000000

# 00001111 if |{A,B}
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
#00000000

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
#00001111

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
#00001111


# 11110000 if only 1 A and only 2 B
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
#00000000

force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
force {SW[0]} 1
force {SW[1]} 1

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
#00000011

force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
force {SW[1]} 0

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[0]} 0
#11110000


# {A, ~B}
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
#00001111

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 40ns
#10100000 -> 10101111



# Hold Register value
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns