vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" \
"../../../../test_ldpc.srcs/sources_1/ip/ber_ila/sim/ber_ila.v" \

vlog -work xil_defaultlib \
"glbl.v"
