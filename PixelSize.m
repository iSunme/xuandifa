function pixs=PixelSize(Io)
    %�����سߴ�
    I4=Io;
    %%
    %�������ȷ������ʵ�ʴ�С
    xb111=0;
    xb222=0;
    des11=zeros(1,20);%ds1�����ֱ��
    for i=1:20
        for j=1:size(I4,2)
           if xb111==0
              if I4(i,j)
                 xb111=j;
                % j=j+2;
              end
           end
           if xb222==0
               if j>xb111+2
                  if I4(i,j)
                     xb222=j;
                  end
               end
           end
        end
        des11(1,i)=xb222-xb111;
    end
    ds1=mean(des11);
    %���ص��ʵ�ʴ�С
    pixs=0.00160045/ds1;%�漰��Ҫ������ͷֱ��1.6mm,0.001601429m
end