vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode/example_design/encode_tx_startup_fsm.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode/example_design/encode_rx_startup_fsm.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode_init.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode_cpll_railing.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode_gt.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode_multi_gt.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode/example_design/encode_sync_block.v" \
"../../../../encode_ex.srcs/sources_1/ip/encode/encode.v" \


vlog -work xil_defaultlib \
"glbl.v"

