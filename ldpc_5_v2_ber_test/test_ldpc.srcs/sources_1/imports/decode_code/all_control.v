`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module all_control( 
    clk    ,
    rst  ,
    din,    
    decode 
    //�����ź�,����dout
//    data_out   
    );

    //��������
    parameter      DATA_W =         16;
    parameter      DATA_R =         64;

    //�����źŶ���
    input               clk    ;
    input               rst  ;
    input[DATA_W-1:0]   din    ; 
    //����źŶ���
    output [DATA_W-1:0]  decode         ;
      
    //�м��źŶ���   
    
    //��Ƶģ���źŶ���
     wire clk_50;
     wire clk_500;
     wire locked ;
     wire rst_n;
    //����ģ���źŶ���
    wire   tem_vaild           ;
    wire [63:0]  fifoin_out;
    wire [2:0] sel ;
    //error module �źŶ���
    
    wire [255:0]  data_out_s1   ;
    wire [2:0]sn_cnt1;
    
    //�ڶ���
    wire [255:0]  data_out_s2   ;
    wire [2:0]sn_cnt2;
    
    //������
    wire [255:0]  data_out_s3   ;
        wire [2:0]sn_cnt3;
        
    //��4��
    wire [255:0]  data_out_s4   ;
            wire [2:0]sn_cnt4;
            
   //��4��
   wire [255:0]  data_out_s5   ;
   wire [2:0]sn_cnt5;
                
      //fn ģ���źŶ���
       reg f_start1 ;
      wire [2:0]fn_cnt1 ;
      wire [4095:0] data_final1;
      
      //�ڶ���
      reg f_start2 ;
      wire [2:0]fn_cnt2 ;
      wire [4095:0] data_final2;
      
      //������
      reg f_start3 ;
            wire [2:0]fn_cnt3 ;
            wire [4095:0] data_final3;
     //��4��
           reg f_start4 ;
         wire [2:0]fn_cnt4 ;
        wire [4095:0] data_final4;
      
      //��5��
                   reg f_start5 ;
                 wire [2:0]fn_cnt5 ;
                wire [4095:0] data_final5;
              
      //find_max ģ���źŶ���
      reg find_max_en1;      
      wire [3:0] find_max_cnt1 ;
      wire [7:0] findout_max1;
      wire [9:0] findout_count1;
      
      //�ڶ���
      reg find_max_en2;      
      wire [3:0] find_max_cnt2 ;
      wire [7:0] findout_max2;
      wire [9:0] findout_count2;
      
        //��3��
          reg find_max_en3;      
          wire [3:0] find_max_cnt3 ;
          wire [7:0] findout_max3;
          wire [9:0] findout_count3;
     
      //��4��
                   reg find_max_en4;      
                   wire [3:0] find_max_cnt4 ;
                   wire [7:0] findout_max4;
                   wire [9:0] findout_count4; 
      //��5��
          reg find_max_en5;      
          wire [3:0] find_max_cnt5 ;
          wire [7:0] findout_max5;
          wire [9:0] findout_count5; 
          
      //invert ģ���źŶ���
       reg   invert_en1 ;
       wire [3:0] iteration_num1;
       wire [63:0] invert_out1;
       wire  error_en1 ;
       wire [511:0] c_code1 ;
       
       //�ڶ���
       reg   invert_en2;
       wire [3:0] iteration_num2;
       wire [63:0] invert_out2;
       wire  error_en2 ;
       wire [511:0] c_code2 ;
       
       //������
        reg   invert_en3;
        wire [3:0] iteration_num3;
        wire [63:0] invert_out3;
        wire  error_en3 ;
        wire [511:0] c_code3 ;
        
        //��4��
                reg   invert_en4;
                wire [3:0] iteration_num4;
                wire [63:0] invert_out4;
                wire  error_en4 ;
                wire [511:0] c_code4 ;
                
        //��5��
                                reg   invert_en5;
                                wire [3:0] iteration_num5;
                                wire [63:0] invert_out5;
                                wire  error_en5;
                                wire [511:0] c_code5 ;     
   
      //����ģ���źŶ���
//      wire [63:0] buff_data;
//      wire buff_en ;
      wire error_start1;
      wire [63:0] error_data_in1 ;
      
      //�ڶ���
      wire error_start2;
      wire [63:0] error_data_in2 ;
      
      //������
       wire error_start3;
       wire [63:0] error_data_in3 ;
       
       //��4��
      wire error_start4;
      wire [63:0] error_data_in4 ;
       //��5��
           wire error_start5;
           wire [63:0] error_data_in5 ;
           
           
       reg [2:0] cnt;
       reg [2:0] sel_cnt ;
       //reg [0:0] sel_cnt1 ;
//       wire  [DATA_W-1:0]  decode         ;

//����Ķ�·ѡ��ģ��
reg [63:0] fifoin_out1;
reg [63:0] fifoin_out2;
reg tem_vaild1;
reg tem_vaild2 ;
reg [63:0] fifoin_out3;
reg tem_vaild3;
reg [63:0] fifoin_out4;
reg tem_vaild4;
reg [63:0] fifoin_out5;
reg tem_vaild5;
      always  @(posedge clk_500 or negedge rst_n)begin
      if(rst_n==1'b0)begin
      fifoin_out1 <= 0 ;
      tem_vaild1  <= 0  ;
      end
       else if (sel==0)begin 
             fifoin_out1 <= fifoin_out ;
             tem_vaild1  <= tem_vaild  ;
         end
         else if(sel==1) begin 
             fifoin_out2 <= fifoin_out ;
             tem_vaild2  <= tem_vaild  ;
         end
         else if(sel==2)begin 
             fifoin_out3 <= fifoin_out ;
             tem_vaild3  <= tem_vaild  ;
         end
         else if(sel==3)begin 
             fifoin_out4 <= fifoin_out ;
             tem_vaild4  <= tem_vaild  ;
                  end
        else begin 
             fifoin_out5 <= fifoin_out ;
             tem_vaild5  <= tem_vaild  ;
           end
     end




//      f_start   fn ����ģ���ʹ���ź�
    //��һ��
      always  @(posedge clk_500 or negedge rst_n)begin//��Ƶ��
          if(rst_n==1'b0)begin
              f_start1 <=0 ;
          end
          else if(sn_cnt1==7)begin
              f_start1 <=1 ;
          end
          else if(fn_cnt1==5)begin    //�Լ�дģ���ʱ����ʱ���������ڣ������ˣ�ֱ�Ӹļ����� ����˼·��7
              f_start1 <=0 ;
          end
      end
 
    //�ڶ���
     always  @(posedge clk_500 or negedge rst_n)begin//��Ƶ��
        if(rst_n==1'b0)begin
            f_start2 <=0 ;
        end
        else if(sn_cnt2==7)begin
            f_start2 <=1 ;
        end
        else if(fn_cnt2==5)begin    //�Լ�дģ���ʱ����ʱ���������ڣ������ˣ�ֱ�Ӹļ����� ����˼·��7
            f_start2 <=0 ;
        end
    end
     
     
     //������
   
          always  @(posedge clk_500 or negedge rst_n)begin//��Ƶ��
             if(rst_n==1'b0)begin
                 f_start3 <=0 ;
             end
             else if(sn_cnt3==7)begin
                 f_start3 <=1 ;
             end
             else if(fn_cnt3==5)begin    //�Լ�дģ���ʱ����ʱ���������ڣ������ˣ�ֱ�Ӹļ����� ����˼·��7
                 f_start3 <=0 ;
             end
         end
         
         //��4��
            
                   always  @(posedge clk_500 or negedge rst_n)begin//��Ƶ��
                      if(rst_n==1'b0)begin
                          f_start4 <=0 ;
                      end
                      else if(sn_cnt4==7)begin
                          f_start4 <=1 ;
                      end
                      else if(fn_cnt4==5)begin    //�Լ�дģ���ʱ����ʱ���������ڣ������ˣ�ֱ�Ӹļ����� ����˼·��7
                          f_start4 <=0 ;
                      end
                  end
        //��5��
                              
               always  @(posedge clk_500 or negedge rst_n)begin//��Ƶ��
                    if(rst_n==1'b0)begin
                        f_start5 <=0 ;
                    end
                  else if(sn_cnt5==7)begin
                      f_start5 <=1 ;
                  end
             else if(fn_cnt5==5)begin    //�Լ�дģ���ʱ����ʱ���������ڣ������ˣ�ֱ�Ӹļ����� ����˼·��7
                     f_start5 <=0 ;
                 end
            end          
    //find_max  ����ģ���ʹ���ź�
    
    //��һ��
    always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
        if(rst_n==1'b0)begin
        find_max_en1 <= 0 ;
        end
        else if(fn_cnt1==7 )begin
        find_max_en1 <= 1 ;
        end
        else if(find_max_cnt1==8 )begin
          find_max_en1 <= 0 ;
        end
        else begin
        find_max_en1 <= find_max_en1;
        end
    end
    
    //�ڶ���
     always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
           if(rst_n==1'b0)begin
           find_max_en2 <= 0 ;
           end
           else if(fn_cnt2==7 )begin
           find_max_en2 <= 1 ;
           end
           else if(find_max_cnt2==8 )begin
             find_max_en2 <= 0 ;
           end
           else begin
           find_max_en2 <= find_max_en2;
           end
       end
       
       //������
       
            always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
                  if(rst_n==1'b0)begin
                  find_max_en3 <= 0 ;
                  end
                  else if(fn_cnt3==7 )begin
                  find_max_en3 <= 1 ;
                  end
                  else if(find_max_cnt3==8 )begin
                    find_max_en3 <= 0 ;
                  end
                  else begin
                  find_max_en3 <= find_max_en3;
                  end
              end
     //��4��
                   
                        always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
                              if(rst_n==1'b0)begin
                              find_max_en4 <= 0 ;
                              end
                              else if(fn_cnt4==7 )begin
                              find_max_en4 <= 1 ;
                              end
                              else if(find_max_cnt4==8 )begin
                                find_max_en4 <= 0 ;
                              end
                              else begin
                              find_max_en4 <= find_max_en4;
                              end
                          end
             //5ge              
                always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
                                if(rst_n==1'b0)begin
                                find_max_en5 <= 0 ;
                                end
                                else if(fn_cnt5==7 )begin
                                find_max_en5 <= 1 ;
                                end
                                else if(find_max_cnt5==8 )begin
                                  find_max_en5 <= 0 ;
                                end
                                else begin
                                find_max_en5 <= find_max_en5;
                                end
                            end                      
   // invert ģ������ź�
   always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
       if(rst_n==1'b0)begin
       invert_en1 <= 0 ;
       end
       else if(find_max_cnt1==8)begin
       invert_en1 <= 1;
       end
       else begin
       invert_en1 <= 0 ;
       end
   end
   
   //�ڶ���
      always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
       if(rst_n==1'b0)begin
       invert_en2 <= 0 ;
       end
       else if(find_max_cnt2==8)begin
       invert_en2 <= 1;
       end
       else begin
       invert_en2 <= 0 ;
       end
   end
   
    //��3��
        always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
         if(rst_n==1'b0)begin
         invert_en3 <= 0 ;
         end
         else if(find_max_cnt3==8)begin
         invert_en3 <= 1;
         end
         else begin
         invert_en3 <= 0 ;
         end
     end
  //4ge
      //��3��
      always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
       if(rst_n==1'b0)begin
       invert_en4 <= 0 ;
       end
       else if(find_max_cnt4==8)begin
       invert_en4 <= 1;
       end
       else begin
       invert_en4 <= 0 ;
       end
   end
   //5ge 
       //��3��
       always  @(posedge clk_500 or negedge rst_n)begin   //��Ƶ��
        if(rst_n==1'b0)begin
        invert_en5 <= 0 ;
        end
        else if(find_max_cnt5==8)begin
        invert_en5 <= 1;
        end
        else begin
        invert_en5 <= 0 ;
        end
    end
    //����ģ�����
    
    assign error_data_in1 =iteration_num1==0?fifoin_out1:invert_out1;
    assign error_start1 = iteration_num1==0?tem_vaild1:error_en1;
    assign error_data_in2 =iteration_num2==0?fifoin_out2:invert_out2;
    assign error_start2 = iteration_num2==0?tem_vaild2:error_en2;
    assign error_data_in3 =iteration_num3==0?fifoin_out3:invert_out3;
    assign error_start3 = iteration_num3==0?tem_vaild3:error_en3;
    assign error_data_in4 =iteration_num4==0?fifoin_out4:invert_out4;
    assign error_start4 = iteration_num4==0?tem_vaild4:error_en4;
    assign error_data_in5 =iteration_num5==0?fifoin_out5:invert_out5;
   assign error_start5 = iteration_num5==0?tem_vaild5:error_en5;
    
   //���ģ�����
    reg [511:0] code_fin;
    reg [3:0]   ilte_num_fin ;
//    assign code_fin = sel_cnt==0?c_code1:c_code2 ;
//    assign ilte_num_fin = sel_cnt==0?iteration_num1:iteration_num2 ;
always  @(posedge clk_500 or negedge rst_n)begin
if(rst_n==1'b0)begin
code_fin<=0;
end
   else if(sel_cnt==0)begin
    code_fin <= c_code1 ;
    end
    else if(sel_cnt==1)begin
        code_fin <=c_code2 ;
    end
    else if(sel_cnt==2)begin
            code_fin <=c_code3 ;
        end
        else if(sel_cnt==3)begin
                code_fin <=c_code4 ;
            end
    else begin
        code_fin <= c_code5 ;
    end
end

always  @(posedge clk_500 or negedge rst_n)begin
 if(rst_n==1'b0)begin
       ilte_num_fin <= 0 ;
       end
    else if(sel_cnt==0)begin
        ilte_num_fin <=iteration_num1;
    end
    else if(sel_cnt==1)begin
       ilte_num_fin  <=iteration_num2 ;
   end
   else if(sel_cnt==2)begin
          ilte_num_fin  <=iteration_num3 ;
      end
      else if(sel_cnt==3)begin
             ilte_num_fin <= iteration_num4 ;
         end
   else begin
       ilte_num_fin <= iteration_num5 ;
   end
end
  /*
    always  @(*)begin
        if(cnt==0) begin
            ilte_num_fin = iteration_num1 ;
        end
        else begin
            ilte_num_fin = iteration_num2 ;
        end
    end

    always  @(*)begin
        if(cnt==1) begin
            code_fin = c_code1 ;
        end
        else begin
            code_fin = c_code2 ;
        end
    end
*/

   //ģ����Ƽ�����
   wire add_cnt;
   wire end_cnt;
  
   always @(posedge clk_500 or negedge rst_n)begin
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

   assign add_cnt =(iteration_num1==9&&invert_en1==1)||(iteration_num2==9&&invert_en2)||(iteration_num3==9&&invert_en3)||(iteration_num4==9&&invert_en4)||(iteration_num5==9&&invert_en5) ;       
   assign end_cnt = add_cnt && cnt== 4;   

   always  @(posedge clk_500 or negedge rst_n)begin
       if(rst_n==1'b0)begin
           sel_cnt <= 0 ;
        
       end
       else begin
           sel_cnt <= cnt ;
        
       end
   end

    

   //ģ�����
      assign rst_n = locked;
       //pll ��Ƶ  
     ten_bit ten_bit
    (
     // Clock out ports
     .clk_out1(clk_50),     // output clk_out1
     .clk_out2(clk_500),     // output clk_out2
     // Status and control signals
     .reset(~rst), // input reset
     .locked(locked),       // output locked
    // Clock in ports
     .clk_in1(clk));      // input clk_in1
    
   //����ģ��
   buff buff1(
   .clk_50(clk_50),
   .clk_500(clk_500),
   .rst_n(rst_n),
   .din(din),
   .tem_vaild(tem_vaild),
   .dataout_sel(sel),
   .buff_out(fifoin_out)
   
   );

    
    
    //��һ·��ģ�����
    //����ͼ������ģ��

   error_control uu(
     .clk(clk_500),
     .rst_n(rst_n),
     .rd_en(error_start1), //error_start
     .data_in(error_data_in1), //error_data_in
     .data_out(data_out_s1),
     .cnt(sn_cnt1)
   );


    //У���Ӽ���ģ��
f_control f_con1(
.clk(clk_500),
.rst_n(rst_n),
.data_in(data_out_s1),
.r_en(f_start1),
.data_final(data_final1),
.cnt1(fn_cnt1)
);


//find_max ģ�����
find_max  find1(
.clk(clk_500),
.rst_n(rst_n),
.rd_en(find_max_en1),
.cnt(find_max_cnt1),
.din(data_final1),
.max1(findout_max1),
.count(findout_count1)
);


// invert ��תģ�����
invert inv1(
.clk(clk_500),
.rst_n(rst_n),
.max(findout_max1),
.count(findout_count1),
.din(error_data_in1),
.rd_en(error_start1),
.invert_en(invert_en1),
.invert_out(invert_out1),
.error_en(error_en1),    //��error module ��ʹ��
.cnt_num(iteration_num1),
.c_code(c_code1)
);


  
//
  //�ڶ�·ģ�����
//����ͼ������ģ��

 error_control uu2(
   .clk(clk_500),
   .rst_n(rst_n),
   .rd_en(error_start2), //error_start
   .data_in(error_data_in2), //error_data_in
   .data_out(data_out_s2),
   .cnt(sn_cnt2)
 );


  //У���Ӽ���ģ��
f_control f_con2(
.clk(clk_500),
.rst_n(rst_n),
.data_in(data_out_s2),
.r_en(f_start2),
.data_final(data_final2),
.cnt1(fn_cnt2)
);


//find_max ģ�����
find_max  find2(
.clk(clk_500),
.rst_n(rst_n),
.rd_en(find_max_en2),
.cnt(find_max_cnt2),
.din(data_final2),
.max1(findout_max2),
.count(findout_count2)
);


// invert ��תģ�����
invert inv2(
.clk(clk_500),
.rst_n(rst_n),
.max(findout_max2),
.count(findout_count2),
.din(error_data_in2),
.rd_en(error_start2),
.invert_en(invert_en2),
.invert_out(invert_out2),
.error_en(error_en2),    //��error module ��ʹ��
.cnt_num(iteration_num2),
.c_code(c_code2)
);

//��3·ģ�����
  //����ͼ������ģ��

   error_control uu3(
     .clk(clk_500),
     .rst_n(rst_n),
     .rd_en(error_start3), //error_start
     .data_in(error_data_in3), //error_data_in
     .data_out(data_out_s3),
     .cnt(sn_cnt3)
   );


    //У���Ӽ���ģ��
f_control f_con3(
.clk(clk_500),
.rst_n(rst_n),
.data_in(data_out_s3),
.r_en(f_start3),
.data_final(data_final3),
.cnt1(fn_cnt3)
);


//find_max ģ�����
find_max  find3(
.clk(clk_500),
.rst_n(rst_n),
.rd_en(find_max_en3),
.cnt(find_max_cnt3),
.din(data_final3),
.max1(findout_max3),
.count(findout_count3)
);


// invert ��תģ�����
invert inv3(
.clk(clk_500),
.rst_n(rst_n),
.max(findout_max3),
.count(findout_count3),
.din(error_data_in3),
.rd_en(error_start3),
.invert_en(invert_en3),
.invert_out(invert_out3),
.error_en(error_en3),    //��error module ��ʹ��
.cnt_num(iteration_num3),
.c_code(c_code3)
);

//��4·ģ�����
  //����ͼ������ģ��

   error_control uu4(
     .clk(clk_500),
     .rst_n(rst_n),
     .rd_en(error_start4), //error_start
     .data_in(error_data_in4), //error_data_in
     .data_out(data_out_s4),
     .cnt(sn_cnt4)
   );


    //У���Ӽ���ģ��
f_control f_con4(
.clk(clk_500),
.rst_n(rst_n),
.data_in(data_out_s4),
.r_en(f_start4),
.data_final(data_final4),
.cnt1(fn_cnt4)
);


//find_max ģ�����
find_max  find4(
.clk(clk_500),
.rst_n(rst_n),
.rd_en(find_max_en4),
.cnt(find_max_cnt4),
.din(data_final4),
.max1(findout_max4),
.count(findout_count4)
);


// invert ��תģ�����
invert inv4(
.clk(clk_500),
.rst_n(rst_n),
.max(findout_max4),
.count(findout_count4),
.din(error_data_in4),
.rd_en(error_start4),
.invert_en(invert_en4),
.invert_out(invert_out4),
.error_en(error_en4),    //��error module ��ʹ��
.cnt_num(iteration_num4),
.c_code(c_code4)
);


//��5·ģ�����
  //����ͼ������ģ��

   error_control uu5(
     .clk(clk_500),
     .rst_n(rst_n),
     .rd_en(error_start5), //error_start
     .data_in(error_data_in5), //error_data_in
     .data_out(data_out_s5),
     .cnt(sn_cnt5)
   );


    //У���Ӽ���ģ��
f_control f_con5(
.clk(clk_500),
.rst_n(rst_n),
.data_in(data_out_s5),
.r_en(f_start5),
.data_final(data_final5),
.cnt1(fn_cnt5)
);


//find_max ģ�����
find_max  find5(
.clk(clk_500),
.rst_n(rst_n),
.rd_en(find_max_en5),
.cnt(find_max_cnt5),
.din(data_final5),
.max1(findout_max5),
.count(findout_count5)
);


// invert ��תģ�����
invert inv5(
.clk(clk_500),
.rst_n(rst_n),
.max(findout_max5),
.count(findout_count5),
.din(error_data_in5),
.rd_en(error_start5),
.invert_en(invert_en5),
.invert_out(invert_out5),
.error_en(error_en5),    //��error module ��ʹ��
.cnt_num(iteration_num5),
.c_code(c_code5)
);


//���ģ�����
wire [15:0] decode ;
decode_out decode_out1(
.clk_50(clk_50),
.clk_500(clk_500),
.rst_n(rst_n),
.code(code_fin ),
.ilte_num(ilte_num_fin),
.decode(decode)

);






    endmodule

