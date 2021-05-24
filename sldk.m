function dy=sldk(~,y,bata)
    dy(1)=cos(y(3));
    dy(2)=sin(y(3));
    dy(3)=2-bata*y(2)-sin(y(3))/y(1);
    dy=dy(:);
end

