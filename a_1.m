clear;clc;
%% �����������
y0 = [0.0000001,0,0];
for bata=0.1:0.08:0.6
   s1=4;%�߳�������Һ�ΰ��ܳ�
   bu_chang=0.01;
   tspan=0:bu_chang:s1;
   [T,Y] = ode45(@sldk,tspan,y0,[],bata);
   Y(:,4)=-Y(:,1);
   x3i=[Y(:,1);Y(:,4)]; y3i=[Y(:,2);Y(:,2)];
   plot(x3i,y3i,'.');
   axis([-5 5 0 5]);  hold on;
end

  

%%
%����任
clc;clear;
B=imread('33.jpg');%��ͼΪԭ��ɫͼ
B= im2bw(B);
B= ~B;
I1 = imfill(B,'holes');%���հ�
A=edge(I1);
imshow(A);
[X,Y]=find(A==1);
x1=(max(X)+min(X))/2;

%%
%Ŀ�꺯������





