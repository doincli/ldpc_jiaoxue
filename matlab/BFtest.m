%BF硬判决算法   迭代次数为10次
clc;
clear;
load H;
H1=H_GUESS(H,512);% 256*512
%H2是参与运算的生成p矩阵
H2=H1(:,1:256);
% string S; 这部分也可以改成读txt文件，后面同字符串转换
% S=["0" "2" "0" "3" "0" "4" "0" "3" "0" "6" "0" "5" "0" "8" "0" "7" "0" "a" "0" "9" "0" "c" "0" "b" "0" "e" "0" "d" ...
%     "1" "0" "0" "f" "1" "2" "1" "1" "1" "4" "1" "3" "1" "6" "1" "5" "1" "8" "1" "7" "1" "a" "1" "9" "1" "c" "1" "b" ...
%     "1" "e" "1" "d" "0" "1" "0" "0" ];

% 256 16*16 = 256   s = 256   校验矩阵 256*512   
% 校验矩阵大小  s = 256  c = [s p] p =256   M = p行 * (s+p)列
% c = N   s -- k   H = M*N  M = (N-K)  编码  码率 = k/N  码率越大越好  1/2  传输性能一般  p 纠错性能很好  H  4/5
S=["0" "4" "0" "3" "0" "6" "0" "5" "0" "8" "0" "7" "0" "a" "0" "9" "0" "c" "0" "b" "0" "e" "0" "d" "1" "0" "0" "f" ...
    "1" "2" "1" "1" "1" "4" "1" "3" "1" "6" "1" "5" "1" "8" "1" "7" "1" "a" "1" "9" "1" "c" "1" "b" "1" "e" "1" "d" "0" "1" "0" "0" "0" "1" "2" "3" ];
%先转换成10进制
D = hex2dec(S);
%先转换成2进制
B = dec2bin(D);

%信息码字s
s=[];
for j=1:1:64
     for i=1:1:4
    s(i+(j-1)*4)=str2num(B(j,i));
    end
end

P=s*H2';
%小p1为最后的校验位,最终的P
p1=rem(P,2);
c=[s p1];%c为码字
%%
%输出Y
rrr = fopen('bianma111.txt','a');%% 打开文件
for i = 1:1:32;
ya(i)=string(strrep(num2str(c(16*i-15:16*i)), ' ', ''));
fprintf(rrr,'%04s',num2str(dec2hex(bin2dec(ya(i))),'%04d'));
fprintf(rrr,'\n');  %% 换行
end
fclose(rrr);
%%
%BF译码算法
iteration=10;   %迭代次数
y=[1,1,c(1,3:256),1,1,0,1,1,0,1,0,1,c(1,266:280),1,0,1,1,0,0,0,c(1,288:512)];
%  y=[c(1,1:256),0,1,0,1,1,1,0,1,1,c(1,266:512)];
% y=c(1,1:512);
%y=[1,1,c(1,3:512)];%随机错误几个数字 第257   260   263   265错了
col=512;
number=find(y~=c) 
%%
%输出Y
rrr = fopen('5通道.txt','a');%% 打开文件
for i = 1:1:32;
ya(i)=string(strrep(num2str(y(16*i-15:16*i)), ' ', ''));
fprintf(rrr,'%04s',num2str(dec2hex(bin2dec(ya(i))),'%04d'));
fprintf(rrr,'\n');  %% 换行
end
fclose(rrr);
%% 测试代码
% y=[c(1,1:9),1,c(1,11:512)];
% number=find(y~=c) ;
%%
col=512;
% iteration=10;  
sn=mod(H*y',2);
number1=find(sn~=0) ;

%%
% rrr = fopen('data_test.txt','a');%% 打开文件
% for i = 1:1:512;
% fprintf(rrr,'%02s',num2str(dec2hex(f(i))));
% % fprintf(rrr,' ');  %% 换行
% end
% fclose(rrr);
%%
% s=mod(H*y',2);
% f(n)=s'*H(:,n);
%%
for i=1:iteration
s=mod(H*y',2);
if s==0
    y=y;
    break
else 
    for n=1:col
    f(n)=s'*H(:,n);
    end   
%  number=find(T>=4) 
 [ma,I]=max(f);
  y(I)=not(y(I));
 
%     for n=1:col
%         if f(n)>=4
%             y(n)=mod(y(n)+1,2);
%         end
%     end
end
end
isequal(y,c)
%%

rrr = fopen('yima.txt','a');%% 打开文件
for i = 1:1:32;
ya(i)=string(strrep(num2str(y(16*i-15:16*i)), ' ', ''));
fprintf(rrr,'%04s',num2str(dec2hex(bin2dec(ya(i))),'%04d'));
fprintf(rrr,'\n');  %% 换行
end
fclose(rrr);

number=find(y~=c) %该命令返回所有对应x元素不等于y元素的下标。
c_error=c(number);y_error=y(number);

%%  一帧完整的译码过程
% s=mod(H*y',2);
%  for n=1:col
%    T(n)=s'*H(:,n);
%  end
%  number=find(T>=0) 
%  [ma,I]=max(T)
%   y(I)=not(y(I));
%  

 