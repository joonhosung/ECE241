vlib work
vlog Lab7Part2.v
vsim -L altera_mf_ver vga_adapter
vsim Lab7Part2
log {/*}
add wave {/*}

force clk 1 0ns, 0 {5ns} -r 10ns

force SW 10'd0
force KEY[0] 0
run 10ns
force KEY[0] 1 