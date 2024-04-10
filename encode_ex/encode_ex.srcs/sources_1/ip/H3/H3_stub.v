// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Wed Apr 10 15:14:12 2024
// Host        : User-2021FZLJGL running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/ldpc_jiaoxue/ldpc_jiaoxue/encode_ex/encode_ex.srcs/sources_1/ip/H3/H3_stub.v
// Design      : H3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2017.4" *)
module H3(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[3:0],douta[1023:0]" */;
  input clka;
  input [3:0]addra;
  output [1023:0]douta;
endmodule