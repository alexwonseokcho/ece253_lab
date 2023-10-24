# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clock} 1, 0 {10 ns} -r {20ns}

force {reset} 1
run 1ns
force {reset} 0

force {RotateRight} 0
force {ASRight} 0

force {Data_IN} 1000

force {ParallelLoadn} 0
run 25ns
force {ParallelLoadn} 1

force {RotateRight} 1
run 80ns

force {RotateRight} 0
run 80ns


force {Data_IN} 1000

force {ParallelLoadn} 0
run 25ns
force {ParallelLoadn} 1



force {RotateRight} 1
force {ASRight} 1
run 90ns

#asright is not working right now fix pls 

force {RotateRight} 0
run 25ns





