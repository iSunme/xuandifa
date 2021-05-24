function pixs=PixelSize(Io)
    %求像素尺寸
    I4=Io;
    %%
    %利用针尖确定像素实际大小
    xb111=0;
    xb222=0;
    des11=zeros(1,20);%ds1是针尖直径
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
    %像素点的实际大小
    pixs=0.00160045/ds1;%涉及重要常数针头直径1.6mm,0.001601429m
end