clc;clear;
%% 常参数设置
format long
needle_diameter=0.0016;%针尖的直径为0.002m
%% 图像预处理
I=imread('75.jpg');
I1=rgb2gray(I);
level=graythresh(I1);
I1=~im2bw(I1,level);imshow(I1);
I2=imfill(I1,'holes');
imshow(~I2);
I3=edge(I2);pause(0.3);
%% 图像分割（手动分割针尖和液滴）
I4=imcrop(I2);
imshow(I4);pause(0.4);
x=edge(I4);
%% 初始bata和R0计算
S=solve_s(I3);%求形状因子S
De_pixel=solve_De(I3);%求De
pixel_size=PixelSize(I3);%求实际一个像素点的尺寸
De=De_pixel*pixel_size;
beta0=0.12836-0.7577*S+1.7713*S^2-0.5426*S^3;
R0=0.5*De/(0.9987+0.1971*beta0-0.0734*beta0^2+0.34708*beta0^3)+0.00002;
%% 液滴（无针尖）图像处理与坐标变换
[x,y]=CoordinateTransformation(x);
[X1,Y1]=size(x);
j=1;
[x1_b,x1_b2]=size(find(x>0));
x1=zeros(3,x1_b);
for i=1:X1
    if x(i)>0
        x1(1,j)=x(i);
        x1(2,j)=y(i);
        j=j+1;
    end
end
x2=x1.*pixel_size;%实际尺寸下的液滴轮廓坐标，非像素坐标
%% 求解微分方程
y0 = [0.0000001,0,0];bata=0.34;s1=3.8;%线长，理论液滴半周长
tspan=linspace(0,s1,x1_b*10);
[X,Y]=ode45(@sldk2,tspan,y0,[],bata);
%% 绘制理论曲线和实际拍摄图像
figure;plot(x2(1,:),x2(2,:),'r.');hold on;grid on;
plot(Y(:,1).*R0,Y(:,2).*R0,'b.');
legend('实际拍摄轮廓','理论计算轮廓');legend('boxoff');axis([0 4*10^(-3) 0 5*10^(-3)])
%% 对应点匹配存放于x3
x3=x2(1:2,:)'./R0;%实际轮廓点
siz_x3=size(x3);
x4=Y(:,1:2);%理论轮廓点
siz_x4=size(x4);
for i=1:siz_x3
    for j=1:siz_x4
        if x4(j,2)-x3(i,2)<=0.0001
            x4(j,3)=x3(i,1);
            x3(i,3)=x4(j,1);
        end
        continue;
    end
end
figure;plot(x3(:,1),x3(:,2),'.r',x3(:,3),x3(:,2),'.b');axis([0 3 0 3]);grid on;
legend('实际拍摄轮廓','理论计算轮廓');legend('boxoff');
%% 构造评价函数
x3(:,4)=x3(:,1)-x3(:,3);
E=sum(abs(x3(:,4)));