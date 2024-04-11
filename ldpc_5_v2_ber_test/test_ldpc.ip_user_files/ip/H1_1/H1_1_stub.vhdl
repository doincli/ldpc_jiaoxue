-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Tue Jul 19 09:42:56 2022
-- Host        : User-2021FZLJGL running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub E:/ldpc_5_v2_ber_test/test_ldpc.srcs/sources_1/ip/H1_1/H1_1_stub.vhdl
-- Design      : H1_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity H1_1 is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 1023 downto 0 )
  );

end H1_1;

architecture stub of H1_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[3:0],clk,spo[1023:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2017.4";
begin
end;
