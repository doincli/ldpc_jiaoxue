`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/10 14:34:09
// Design Name: 
// Module Name: ldpc_control
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

// rd_en clk data rst_n

module ldpc_control(
    clk,
    rst_n,
    rd_en,
    data_in,
    data_out,
    charisk
    );


parameter  DATA_W = 16;
parameter  IDLE = 0;
parameter  S_out = 1;
parameter  P_out = 2;
parameter  Frame_delay = 4;


//输入信号
input  clk;
input  rst_n;
input rd_en;
input [DATA_W-1:0] data_in;

//输出信号
output  [DATA_W-1:0]data_out;
output [1:0] charisk;

//中间信号
reg [2:0]state_c; //现在的状态
reg [2:0]state_n; //下一个的状态   
wire IDL2S_out;
wire S_out2P_out;
wire P_out2Frame;
wire Frame2S_out;
wire add_s_cnt;
wire end_s_cnt;
reg [4:0] s_cnt;
wire add_p_cnt;
wire end_p_cnt;
reg [5:0] p_cnt;
reg [DATA_W-1:0] data_out;
reg [DATA_W-1:0] data_tmp;
reg [DATA_W-1:0] p_data;
reg [1:0] charisk;
wire [255:0] ldpc_data;
wire [1023 : 0] rom_data1;
wire [1023 : 0] rom_data2;
wire [1023 : 0] rom_data3;
wire [1023 : 0] rom_data4;
wire add_addra;
wire end_addra;
reg [3:0] addra;
reg rd_tmp;

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        rd_tmp <= 0;
    end
    else begin
        rd_tmp <= rd_en;
    end
end

//状态机
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        state_c <= IDLE;
    end
    else begin
        state_c <= state_n;
    end
end
                    
always@(*)begin
    case(state_c)
        IDLE:begin
            if(IDL2S_out)begin
                state_n = S_out;
            end
            else begin
                state_n = state_c;
            end
        end
        S_out:begin
            if(S_out2P_out)begin
                state_n = P_out;
            end
            else begin
                state_n = state_c;
            end
        end
        P_out:begin
            if(P_out2Frame)begin
                state_n = Frame_delay;
            end
            else begin
                state_n = state_c;
            end
        end
        Frame_delay:begin
            if(Frame2S_out)begin
                state_n = S_out;
            end
            else begin
                state_n = state_c;
            end
        end
        default:begin
            state_n = IDLE;
        end
    endcase
end
                    
assign IDL2S_out = state_c == IDLE && rd_en == 1;
assign S_out2P_out = state_c == S_out &&  s_cnt == 16;//计算器  17个数 进入
assign P_out2Frame = state_c == P_out && p_cnt == 15 ; //计算器  16个数 进入  
assign Frame2S_out = state_c == Frame_delay;   

//计算S 到哪里了            
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        s_cnt <= 0;
    end
    else if(add_s_cnt)begin
        if(end_s_cnt)
            s_cnt <= 0;
        else
            s_cnt <= s_cnt + 1;
    end
end
                    
assign add_s_cnt =  state_c == S_out;  
assign end_s_cnt = add_s_cnt && s_cnt== 16; 

//P 到哪里了               
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        p_cnt <= 0;
    end
    else if(add_p_cnt)begin
        if(end_p_cnt)
            p_cnt <= 0;
        else
            p_cnt <= p_cnt + 1;
    end
end
                    
assign add_p_cnt =  state_c == P_out;  
assign end_p_cnt = add_p_cnt && p_cnt== 15; 


always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_tmp <= 0;
    end
    else begin
        data_tmp <= data_in;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        data_out <=1'b0 ;     //初始化
    end
    else if(state_c==S_out && s_cnt == 0)begin
        data_out <= 16'h02bc;
    end
    else if(state_c==S_out && s_cnt >= 1)begin
        data_out <= data_tmp;
    end
    else if(state_c==P_out)begin
        data_out <= p_data;  //p_data 补上
    end
    else if(state_c==Frame_delay)begin
        data_out <= 0;  
    end
    else begin
        data_out <= 1'b0;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        charisk <= 0;
    end
    else if(state_c==S_out && s_cnt == 0)begin
        charisk <= 2'd1;
    end
end

//调用rom                
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addra <= 0;
    end
    else if(add_addra)begin
        if(end_addra)
            addra <= 0;
        else
            addra <= addra + 1;
    end
end
                    
assign add_addra = rd_tmp;  
assign end_addra = add_addra && addra== 15; 

H1 h1 (
  .clka(clk),    // input wire clka
  .addra(addra),  // input wire [3 : 0] addra
  .douta(rom_data1)  // output wire [1023 : 0] douta
);

H2 h2 (
  .clka(clk),    // input wire clka
  .addra(addra),  // input wire [3 : 0] addra
  .douta(rom_data2)  // output wire [1023 : 0] douta
);

H3 h3 (
  .clka(clk),    // input wire clka
  .addra(addra),  // input wire [3 : 0] addra
  .douta(rom_data3)  // output wire [1023 : 0] douta
);

H4 h4 (
  .clka(clk),    // input wire clka
  .addra(addra),  // input wire [3 : 0] addra
  .douta(rom_data4)  // output wire [1023 : 0] douta
);


//p计算

encode_p  p1(
    .clk(clk),
    .rst_n(rst_n),
    .r_en(rd_tmp),
    .H_data(rom_data1),
    .fifo_in(data_tmp),
    .encoder_count(s_cnt),
    .p_out(ldpc_data[255:192]) //p_out(p_out[63:0])
    );


encode_p  p2(
    .clk(clk),
    .rst_n(rst_n),
    .r_en(rd_tmp),
    .H_data(rom_data2),
    .fifo_in(data_tmp),
    .encoder_count(s_cnt),
    .p_out(ldpc_data[191:128]) //p_out(p_out[63:0])
    );

encode_p  p3(
    .clk(clk),
    .rst_n(rst_n),
    .r_en(rd_tmp),
    .H_data(rom_data3),
    .fifo_in(data_tmp),
    .encoder_count(s_cnt),
    .p_out(ldpc_data[127:64]) //p_out(p_out[63:0])
    );


encode_p  p4(
    .clk(clk),
    .rst_n(rst_n),
    .r_en(rd_tmp),
    .H_data(rom_data4),
    .fifo_in(data_tmp),
    .encoder_count(s_cnt),
    .p_out(ldpc_data[63:0]) //p_out(p_out[63:0])
    );           

    always@(*)begin
      case (p_cnt)
       4'd0 :  p_data = ldpc_data[255:240];
       4'd1 :  p_data = ldpc_data[239:224];
       4'd2 :  p_data = ldpc_data[223:208];
       4'd3 :  p_data = ldpc_data[207:192];
       4'd4 :  p_data = ldpc_data[191:176];
       4'd5 :  p_data = ldpc_data[175:160];
       4'd6 :  p_data = ldpc_data[159:144];
       4'd7 :  p_data = ldpc_data[143:128];
       4'd8 :  p_data = ldpc_data[127:112];
       4'd9 :  p_data = ldpc_data[111:96];
       4'd10 :  p_data = ldpc_data[95:80];
       4'd11 :  p_data = ldpc_data[79:64];
       4'd12 :  p_data = ldpc_data[63:48];
       4'd13 :  p_data = ldpc_data[47:32];
       4'd14 :  p_data = ldpc_data[31:16];
       4'd15 :  p_data = ldpc_data[15:0];
        default: p_data = 0;
      endcase

    end 
    
    ila_0 ldpc_result (
        .clk(clk), // input wire clk
        .probe0(data_out), // input wire [15:0] probe0
        .probe1(s_cnt) ,// input wire [15:0] probe0
        .probe2(addra) // input wire [15:0] probe0
    );
endmodule
