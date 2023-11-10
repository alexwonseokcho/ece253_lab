# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part1.sv

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Clock[0]} 1, 0 {10 ns} -r {20ns}

force {Reset} 1
run 20ns

force {Reset} 0

# 00
force {w} 0
run 20ns
force {w} 0
run 20ns

# 1111
force {w} 1
run 20ns
force {w} 1
run 20ns
force {w} 1
run 20ns
force {w} 1
run 20ns

force {Reset} 1
run 20ns
force {Reset} 0

# 1101
force {w} 1
run 20ns
force {w} 1
run 20ns
force {w} 0
run 20ns
force {w} 1
run 20ns

force {Reset} 1
run 20ns
force {Reset} 0
