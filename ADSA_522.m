clc;clear;
%% 常参数设置
format long;
needle_diameter=0.0016;%针尖的直径为0.002m
%% 图像预处理
I=imread('33.jpg');
I1=rgb2gray(I);
level=graythresh(I1);
I2=imfill(~im2bw(I1,level),'holes');
I3=edge(I2);pause(0.3);
%% 初始bata和R0计算
S=solve_s(I3);%求形状因子S
De_pixel=solve_De(I3);%求De
pixel_size=PixelSize(I3);%求实际一个像素点的尺寸
De=De_pixel*pixel_size;
beta0=0.12836-0.7577*S+1.7713*S^2-0.5426*S^3;
R0=0.5*De/(0.9987+0.1971*beta0-0.0734*beta0^2+0.34708*beta0^3);
%% 图像分割（手动分割针尖和液滴）
I4=imcrop(I2);
imshow(I4);pause(0.4);
I5=edge(I4);
%% 液滴坐标变换
%坐标变换
[yy,xx]=find(I5==1);
x0=round(mean(xx));
y0=max(yy);
xh=xx-x0;
yh=-yy+y0;
imshow(I5);
plot(xh,yh,'.b','MarkerSize',1);axis([-120 120 0 300]);%set(gca,'XAxisLocation','origin','YAxisLocation','origin')
plot(xh.*pixel_size,yh.*pixel_size,'.b','MarkerSize',1);xlabel('x(m)')
ylabel('y(m)');axis([-2*10^(-3) 2*10^(-3) 0 5*10^(-3)])
axis([-2*10^(-3) 2*10^(-3) 0 5*10^(-3)]);
[X1,Y1]=size(xh);
[x1_b,x1_b2]=size(find(xh>0));
x1=zeros(3,x1_b);j=1;
for i=1:X1
    if xh(i)>0
        x1(1,j)=xh(i);
        x1(2,j)=yh(i);
        j=j+1;
    end
end
x2=x1.*pixel_size;%实际尺寸下的液滴轮廓坐标，非像素坐标
%% 未进行优化可视化
y_cs = [0.0000001,0,0];s1=3.8;tspan=linspace(0,s1,x1_b*10);
[X,Y]=ode45(@sldk2,tspan,y_cs,[],beta0);
figure;plot(x2(1,:),x2(2,:),'r.');hold on;grid on;
plot(Y(:,1).*R0,Y(:,2).*R0,'b.');
legend('实际拍摄轮廓','理论计算轮廓');legend('boxoff');
%% 优化R0
R0i=R0-0.0002:0.00001:R0+0.0002;
[R0i_l,R0i_b]=size(R0i);
Er=zeros(1,R0i_b);
for i=1:R0i_b
    x5=x2(1:2,:)'./R0i(i);%实际轮廓点
    siz_x5=size(x5);
    y0 = [0.0000001,0,0];bata=beta0;s1=3.8;%线长，理论液滴半周长
    tspan=linspace(0,s1,x1_b*10);
    [X,Y]=ode45(@sldk2,tspan,y0,[],bata);
    x4=Y(:,1:2);%理论轮廓点
    siz_x4=size(x4);
    for iii=1:siz_x5
        for j=1:siz_x4
            if x4(j,2)-x5(iii,2)<=0.0001
                x4(j,3)=x5(iii,1);
                x5(iii,3)=x4(j,1);
            end
            continue;
        end
    end
%     x5(:,4)=x5(:,1)-x5(:,3);
%     Er(i)=sum(abs(x5(:,4)));
     Er(i)=abs(max(x5(:,1))-max(x5(:,3)));
end
[min_Er,miEr_i]=min(Er);
R0i_zy=R0i(miEr_i);
%% 求解微分方程
y0 = [0.0000001,0,0];s1=3.8;%线长，理论液滴半周长
tspan=linspace(0,s1,x1_b*10);
batai=beta0-0.04:0.001:beta0+0.04;
[bata_l,bata_b]=size(batai);
E=zeros(1,bata_b);
for i=1:bata_b
   [X,Y]=ode45(@sldk2,tspan,y0,[],batai(i));
   x3=x2(1:2,:)'./R0i_zy;%实际轮廓点
   siz_x3=size(x3);
   x4=Y(:,1:2);%理论轮廓点
   siz_x4=size(x4);
   for ii=1:siz_x3
       for j=1:siz_x4
           if x4(j,2)-x3(ii,2)<=0.0001
               x4(j,3)=x3(ii,1);
               x3(ii,3)=x4(j,1);
           end
           continue;
       end
   end
   x3(:,4)=abs(x3(:,1)-x3(:,3));
   E(i)=sum(x3(:,4));
end
%% 求优化合适的bata
[min_E,miE_i]=min(E);
bata_zy=batai(miE_i);
%% 可视化
y_cs = [0.0000001,0,0];s1=3.8;tspan=linspace(0,s1,x1_b*10);
[X,Y]=ode45(@sldk2,tspan,y_cs,[],bata_zy);
figure;plot(x2(1,:),x2(2,:),'r.');hold on;grid on;
plot(Y(:,1).*R0i_zy,Y(:,2).*R0i_zy,'b.');
legend('实际拍摄轮廓','理论计算轮廓');legend('boxoff');
%% 求解
dtrou=1000;
g=9.8;
gama=(dtrou*g*R0i_zy^2)/bata_zy