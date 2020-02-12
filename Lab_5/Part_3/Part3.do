vlib work
vlog Part_3.v
vsim Part_3
log -r {/*}
add wave {/*}

# Reset
force {KEY[0]} 0
force {KEY[1]} 1
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {KEY[0]} 1


# Load J
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 0.51 sec 
# Output J
force {KEY[1]} 1
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 6.51 sec

# Load N
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 0.51 sec 
# Output N
force {KEY[1]} 1
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 6.51 sec

# Load I
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 0.51 sec 
# Output I
force {KEY[1]} 1
force {clk} 0 0ns, 1 {10ns} -r 20ns 
run 6.51 sec

