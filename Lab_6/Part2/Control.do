vlib work
vlog Lab6_Part2.v
vsim control
log {/*}
add wave {/*}

force clk 1 0ns, 0 {5ns} -r 10ns

force go 0 0ns, 1 {10ns} -r 20ns
run 220ns
