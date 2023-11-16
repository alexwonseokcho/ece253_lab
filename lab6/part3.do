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
add wave {/*} \
{/c0/next_state} \
{/c0/current_state} \
{/d0/Quotient} \
{/d0/d} \
{/d0/Remainder}

force {Clock} 1, 0 {10 ns} -r {20ns}

force {Reset} 1
run 20ns

force {Reset} 0

force {Divisor} 00011
force {Dividend} 0111 

force {Go} 1
run 20ns
force {Go} 0
run 200ns

force {Divisor} 0101
force {Dividend}  01111

force {Go} 1
run 20ns
force {Go} 0
run 200ns

