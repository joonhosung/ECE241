vlib work
vlog random.v
vsim random
log {/*}
add wave {/*}

#clock waveform
force {clk} 0 0ns, 1 {5ns} -r 10ns

# main controls
force {rst_n} 0
run 20ns

# Reset everything to known value
force {rst_n} 1
run 40ns