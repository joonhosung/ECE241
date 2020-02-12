vlib work
vlog Part1.v
vsim Part1
log {/*}
add wave {/*}

# Reset
force {SW[0]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns

# Try counting without enable
force {SW[1]} 0
force {SW[0]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 40ns

# Add with enable until 0F
force {SW[1]} 1

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 300ns

# Add with enable until 1F
force {SW[1]} 1

force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 320ns

# Reset Again
force {SW[0]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns