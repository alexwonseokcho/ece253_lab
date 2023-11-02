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
#{/countDown/*} 

#r(input logic ClockIn, Reset, Start, output logic [2:0] CounterOut, output logic NewBitOut);
#module part3 #(parameter CLOCK_FREQUENCY=500) (input logic ClockIn, Reset, Start, input logic [2:0] Letter, output logic DotDashOut, NewBitOut);


force {ClockIn} 0, 1 {1 ms} -r {2 ms}

force {Reset} 1
run 3 ms
force {Reset} 0

force {Letter} 000
force {Start} 1
run 2 ms
force {Start} 0

run 7000 ms


force {Letter} 001
force {Start} 1
run 2 ms
force {Start} 0

run 7000 ms


force {Letter} 010
force {Start} 1
run 2 ms
force {Start} 0



run 10000 ms
