function [xh,yh]=CoordinateTransformation(i)%iΪ����ı߽��ֵ����
    %����任
    [yy,xx]=find(i==1);
    x0=round(mean(xx));
    y0=max(yy);
    xh=xx-x0;
    yh=-yy+y0;
end
    
    