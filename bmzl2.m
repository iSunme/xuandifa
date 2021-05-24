% %%
% %��Ե���
% clc;clear;
% I=imread('.jpg');%��ͼΪԭ��ɫͼ
% I2= rgb2gray(I);%�ҶȻ�
% %imshow(I2)
% I3= imbinarize(I2);%��ֵ��
% I4=edge(I3);%ȡ��Ե
% imshow(I4);    
%%
%��Ե���(���Զ����հ�)
clear;clc;
I = imread('001.jpg');
I=rgb2gray(I);
level=graythresh(I);
I = im2bw(I,level);
I = ~I;
I1 = imfill(I,'holes');
I4=edge(I1);
figure
imshow(I4);
%%
%����de��ds
de=0;
xb1=0;
xb2=0;
mde=0;
mi=0;
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
de
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
ds
S=ds/de

%%
%�������ȷ������ʵ�ʴ�С
xb111=0;
xb222=0;
des11=zeros(1,20);%ds1�����ֱ��
for i=1:20
    for j=1:size(I4,2)
       if xb111==0
          if I4(i,j)
             xb111=j;
            % j=j+2;
          end
       end
       if xb222==0
           if j>xb111+2
              if I4(i,j)
                 xb222=j;
              end
           end
       end
    end
    des11(1,i)=xb222-xb111;
end
ds1=mean(des11);
%���ص��ʵ�ʴ�С
xj=0.00160045/ds1%�漰��Ҫ������ͷֱ��1.6mm,0.001601429m
%%
%�����¶������ܶȱ仯
w=0.009;%NaCl��������
t=33;%����
p1=1006+737.7*w-0.311*t-0.001993*t*t;
pp=101325-119*133/12;
p2=1.293*(pp/101325)*(273.15/(t+273.15));
% p1=1006;%���������¶ȱ仯���ܶ�p1,p2ֱ��ȡ����
% p2=1.293;
g=9.7966;
a=floor(S*100)-29;
b=round(S*1000)-10*floor(S*100)+1;
load('HS.mat')
H1=HS(a,b)
r=(p1-p2)*g*de*de*H1*xj*xj;
rl=0;%NaCl��������ϵ���������������¶����ۼ���ֵ
r1=0.07549+0.0367*w-0.0001485*t;
 %%����������
 et=(abs(r1-r))/r1;
fprintf('��Һ��ı�������ϵ������ֵΪ��%fN/m\n����ֵΪ��%fN/m\n������Ϊ��%2.2f%%\n',r,r1,et*100)

           