# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Clock} 0, 1 {10 ns} -r {20ns}

force {Reset_b} 0


force {Data[0]} 0
force {Data[1]} 0
force {Data[2]} 0
force {Data[3]} 1

force {Function[0]} 0
force {Function[1]} 0

run 10ns

force {Reset_b} 0


force {Data[0]} 0
force {Data[1]} 0
force {Data[2]} 0
force {Data[3]} 1

force {Function[0]} 1
force {Function[1]} 0

run 10ns

force {Reset_b} 0


force {Data[0]} 0
force {Data[1]} 0
force {Data[2]} 1
force {Data[3]} 1

force {Function[0]} 0
force {Function[1]} 0

run 10ns

force {Reset_b} 0

force {Data[0]} 0
force {Data[1]} 0
force {Data[2]} 1
force {Data[3]} 1

force {Function[0]} 0
force {Function[1]} 0

run 10ns

force {Reset_b} 0


force {Data[0]} 0
force {Data[1]} 1
force {Data[2]} 1
force {Data[3]} 1

force {Function[0]} 0
force {Function[1]} 0

run 10ns
