# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim hex_decoder

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}
#\
#{/mux/SW[9]} \
#{/mux/SW[1]} \
#{/mux/SW[0]} \
#{/mux/LEDR[0]} 


#instead of laboriously making all test cases, we can use a command to 
#exhausts all possibilities



force {s[0]} 0, 1 {10 ns} -r {20 ns}
#set the value 0 and 1 every 10 ns, and repeat it every 20ns
force {s[1]} 0, 1 {20 ns} -r {40 ns}
force {s[2]} 0, 1 {40 ns} -r {80 ns}
force {s[3]} 0, 1 {80 ns} -r {160 ns}
run 160ns 
#could run for longer but it will be repeated


# first test case
#set input values using the force command, signal names need to be in {} brackets
#force {SW[0]} 0
#force {SW[1]} 0
#force {SW[9]} 0
#run simulation for a few ns
#run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
#force {SW[0]} 1
#force {SW[1]} 0
#force {SW[9]} 0
#run 10ns
