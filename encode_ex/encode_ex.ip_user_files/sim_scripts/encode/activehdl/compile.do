vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
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

