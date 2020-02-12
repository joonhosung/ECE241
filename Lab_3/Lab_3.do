vlib work
vlog Lab_3.v
vsim alwaysBlock
log {/*}
add wave {/*}

#Input, MuxSelect

#MuxSelect 000
force {Input[5]} 0
force {Input[4]} 0
force {Input[3]} 0
force {Input[2]} 0
force {Input[1]} 0
force {Input[0]} 0
force {MuxSelect[2]} 0
force {MuxSelect[1]} 0
force {MuxSelect[0]} 0
run 10ns

force {Input[0]} 1
run 10ns


#MuxSelect 001
force {Input[1]} 0
force {Input[0]} 0
force {MuxSelect[2]} 0
force {MuxSelect[1]} 0
force {MuxSelect[0]} 1
run 10ns

force {Input[1]} 1
run 10ns


#MuxSelect 010
force {Input[2]} 0
force {Input[1]} 0
force {MuxSelect[2]} 0
force {MuxSelect[1]} 1
force {MuxSelect[0]} 0
run 10ns

force {Input[2]} 1
run 10ns


#MuxSelect 011
force {Input[3]} 0
force {Input[2]} 0
force {MuxSelect[2]} 0
force {MuxSelect[1]} 1
force {MuxSelect[0]} 1
run 10ns

force {Input[3]} 1
run 10ns


#MuxSelect 100
force {Input[4]} 0
force {Input[3]} 0
force {MuxSelect[2]} 1
force {MuxSelect[1]} 0
force {MuxSelect[0]} 0
run 10ns

force {Input[4]} 1
run 10ns


#MuxSelect 101
force {Input[5]} 0
force {Input[4]} 0
force {MuxSelect[2]} 1
force {MuxSelect[1]} 0
force {MuxSelect[0]} 1
run 10ns

force {Input[5]} 1
run 10ns


#MuxSelect 110
force {Input[6]} 0
force {Input[5]} 0
force {MuxSelect[2]} 1
force {MuxSelect[1]} 1
force {MuxSelect[0]} 0
run 10ns

force {Input[6]} 1
run 10ns


#MuxSelect 111
force {Input[7]} 0
force {Input[6]} 0
force {MuxSelect[2]} 1
force {MuxSelect[1]} 1
force {MuxSelect[0]} 1
run 10ns

force {Input[7]} 1
run 10ns