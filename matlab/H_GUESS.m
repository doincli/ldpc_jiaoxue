function arry=H_GUESS(H,N)                  %У������˹��Ԫ

f=rank(H);
A=H;

for c=1:N                   %����һ��1*n�ľ����±߻��õ�
    B(1,c)=0;
end

%�������ǽ��и�˹��Ԫ
for k=f:-1:2
    t=k+f;      %k+256
    for i=k-1:-1:1;
        if(A(k,t)~=0)        %������Ϊ0ʱ�����и��еļ���
           divisor=A(i,t)/A(k,t); 
           A(i,:)=xor(A(i,:),A(k,:)*divisor);
        else
            for n= k:-1:1;
                if(A(n,t)~=0)
                    B(1,:)=A(k,:);
                    A(k,:)=A(n,:);
                    A(n,:)=B(1,:);
                end
            end
        end
    end
end

%�������ǽ��и�˹��Ԫ
for j=1:f-1                         %��˹��Ԫ���㷨
    p=j+f;
    for i=(j+1):f
        if(A(j,p)~=0)        %������Ϊ0ʱ�����и��еļ���
           divisor=A(i,p)/A(j,p);
           A(i,:)=xor(A(i,:),A(j,:)*divisor);
        else                           %����Ϊ0ʱ���ҵ���ǰ���У�Ԫ�ز�Ϊ0�����������߽��н���
            for k=j:f                  %��ʱ�õ������涨���һ��n�еľ���
                if(A(k,p)~=0)     %������Ԫ�ؽ��н���
                    B(1,:)=A(j,:);
                    A(j,:)=A(k,:);
                    A(k,:)=B(1,:);
                end
            end
        end
    end
end
arry=A;