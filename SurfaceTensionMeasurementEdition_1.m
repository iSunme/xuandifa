clc;clear;% ��ҵ���
%% ͼ����
I=rgb2gray(imread('001.jpg'));
level=graythresh(I);
I=edge(imfill(~im2bw(I,level),'holes'));imshow(I);
%% ���ر궨
[x,y]=find(I(1:10,:)==1);
needle_pixsize=mean(y(11:20,1)-y(1:10,1));
needle_size=0.0016/needle_pixsize;%0.0016Ϊ��ͷʵ����ֱ��
%% ͼ��ü���ȥ����⣬ֻ��Һ�Σ�
%��ʱ�Ȳ�д�������ֶ��ü�
%% Һ����бУ����1��������б�Ƕȣ�2�������任����
find(I==1)