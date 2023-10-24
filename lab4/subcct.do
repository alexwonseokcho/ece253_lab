# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim subcct

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clock} 1, 0 {10 ns} -r {20ns}

force {reset} 1
run 1ns
force {reset} 0


force {left} 1
force {right} 0
force {LoadLeft} 1
run 10ns

force {D} 0
force {loadn} 0

run 40ns
