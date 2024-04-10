`timescale 1 ns/1 ns

module fifo_control_tb();

//ʱ�Ӻ͸�λ
reg clk  ;
reg rst_n;

//uut�������ź�
reg[15:0]  data_in  ;

//uut������ź�
wire      rd_en;
wire[15:0] data_out;


//ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�//50MHz
parameter CYCLE    = 20;

//��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
parameter RST_TIME = 150 ;

//�����Ե�ģ������
fifo_control uut(
    .clk          (clk     ), 
    .rst_n        (rst_n   ),
    .data_in      (data_in    ),
    .data_out     (data_out   ),
    .rd_en        (rd_en   )

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


reg [15:0] rom_data[0:16];

 initial
    begin
           $readmemh("C:/Users/doinc/Desktop/my_ldpc/my_code/data.dat",rom_data);
    end
reg [4:0] read_counter_i;

always  @(posedge clk or negedge rst_n)begin
        if(!rst_n || (read_counter_i == 5'd16))  
        begin
             read_counter_i   <= 5'd0;
        end
        else 
        begin
            read_counter_i   <= read_counter_i + 5'd1;    
        end 
end

always @(posedge clk) begin

    data_in <= rom_data[read_counter_i];   
end






endmodule

