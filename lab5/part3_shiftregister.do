# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim shiftregister12bit

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*} 
#{/countDown/*} 

#r(input logic ClockIn, Reset, Start, output logic [2:0] CounterOut, output logic NewBitOut);

force {ClockIn} 0, 1 {1 ms} -r {2 ms}
force {Shift} 0

force {Reset} 1
run 3 ms
force {Reset} 0

force {ParallelLoadn} 110010001101 

run 10 ms
force {ParallelLoad} 1
run 2 ms
force {ParallelLoad} 0

run 10 ms

force {ParallelLoadn} 111110001101 


force {Shift} 1, 0 {2 ms} -r {500 ms}

run 3000ms 
force {Reset} 1
run 3 ms
force {Reset} 0

run 10000 ms
