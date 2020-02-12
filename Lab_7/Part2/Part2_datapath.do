vlib work
vlog Lab7Part2.v
vsim datapath
log {/*}
add wave {/*}


force ld_x 0
force ld_y 0
force ld_c 0
force clearEn 0
force writeEn 0
force countEn 0
force resetn 0
run 10ns

force clk 1 0ns, 0 {5ns} -r 10ns
run 10ns

force resetn 1

force ld_x 1
force ld_c 1
force x_in 7'b0000011
force c_in 3'b111
run 10ns

force ld_x 0
force ld_c 0
force ld_y 1
force y_in 7'b0000011
run 10ns
force ld_y 0

force writeEn 1
force countEn 1
run 160ns

force countEn 1
force writeEn 1
force clearEn 1
run 192000ns