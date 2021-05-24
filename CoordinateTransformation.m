function [xh,yh]=CoordinateTransformation(i)%i为传入的边界二值矩阵
    %坐标变换
    [yy,xx]=find(i==1);
    x0=round(mean(xx));
    y0=max(yy);
    xh=xx-x0;
    yh=-yy+y0;
end
    
    