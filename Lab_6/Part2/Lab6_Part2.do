vlib work
vlog Lab6_Part2.v
vsim part2
log {/*}
add wave {/*}

force clk 1 0ns, 0 {5ns} -r 10ns

#reset
force resetn 0
force go 0
force data_in 0
run 10ns

# Input 5->4->3->2 --> 5*2^2 + 4*2 + 3 = 31
# A = 5
force resetn 1
force go 1
force data_in 8'd5
run 10ns
force go 0
force data_in 8'd4
run 10ns

# B = 4
force go 1
run 10ns
force go 0
force data_in 8'd3
run 10ns

# C = 3
force go 1
run 10ns
force go 0
force data_in 8'd2
run 10ns

# x = 2
force go 1
run 10ns
force go 0
force data_in 8'd0
run 10ns

# Do operations
run 60ns

