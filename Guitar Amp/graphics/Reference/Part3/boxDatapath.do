vlib work
vlog boxDatapath.v
vsim boxDatapath
log {/*}
add wave {/*}

#clock waveform
force {clk} 0 0ns, 1 {1ns} -r 1ns

# main cns
force {resetn} 1

# FSM cn data
force {cnA} 0
force {cnB} 0
force {cnC} 0
force {cnD} 0

# User input color
force {colourSW[0]} 0
force {colourSW[1]} 0
force {colourSW[2]} 0

# Reset everything to known value
force {resetn} 0
run 20ns
force {resetn} 1

# Setup colour as white
force {colourSW[0]} 1
force {colourSW[1]} 1
force {colourSW[2]} 1
run 20ns

# Draw the square
force {cnA} 0 0ns, 1 {1ns} -r 4ns
force {cnB} 0 0ns, 1 {2ns} -r 3ns
force {cnC} 0 0ns, 1 {3ns} -r 2ns
force {cnD} 0 0ns, 1 {4ns} -r 1ns
run 10000ns
