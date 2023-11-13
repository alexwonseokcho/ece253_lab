# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim datapath

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {a} 00000
force {d} 0011
force {D} 0111

run 20ns

force {a} 00000
force {d} 0011
force {D} 1110

run 20ns

force {a} 00001
force {d} 0011
force {D} 1100

run 20ns

force {a} 00000
force {d} 0011
force {D} 1001

run 20ns
