`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 12:12:26
// Design Name: 
// Module Name: fifo_ber
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ber_fifo_test(
    clk    ,
    rst_n  ,
    data_in,
    clk_50 ,
    locked,
    data_fifo
   
    );

    //��������
    parameter      DATA_W =         16;

    //�����źŶ���
    input               clk    ;
    input               rst_n  ;
    input   [DATA_W-1:0]  data_in   ; 
    //����źŶ���
    output[DATA_W-1:0]  data_fifo   ;
    output clk_50 ;
    output locked ;
 
    //�м��źŶ���
    reg  [DATA_W-1:0]  data_tmp; 
    reg wr_start ;
    reg rd_start ;
    
    wire full ;
    wire empty;
    wire wr_rst_busy;
    wire rd_rst_busy;
    wire add_cnt;
    wire end_cnt;
    reg [5:0] cnt;
 
    //����һ֡  ���ģ���ǵ͵�ƽ��λ
    always  @(posedge clk )begin
        if(rst_n==1'b0)begin
          data_tmp <= 0;
        end
        else begin
            data_tmp <= data_in;
        end
    end
   
    //дʹ���ź�
    always  @(posedge clk )begin
        if(rst_n==1'b0)begin
            wr_start <= 0;
        end
        else if(data_in == 16'h02bc) begin
            wr_start <= 1 ;
        end
        else if(16 == cnt) begin 
           wr_start <= 0;
         end
    end

   //дʹ�ܼ�����
   
   always @(posedge clk )begin
       if(!rst_n)begin
           cnt <= 0;
       end
       else if(add_cnt)begin
           if(end_cnt)
               cnt <= 0;
           else
               cnt <= cnt + 1;
       end
   end

   assign add_cnt = wr_start ;       
   assign end_cnt = add_cnt && cnt==16 ;   
 
   //��ʹ�ܿ���
   always  @(posedge clk)begin
       if(rst_n==1'b0)begin
           rd_start <= 0;
       end
//       else if(empty)begin
//           rd_start <= 0 ;
//       end
       else if(16 == cnt )begin
          rd_start <= 1 ;
       end
   end


   

    //ip ����

  ber_pll ber_pll
   (
    // Clock out ports
    .clk_out1(clk_50),     // output clk_out1
    // Status and control signals
    .reset(~rst_n), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));      // input clk_in1



ber_fifo ber_fifo (
  .rst(~locked),                  // input wire rst
  .wr_clk(clk),            // input wire wr_clk
  .rd_clk(clk_50),            // input wire rd_clk
  .din(data_tmp),                  // input wire [15 : 0] din
  .wr_en(wr_start),              // input wire wr_en
  .rd_en(rd_start),              // input wire rd_en
  .dout(data_fifo),                // output wire [15 : 0] dout
  .full(full),                // output wire full
  .empty(empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy),  // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
);
    

    endmodule

