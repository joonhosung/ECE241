vlib work
vlog Lab3_Part2.v
vsim FA
log {/*}
add wave {/*}

#Have c_in, a, b

force {a} 0
force {b} 0
force {c_in} 0
run 10ns

force {b} 0
force {a} 0
force {c_in} 1
run 10ns

force {b} 0
force {a} 1
force {c_in} 0
run 10ns

force {b} 0
force {a} 1
force {c_in} 1
run 10ns

force {b} 1
force {a} 0
force {c_in} 0
run 10ns

force {b} 1
force {a} 0
force {c_in} 1
run 10ns

force {b} 1
force {a} 1
force {c_in} 0
run 10ns

force {b} 1
force {a} 1
force {c_in} 1
run 10ns