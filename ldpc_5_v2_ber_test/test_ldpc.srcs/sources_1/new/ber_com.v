`timescale 1ns / 1ps


module ber_com(
    clk    ,
    rst_n  ,
    data_in,
    rst_in
    //charisk_in
    );

    //参数定义
    parameter      DATA_W =         16;
    parameter      DATA_ERROR =         28;

    //输入信号定义
    input               clk    ;
    input               rst_n  ;
    input               rst_in ;   
    input[DATA_W-1:0]  data_in   ;
      
    //中间信号定义

    reg [DATA_W-1:0] data_tmp;
    reg [DATA_W-1:0] reciver_data;
    reg   compute_en;
    wire   error_en1;
    wire   error_en2;
    wire   error_en3;
    wire   error_en4;
    wire   error_en5;
    wire   error_en6;
    wire   error_en7;
    wire   error_en8;
    wire   error_en9;
    wire   error_en10;
    wire   error_en11;
    wire   error_en12;
    wire   error_en13;
    wire   error_en14;
    wire   error_en15;
    wire   error_en16;
    reg [DATA_ERROR-1:0] error_num1 ;
    reg [DATA_ERROR-1:0] error_num2 ;
    reg [DATA_ERROR-1:0] error_num3 ;
    reg [DATA_ERROR-1:0] error_num4 ;
    reg [DATA_ERROR-1:0] error_num5 ;
    reg [DATA_ERROR-1:0] error_num6 ;
    reg [DATA_ERROR-1:0] error_num7 ;
    reg [DATA_ERROR-1:0] error_num8 ;
    reg [DATA_ERROR-1:0] error_num9 ;
    reg [DATA_ERROR-1:0] error_num10 ;
    reg [DATA_ERROR-1:0] error_num11 ;
    reg [DATA_ERROR-1:0] error_num12 ;
    reg [DATA_ERROR-1:0] error_num13 ;
    reg [DATA_ERROR-1:0] error_num14 ;
    reg [DATA_ERROR-1:0] error_num15 ;
    reg [DATA_ERROR-1:0] error_num16 ;
     
    wire [DATA_W-1:0] original_data;

    reg [31:0] frame_num ;
    reg [31:0] error_num ;
    reg [1:0]  comp_cnt;
    reg    [4 : 0] addra;
    wire add_cnt;
    wire end_cnt;
    reg [1:0] cnt;

    //数据打2拍
    always  @(posedge clk)begin
        if(rst_n)begin
            data_tmp <= 0;
            reciver_data <= 0;
        end
        else begin
            data_tmp <= data_in;
            reciver_data <= data_tmp;
        end
    end
 
 //计数使能延时一个拍
 always  @(posedge clk)begin
         if(rst_n)begin
             comp_cnt <= 0;             
         end
         else begin
             comp_cnt <= cnt;        
         end
     end
     
    //使能信号
   always  @(posedge clk)begin
       if(rst_n)begin
           compute_en <= 0 ;
       end
       else if(data_in ==16'h02bc)begin
           compute_en <= 1 ;
       end
       else begin 
          compute_en <= compute_en;
       end
   end

   //数据缓存3帧 防止前面的数据出错
 
   always @(posedge clk)begin
       if(rst_n)begin
           cnt <= 0;
       end
       else if(add_cnt)begin
           if(end_cnt)
               cnt <= 3;
           else
               cnt <= cnt + 1;
       end
   end

   assign add_cnt = data_in ==16'h02bc;       
   assign end_cnt = add_cnt && cnt== 3 ;   

   //误码计算的使能
   assign error_en1 = reciver_data[0] != original_data[0];
   assign error_en2 = reciver_data[1] != original_data[1];
   assign error_en3 = reciver_data[2] != original_data[2];
   assign error_en4 = reciver_data[3] != original_data[3];
   assign error_en5 = reciver_data[4] != original_data[4];
   assign error_en6 = reciver_data[5] != original_data[5];
   assign error_en7 = reciver_data[6] != original_data[6];
   assign error_en8 = reciver_data[7] != original_data[7];
   assign error_en9 = reciver_data[8] != original_data[8];
   assign error_en10 = reciver_data[9] != original_data[9];
   assign error_en11 = reciver_data[10] != original_data[10];
   assign error_en12 = reciver_data[11] != original_data[11];
   assign error_en13 = reciver_data[12] != original_data[12];
   assign error_en14 = reciver_data[13] != original_data[13];
   assign error_en15 = reciver_data[14] != original_data[14];
   assign error_en16 = reciver_data[15] != original_data[15];

   //计算读出了几帧数据
always @(posedge clk)begin
       if(rst_n||rst_in)begin
           frame_num <= 0;
       end
       else if(data_in ==16'h02bc && 3 == cnt)begin
           frame_num <= frame_num + 1;
       end
       else begin 
           frame_num <= frame_num ;  
       end
   end

   //计算错误了多少个bit
   always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num1 <= 0 ;
       end
       else if(error_en1 && 3==comp_cnt)begin
           error_num1 <= error_num1 +1;
       end
       else begin 
           error_num1 <= error_num1 ;
       end
   end

 always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num2 <= 0 ;
       end
       else if(error_en2 && 3==comp_cnt)begin
           error_num2 <= error_num2 +1;
       end
       else begin 
           error_num2 <= error_num2 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num3 <= 0 ;
       end
       else if(error_en3 && 3==comp_cnt)begin
           error_num3 <= error_num3 +1;
       end
       else begin 
           error_num3 <= error_num3 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num4 <= 0 ;
       end
       else if(error_en4 && 3==comp_cnt)begin
           error_num4 <= error_num4 +1;
       end
       else begin 
           error_num4 <= error_num4 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num5 <= 0 ;
       end
       else if(error_en5 && 3==comp_cnt)begin
           error_num5 <= error_num5 +1;
       end
       else begin 
           error_num5 <= error_num5 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num6 <= 0 ;
       end
       else if(error_en6 && 3==comp_cnt)begin
           error_num6 <= error_num6 +1;
       end
       else begin 
           error_num6 <= error_num6 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num7 <= 0 ;
       end
       else if(error_en7 && 3==comp_cnt)begin
           error_num7 <= error_num7 +1;
       end
       else begin 
           error_num7 <= error_num7 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num8 <= 0 ;
       end
       else if(error_en8 && 3==comp_cnt)begin
           error_num8 <= error_num8 +1;
       end
       else begin 
           error_num8 <= error_num8 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num9 <= 0 ;
       end
       else if(error_en9 && 3==comp_cnt)begin
           error_num9 <= error_num9 +1;
       end
       else begin 
           error_num9 <= error_num9 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num10 <= 0 ;
       end
       else if(error_en10 && 3==comp_cnt)begin
           error_num10 <= error_num10 +1;
       end
       else begin 
           error_num10 <= error_num10 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num11 <= 0 ;
       end
       else if(error_en11 && 3==comp_cnt)begin
           error_num11 <= error_num11 +1;
       end
       else begin 
           error_num11 <= error_num11 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num12 <= 0 ;
       end
       else if(error_en12 && 3==comp_cnt)begin
           error_num12 <= error_num12 +1;
       end
       else begin 
           error_num12 <= error_num12 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num13 <= 0 ;
       end
       else if(error_en13 && 3==comp_cnt)begin
           error_num13 <= error_num13 +1;
       end
       else begin 
           error_num13 <= error_num13 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num14 <= 0 ;
       end
       else if(error_en14 && 3==comp_cnt)begin
           error_num14 <= error_num14 +1;
       end
       else begin 
           error_num14 <= error_num14 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num15 <= 0 ;
       end
       else if(error_en15 && 3==comp_cnt)begin
           error_num15 <= error_num15 +1;
       end
       else begin 
           error_num15 <= error_num15 ;
       end
   end
   
      always  @(posedge clk)begin
       if(rst_n||rst_in)begin
           error_num16 <= 0 ;
       end
       else if(error_en16 && 3==comp_cnt)begin
           error_num16 <= error_num16 +1;
       end
       else begin 
           error_num16 <= error_num16 ;
       end
   end
   
   always  @(posedge clk)begin
    if(rst_n||rst_in)begin
        error_num <= 0 ;
    end
    else begin 
        error_num <= error_num1+error_num2+error_num3+error_num4+error_num5+error_num6+error_num7+error_num8+error_num9+error_num10+error_num11+error_num12+error_num13+error_num14+error_num15+error_num16 ;
    end
end
 //rom核数据读出
 /*
 //rom地址控制
  always  @(posedge clk)begin
       if(rst_n||data_in == 16'h02bc)begin
           addra <= 0 ;
       end
       else if(3 == cnt)begin
           addra <= addra +1;
       end
//       else begin 
//           addra <= addra ;
//       end
   end
 */
 always  @(posedge clk)begin
       if(rst_n||(data_in ==16'h02bc&&frame_num==1))begin
           addra <= 0 ;
       end
       else if(16 == addra)begin
            addra <= 0;
       end
       else if(3 == cnt)begin
           addra <= addra +1;
       end
       
//       else begin 
//           addra <= addra ;
//       end
   end

 data_pri origina (
   .clka(clk),    // input wire clka
   .addra(addra),  // input    wire [4 : 0] addra
   .douta(original_data)  // output wire [15 : 0] douta
 );
 
 //ila调用
 ber_ila ber_test (
     .clk(clk), // input wire clk
     .probe0(original_data), // input wire [15:0]  probe0  
     .probe1(reciver_data), // input wire [15:0]  probe1 
     .probe2(frame_num), // input wire [31:0]  probe2 
     .probe3(error_num) // input wire [31:0]  probe3
 );
    
    endmodule
