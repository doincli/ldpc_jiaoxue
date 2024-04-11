vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ila_1/hdl/verilog" "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ila_1/hdl/verilog" \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ila_1/hdl/verilog" "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ila_1/hdl/verilog" \
"../../../../test_ldpc.srcs/sources_1/ip/ila_1/sim/ila_1.v" \

vlog -work xil_defaultlib \
"glbl.v"
