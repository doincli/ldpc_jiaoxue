vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" "+incdir+../../../../test_ldpc.srcs/sources_1/ip/ber_ila/hdl/verilog" \
"../../../../test_ldpc.srcs/sources_1/ip/ber_ila/sim/ber_ila.v" \

vlog -work xil_defaultlib \
"glbl.v"
