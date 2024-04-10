vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../encode_ex.srcs/sources_1/ip/H4/sim/H4.v" \


vlog -work xil_defaultlib \
"glbl.v"

