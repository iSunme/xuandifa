clc
clear
x = linspace(0,10,1000);
y = sin(2*pi*0.1*x);
figure
ha1 = subplot(211); % ��ȡ��������
pos = [0.1 0.7 1 1 0.1 0.7]; % ������λ��
[h h_a h_p h_arrow] = plot_with_arrow( ha1,x,y,'k',pos ); % ֱ������������λ�ã��ݲ�֧�ּ�ͷ������λ��������ֵ���
htext_x = Arrow_Xlabel([],'ʱ��/s',pos);
htext_y = Arrow_Ylabel([],'��ֵ/V',pos);
htext_title = Arrow_Title([],'ͼ�� Test');
ha2 = subplot(212); % ��ȡ��������
pos = [0 0 0 0.6 0.8 0.2]; % ������λ��
[h h_a h_p h_arrow] = plot_with_arrow( ha2,x,y,'k',pos ); % ֱ������������λ�ã��ݲ�֧�ּ�ͷ������λ��������ֵ���
htext_x = Arrow_Xlabel([],'ʱ��/s',pos);
htext_y = Arrow_Ylabel([],'��ֵ/V',pos);
htext_title = Arrow_Title([],'ͼ�� Test');