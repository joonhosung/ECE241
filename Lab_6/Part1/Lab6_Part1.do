vlib work
vlog Lab6_Part1.v
vsim Lab6_Part1
log {/*}
add wave {/*}

# Reset -> A
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[0]} 1


# B -> C -> D -> F -> F
force {SW[1]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 120ns


# E -> G -> C -> D -> F
force {SW[1]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns

force {SW[1]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 80ns


# Reset -> A -> A
force {SW[0]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 40ns
force {SW[0]} 1


# B -> C -> E -> G
force {SW[1]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 40ns
force {SW[1]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[1]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns


# A -> B -> A
force {SW[1]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[1]} 1
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 20ns
force {SW[1]} 0
force {KEY[0]} 0 0ns, 1 {10ns} -r 20ns
run 40ns