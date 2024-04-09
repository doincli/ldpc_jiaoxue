vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
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

