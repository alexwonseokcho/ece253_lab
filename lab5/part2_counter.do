# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim counter8bit

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clk} 0, 1 {1 ns} -r {2ns}


force {reset} 1
run 10ns
force {reset} 0

force {enable} 0, 1 {20 ns} -r {40 ns}
#force {enable} 1
run 1100ns