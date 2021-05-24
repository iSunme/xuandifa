function De=solve_De(Io)
    %求De
    I4=Io;
    de=0;
    xb1=0;
    xb2=0;
    mde=0;
    mi=0;
    md=0;%水滴最低处横坐标
    for i=1:size(I4,1)
        xb1=0;xb2=0;
        for j=1:size(I4,2)
            if xb1==0
               if I4(i,j)
                  xb1=j;
                  j=j+5;
               end
            end
            if xb2==0
                if I4(i,j)
                   xb2=j;
                end
            end
        end
        mdxi=xb2-xb1;%计算截面直径
        if mdxi>de
           de=mdxi;%选出最大截面直径de
           mi=i;
        end
        if mdxi==0
            if i>100
                md=i-1;
                break;
            end
        end  
    end
    De=de;
    
end