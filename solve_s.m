function S=solve_s(Io)
    %�������Һ�ε�de��ds�����㲢����S
    %����de��ds
    de=0;
    xb1=0;
    xb2=0;
    mde=0;mi=0;
    I4=Io;
    md=0;%ˮ����ʹ�������
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
        mdxi=xb2-xb1;%�������ֱ��
        if mdxi>de
           de=mdxi;%ѡ��������ֱ��de
           mi=i;
        end
        if mdxi==0
            if i>100
                md=i-1;
                break;
            end
        end  
    end
    %������ds
    xb11=0;
    xb22=0;
    i=md-de;
    for j=1:size(I4,2)
        if xb11==0
           if I4(i,j)
              xb11=j;
             % j=j+2;
           end
        end
        if xb22==0
            if j>xb11+2
               if I4(i,j)
                  xb22=j;
               end
            end
        end
    end
    ds=xb22-xb11;
    S=ds/de;

end