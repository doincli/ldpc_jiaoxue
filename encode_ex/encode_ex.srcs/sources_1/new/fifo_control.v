`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/09 15:02:03
// Design Name: 
// Module Name: fifo_control
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

module fifi_control(
    clk    ,
    rst_n  ,
    data_in,
    rd_clk,
    rd_en,
    data_out
    );

    //参数定义
    parameter      DATA_W =         16;

    //输入信号定义
    input               clk    ;
    input               rst_n  ;
    input [DATA_W-1:0]   data_in;

    //输出信号定义
    output[DATA_W-1:0]  data_out   ;
    output rd_clk;
    output rd_en;
    
    //中间信号
    wire wr_clk;
    wire rd_clk;
    wire locked;
    reg [DATA_W-1:0]  data_tmp;
    reg wr_en;
    wire full;
    wire add_cnt;
    wire end_cnt;
    reg [2:0] cnt;
    wire add_cnt1;
    wire end_cnt1;
    reg [6:0] cnt1;
    wire empty;
    wire wr_rst_busy;
    wire rd_rst_busy;
    reg rd_en1;
    wire rd_end;
    wire rd_start;
    wire wr_start;
    wire wr_end;
    //FIFO控制逻辑
    assign rd_en = rd_en1;
    //打一拍
    always  @(posedge wr_clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            data_tmp <= 0;
        end
        else begin
            data_tmp <= data_in;
        end
    end

    //缓存数据  wr_en
    always  @(posedge wr_clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            wr_en <= 0;
        end
        else if(wr_start)begin
            wr_en <= 0;
        end
        else if(wr_end) begin 
            wr_en <= 1;
        end
    end
    
    assign wr_start = data_in == 16'h02bc ;
    assign wr_end  = data_tmp == 16'h02bc && full != 1;
    
    //缓存 5帧数据
    always @(posedge wr_clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt <= 0;
        end
        else if(add_cnt)begin
            if(end_cnt)
                cnt <= 5;
            else
                cnt <= cnt + 1;
        end
    end

    assign add_cnt = data_in == 16'h02bc && wr_en==1 ;       
    assign end_cnt = add_cnt && cnt== 5 ;   

    //读使能控制
    always  @(posedge rd_clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            rd_en1 <= 0;
        end
        else if(rd_start) begin
             rd_en1 <= 1;
        end
        else if(rd_end)begin
            rd_en1 <= 0;
        end
    end

    assign rd_start = cnt == 5 && cnt1 == 1;
    assign rd_end  = cnt == 5 && cnt1 == 17 ;


    always @(posedge rd_clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt1 <= 0;
        end
        else if(add_cnt1)begin
            if(end_cnt1)
                cnt1 <= 0;
            else
                cnt1 <= cnt1 + 1;
        end
    end

    assign add_cnt1 = cnt == 5;       
    assign end_cnt1 = add_cnt1 && cnt1== 34-1;   



    //PLL 
  clk_wiz_0 pll
   (
    // Clock out ports
    .clk_out1(wr_clk),     // output clk_out1
    .clk_out2(rd_clk),     // output clk_out2
    // Status and control signals
    .reset(!rst_n), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk)
    );      // input clk_in1


fifo_generator_0 fifo (
  .rst(!locked),                  // input wire rst
  .wr_clk(wr_clk),            // input wire wr_clk
  .rd_clk(rd_clk),            // input wire rd_clk
  .din(data_tmp),                  // input wire [15 : 0] din
  .wr_en(wr_en),              // input wire wr_en
  .rd_en(rd_en),              // input wire rd_en
  .dout(data_out),                // output wire [15 : 0] dout
  .full(full),                // output wire full
  .empty(empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy),  // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
);


wr_fifo fifo_look (
	.clk(wr_clk), // input wire clk
	.probe0(data_tmp), // input wire [15:0]  probe0  
	.probe1(wr_en), // input wire [0:0]  probe1 
	.probe2(full) // input wire [0:0]  probe2
);


rd_fifo rd_look (
	.clk(rd_clk), // input wire clk
	.probe0(data_out), // input wire [15:0]  probe0  
	.probe1(empty), // input wire [0:0]  probe1 
	.probe2(wr_rst_busy), // input wire [0:0]  probe2 
	.probe3(rd_en), // input wire [0:0]  probe3 
	.probe4(rd_rst_busy) // input wire [0:0]  probe4
);



    endmodule


