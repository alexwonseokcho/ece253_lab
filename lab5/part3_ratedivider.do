# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim RateDivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*} 
#{/countDown/*} 

#module part2 #(parameter CLOCK_FREQUENCY = 500) (input logic ClockIn, input logc Reset, input logic [1:0] Speed, output logic [3:0] CounterValue);

force {ClockIn} 0, 1 {1 ms} -r {2 ms}




force {Reset} 1
run 3 ms
force {Reset} 0
run 50000 ms
