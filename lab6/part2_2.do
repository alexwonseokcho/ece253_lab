# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2_2.sv

#load simulation using mux as the top level simulation module
vsim part2_2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Clock} 1, 0 {10 ns} -r {20ns}

force {Reset} 1
run 20ns

force {Reset} 0

# 4^2 + 1
force {Go} 0
run 20ns

force {Go} 1
force {DataIn} 00000100
run 20ns
force {Go} 0
force {DataIn} 00000100
run 20ns
force {Go} 1
force {DataIn} 00000001
run 20ns
force {Go} 0
run 20ns
force {Go} 0
force {DataIn} 11111111
run 20ns
force {Go} 0
force {DataIn} 11110011
run 20ns
force {Go} 0
force {DataIn} 11110011
run 20ns


# Next reiteration
force {Go} 1
force {DataIn} 00000010
run 20ns

force {Go} 0
force {DataIn} 00000010
run 20ns

force {Go} 1
force {DataIn} 00000001
run 20ns

force {Go} 0
force {DataIn} 00000001
run 20ns

force {Go} 0
run 60ns