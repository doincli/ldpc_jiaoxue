vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../encode_ex.srcs/sources_1/ip/ila_1/hdl/verilog" "+incdir+../../../../encode_ex.srcs/sources_1/ip/ila_1/hdl/verilog" \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../encode_ex.srcs/sources_1/ip/ila_1/hdl/verilog" "+incdir+../../../../encode_ex.srcs/sources_1/ip/ila_1/hdl/verilog" \
"../../../../encode_ex.srcs/sources_1/ip/ila_1/sim/ila_1.v" \

vlog -work xil_defaultlib \
"glbl.v"
