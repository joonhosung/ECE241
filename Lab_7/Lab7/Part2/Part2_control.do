vlib work
vlog Lab7Part2.v
vsim control
log {/*}
add wave {/*}

force enable 0
force count 4'd0
force count_clr_x 8'd0
force count_clr_y 7'd0
force clk 1 0ns, 0 {5ns} -r 10ns

force resetn 0 0ns, 1 {10ns} 20ns
run 20ns

force enable 0 0ns, 1 {10ns} 20ns
run 20ns
force enable 0

force plot 0 0ns, 1 {10ns} 20ns
run 20ns
force plot 0

force count 4'b1111 0ns, 0 {10ns} 20ns
run 20ns
force count 4'b0000

force clear 0 0ns, 1 {10ns} 20ns
run 20ns
force clear 0

force count_clr_x 8'd160 0ns, 15'd0 {10ns} 20ns
force count_clr_y 7'd120 0ns, 15'd0 {10ns} 20ns
run 20ns
force count_clr 15'd0


