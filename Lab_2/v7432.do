vlib Lab2Test
vlog Lab2Test.v
vsim v7432
log {/*}
add wave {/*}

force {pin1} 0
force {pin2} 1
run 10ns

force {pin1} 1
force {pin2} 0
run 10ns

force {pin4} 1
force {pin5} 0
run 10ns

force {pin4} 0
force {pin5} 1
run 10ns

force {pin9} 1
force {pin10} 0
run 10ns

force {pin9} 0
force {pin10} 1
run 10ns

force {pin12} 1
force {pin13} 0
run 10ns

force {pin12} 0
force {pin13} 1
run 10ns