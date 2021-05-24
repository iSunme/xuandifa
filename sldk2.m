function dy=sldk2(~,y,bata)
    %求解悬滴表面张力的的非线性微分方程组
    %y(1)为横坐标值，y(2)为纵坐标值，y(3)为角度
    dy(1)=cos(y(3));
    dy(2)=sin(y(3));
    dy(3)=2-bata*y(2)-sin(y(3))/y(1);
    dy=dy(:);
end
