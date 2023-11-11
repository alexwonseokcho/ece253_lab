# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2_2.sv

#load simulation using mux as the top level simulation module
vsim datapath

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clk} 1, 0 {10 ns} -r {20ns}

force {reset} 1
run 20ns

force {reset} 0

force {data_in} 00000101
force {ld_a} 1
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns

force {data_in} 00000101
force {ld_a} 0
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns

force {data_in} 00000100
force {ld_a} 0
force {ld_b} 1
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns

force {data_in} 00000100
force {ld_a} 0
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns

force {data_in} 00000111
force {ld_a} 1
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 1
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 1
run 20ns

force {data_in} 00000111
force {ld_a} 0
force {ld_b} 0
force {ld_r} 1
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 1
force {alu_op} 0
run 20ns

force {data_in} 00000111
force {ld_a} 1
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns



# Next reiteration
# Result: It resets and takes in a new 'a' value which is the last data_in (00000111 in this case)
force {data_in} 00000001
force {ld_a} 0
force {ld_b} 1
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns

force {data_in} 00000001
force {ld_a} 0
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns

force {data_in} 00000111
force {ld_a} 1
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 1
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 1
run 20ns

force {data_in} 00000111
force {ld_a} 0
force {ld_b} 0
force {ld_r} 1
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 1
force {alu_op} 0
run 20ns

force {data_in} 00000111
force {ld_a} 1
force {ld_b} 0
force {ld_r} 0
force {ld_alu_out} 0
force {alu_select_a} 0
force {alu_select_b} 0
force {alu_op} 0
run 20ns