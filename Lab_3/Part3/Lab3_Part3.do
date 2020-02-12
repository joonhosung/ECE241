vlib work
vlog Lab3_Part3.v
vsim Lab3_Part3
log {/*}
add wave {/*}\

#We have A = SW[7:4],
# B = SW[3:0],
# KEY[2:0]

#When KEY = 000 (Ripple-Carry Adder)
force {KEY[2]} 1
force {KEY[1]} 1
force {KEY[0]} 1
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 10ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
run 10ns

force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
run 10ns

#KEY = 001 (Verilog Adder)
force {KEY[2]} 1
force {KEY[1]} 1
force {KEY[0]} 0
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 10ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
run 10ns

force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
run 10ns


# KEY = 010(A ~^ B and ~A|~B)
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 1

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[0]} 1
run 10ns

force {SW[1]} 1
run 10ns

force {SW[2]} 1
run 10ns

force {SW[3]} 1
run 10ns

force {SW[4]} 1
run 10ns

force {SW[5]} 1
run 10ns

force {SW[6]} 1
run 10ns

force {SW[7]} 1
run 10ns

# KEY = 011 (00001111 when at least 1 of 8 bits is 1)
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 0
run 10ns

force {SW[0]} 0
force {SW[1]} 1
run 10ns

force {SW[1]} 0
force {SW[2]} 1
run 10ns

force {SW[2]} 0
force {SW[3]} 1
run 10ns

force {SW[3]} 0
force {SW[4]} 1
run 10ns

force {SW[4]} 0
force {SW[5]} 1
run 10ns

force {SW[5]} 0
force {SW[6]} 1
run 10ns

force {SW[6]} 0
force {SW[7]} 1
run 10ns
# KEY = 100 (11110000 when A exactly 1 bit & B exactly 2 bits)
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 10ns

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
run 10ns

force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10ns

# KEY = 101 (A -> most significant & ~B -> least significant
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 0

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 10ns

force {SW[0]} 0
force {SW[1]} 1
run 10ns

force {SW[1]} 0
force {SW[2]} 1
run 10ns

force {SW[2]} 0
force {SW[3]} 1
run 10ns

force {SW[3]} 0
force {SW[4]} 1
run 10ns

force {SW[4]} 0
force {SW[5]} 1
run 10ns

force {SW[5]} 0
force {SW[6]} 1
run 10ns

force {SW[6]} 0
force {SW[7]} 1
run 10ns