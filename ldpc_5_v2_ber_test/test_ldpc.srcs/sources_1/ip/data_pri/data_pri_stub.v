// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Fri Jun  3 11:11:37 2022
// Host        : LAPTOP-9P7C5HJO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top data_pri -prefix
//               data_pri_ data_pri_stub.v
// Design      : data_pri
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2017.4" *)
module data_pri(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[4:0],douta[15:0]" */;
  input clka;
  input [4:0]addra;
  output [15:0]douta;
endmodule