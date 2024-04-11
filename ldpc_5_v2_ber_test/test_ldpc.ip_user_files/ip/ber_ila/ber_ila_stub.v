// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Fri Jun  3 11:14:30 2022
// Host        : LAPTOP-9P7C5HJO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/doinc/Desktop/decode_final_test/ldpc_5_v2/test_ldpc.srcs/sources_1/ip/ber_ila/ber_ila_stub.v
// Design      : ber_ila
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.4" *)
module ber_ila(clk, probe0, probe1, probe2, probe3)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[15:0],probe1[15:0],probe2[31:0],probe3[31:0]" */;
  input clk;
  input [15:0]probe0;
  input [15:0]probe1;
  input [31:0]probe2;
  input [31:0]probe3;
endmodule
