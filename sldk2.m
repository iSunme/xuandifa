function dy=sldk2(~,y,bata)
    %������α��������ĵķ�����΢�ַ�����
    %y(1)Ϊ������ֵ��y(2)Ϊ������ֵ��y(3)Ϊ�Ƕ�
    dy(1)=cos(y(3));
    dy(2)=sin(y(3));
    dy(3)=2-bata*y(2)-sin(y(3))/y(1);
    dy=dy(:);
end
