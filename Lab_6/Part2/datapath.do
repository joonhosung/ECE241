vlib work
vlog Lab6_Part2.v
vsim datapath
log {/*}
add wave {/*}

force clk 1 0ns, 0 {5ns} -r 10ns

force resetn 0
run 10ns
force resetn 1

# A <- 10
force data_in 8'd10
force ld_alu_out 0
force ld_a 1
run 20ns
force ld_a 0

# B <- 10
force data_in 8'd10
force ld_alu_out 0
force ld_b 1
run 20ns
force ld_b 0

# C <- 10
force data_in 8'd10
force ld_alu_out 0
force ld_c 1
run 20ns
force ld_c 0

# x <- 10
force data_in 8'd10
force ld_alu_out 0
force ld_x 1
run 20ns
force ld_x 0

# A, B, R <- A + B (20)
force ld_a 1
force ld_r 1
force ld_b 1
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd1
force ld_alu_out 1
run 10ns
force ld_alu_out 0
force ld_a 0
force ld_r 0
force ld_b 0
run 10ns

# A, B, R <- A * x (200)
force ld_a 1
force ld_r 1
force ld_b 1
force alu_op 1
force alu_select_a 2'd0
force alu_select_b 2'd3
force ld_alu_out 1
run 10ns
force ld_alu_out 0
force ld_a 0
force ld_r 0
force ld_b 0
run 10ns