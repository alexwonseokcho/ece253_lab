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

force {Reset_b} 1

# Addition


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

force {Reset_b} 0 {10 ns} -r {10ns}

force {Data} 1110
force {Function} 00

run 10ns


# Multiplication
force {Data} 0000
force {Function} 01

run 20ns

force {Data} 1111
force {Function} 00

run 20ns

force {Data} 0010
force {Function} 01

run 20ns

# Reset
force {Data} 0000
force {Function} 01

run 20ns

force {Data} 0001
force {Function} 00

run 20ns

# Shift

force {Data} 0010
force {Function} 10

run 20ns

force {Data} 0100
force {Function} 10

run 20ns

# Last Part

force {Data} 0101
force {Function} 11

run 20ns


