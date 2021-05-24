clc;clear;% 毕业设计
%% 图像处理
I=rgb2gray(imread('001.jpg'));
level=graythresh(I);
I=edge(imfill(~im2bw(I,level),'holes'));imshow(I);
%% 像素标定
[x,y]=find(I(1:10,:)==1);
needle_pixsize=mean(y(11:20,1)-y(1:10,1));
needle_size=0.0016/needle_pixsize;%0.0016为针头实测外直径
%% 图像裁剪（去除针尖，只留液滴）
%暂时先不写，先用手动裁剪
%% 液滴倾斜校正（1、计算倾斜角度；2、矫正变换矩阵）
find(I==1)