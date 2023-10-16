# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2.sv part1.sv

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# force {a[0]} 0, 1 {10 ns} -r {20ns}
# force {a[1]} 0, 1 {20 ns} -r {40ns}
# force {a[2]} 0, 1 {40 ns} -r {80ns}
# force {a[3]} 0, 1 {80 ns} -r {160ns}

# force {b[0]} 0, 1 {160 ns} -r {320ns}
# force {b[1]} 0, 1 {320 ns} -r {640ns}
# force {b[2]} 0, 1 {640 ns} -r {1280ns}
# force {b[3]} 0, 1 {1280 ns} -r {2560ns}

# run 2560ns

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 1

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 0

run 10ns


force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1

force {Function[0]} 1
force {Function[1]} 0

run 10ns


force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0

force {Function[0]} 1
force {Function[1]} 0

run 10ns

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 1

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 1

run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 1

run 10ns


force {A[0]} 0
force {A[1]} 0
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1

force {Function[0]} 1
force {Function[1]} 1

run 10ns
