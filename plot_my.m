clc
clear
x = linspace(0,10,1000);
y = sin(2*pi*0.1*x);
figure
ha1 = subplot(211); % 获取坐标轴句柄
pos = [0.1 0.7 1 1 0.1 0.7]; % 坐标轴位置
[h h_a h_p h_arrow] = plot_with_arrow( ha1,x,y,'k',pos ); % 直接输入坐标轴位置，暂不支持箭头坐标轴位置输入数值情况
htext_x = Arrow_Xlabel([],'时间/s',pos);
htext_y = Arrow_Ylabel([],'幅值/V',pos);
htext_title = Arrow_Title([],'图形 Test');
ha2 = subplot(212); % 获取坐标轴句柄
pos = [0 0 0 0.6 0.8 0.2]; % 坐标轴位置
[h h_a h_p h_arrow] = plot_with_arrow( ha2,x,y,'k',pos ); % 直接输入坐标轴位置，暂不支持箭头坐标轴位置输入数值情况
htext_x = Arrow_Xlabel([],'时间/s',pos);
htext_y = Arrow_Ylabel([],'幅值/V',pos);
htext_title = Arrow_Title([],'图形 Test');