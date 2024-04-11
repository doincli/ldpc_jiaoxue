-makelib ies_lib/xil_defaultlib -sv \
  "D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/fpga/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../test_ldpc.srcs/sources_1/ip/ber_pll/ber_pll_clk_wiz.v" \
  "../../../../test_ldpc.srcs/sources_1/ip/ber_pll/ber_pll.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

