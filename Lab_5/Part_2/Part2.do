vlib work
vlog Part2.v
vsim Part2
log -r {/*}
add wave {/*}

# Reset
force {SW[2]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[2]} 1

# 20ns period == 50MHz
# Full Speed
force {SW[0]} 0
force {SW[1]} 0
# Run for 1ms: 50 cycles
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 1000ns


# Reset
force {SW[2]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[2]} 1

# 2Hz
force {SW[0]} 1
force {SW[1]} 0
# Run for 1s: 2 cycles
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 1 sec


# Reset
force {SW[2]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[2]} 1

# 1Hz
force {SW[0]} 0
force {SW[1]} 1
# Run for 1s: 1 cycle
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 2 sec


# Reset
force {SW[2]} 0
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[2]} 1

# 0.5Hz
force {SW[0]} 1
force {SW[1]} 1
# Run for 2s: 1 cycle
force {clk} 0 0ns, 1 {10ns} -r 20ns
run 4 sec