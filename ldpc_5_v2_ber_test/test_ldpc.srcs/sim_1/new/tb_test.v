`timescale 1 ns/1 ns

module ram_test_tb();

//ʱ�Ӻ͸�λ
reg clk  ;
reg rst_n;

//uut�������ź�
reg[15:0]  din  ;



//uut������ź�

wire[63:0] dout;


//ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
parameter CYCLE    = 10;

//��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
parameter RST_TIME = 3 ;
wire en;
wire [15:0] decode;
//�����Ե�ģ������
all_control uut(
    .clk          (clk), 
    .rst_n        (rst_n),
    .din         (din),
   .decode   (decode)
//    .data_out        (dout)

);


//���ɱ���ʱ��50M
initial begin
    clk = 0;
    forever
    #(CYCLE/2)
    clk=~clk;
end

//������λ�ź�
initial begin
    rst_n = 1;
    #2;
    rst_n = 0;
    #(CYCLE*RST_TIME);
    rst_n = 1;
end

reg [15:0] rom_data[0:33];

 initial
    begin
           $readmemh("C:/Users/doinc/Desktop/ldpc_yi/data.dat",rom_data);
    end
reg [6:0] read_counter_i;

always  @(posedge clk or negedge rst_n)begin
        if(!rst_n || (read_counter_i == 6'd33))  
        begin
             read_counter_i   <= 6'd0;
        end
        else 
        begin
            read_counter_i   <= read_counter_i + 6'd1;    
        end 
end

always @(*) begin

    din = rom_data[read_counter_i];   
end




endmodule
