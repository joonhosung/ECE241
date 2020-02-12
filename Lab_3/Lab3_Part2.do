vlib work
vlog Lab3_Part2.v
vsim four_bit_ripple
log {/*}
add wave {/*}

#Have a, b, c_in.

#FA1
force {a[1]} 0
force {a[2]} 0
force {a[3]} 0
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {a[0]} 1
force {b[0]} 1
force {c_in} 0
run 10ns

force {c_in} 1
run 10ns


#FA2
force {a[0]} 0
force {b[0]} 0
force {a[1]} 1
force {b[1]} 1
force {c_in} 0
run 10ns

force {c_in} 1
run 10ns


#FA3
force {a[1]} 0
force {b[1]} 0
force {a[2]} 1
force {b[2]} 1
force {c_in} 0
run 10ns

force {c_in} 1
run 10ns


#FA4
force {a[2]} 0
force {b[2]} 0
force {a[3]} 1
force {b[3]} 1
force {c_in} 0
run 10ns

force {c_in} 1
run 10ns
