vlib work
vlog datapath.v
vsim datapath
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
force {cnA} 1
run 20ns

# Wait for 15 frames
force {cnB} 1
force {cnA} 0
run 20ns

# Erase the square
force {cnC} 1
force {cnB} 0
run 20ns

# Update the coordinates
force {cnD} 1
force {cnC} 0
run 20ns

# Draw again
force {cnA} 1
force {cnD} 0
run 20ns

# Reset
force {resetn} 0
run 20ns