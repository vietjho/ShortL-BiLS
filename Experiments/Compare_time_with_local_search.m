clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_eg_1_time = [];
ShortL_BiLS_se_1_time = [];

ShortL_BiLS_eg_2_time = [];
ShortL_BiLS_se_2_time = [];

ShortL_BiLS_eg_3_time = [];
ShortL_BiLS_se_3_time = [];

ShortL_BiLS_eg_4_time = [];
ShortL_BiLS_se_4_time = [];

FullL_BiLS_eg_time = [];
FullL_BiLS_se_time = [];

LSSofar_eg_time = [];
LSSofar_se_time = [];

ShortL_BFS_time = [];

for i = 50:50:600
    %---------------------------------------
    %ShortL-BiLS-k=1
    filename_eg = ['..\outputs\ShortL_BiLS_eg_1_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_1_time(end+1) = f_arr_time;
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_1_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_1_time(end+1) = f_arr_time;
    %---------------------------------------
    %ShortL-BiLS-k=2
    filename_eg = ['..\outputs\ShortL_BiLS_eg_2_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_2_time(end+1) = f_arr_time;
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_2_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_2_time(end+1) = f_arr_time;    
    %---------------------------------------
    %ShortL-BiLS-k=3
    filename_eg = ['..\outputs\ShortL_BiLS_eg_3_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_3_time(end+1) = f_arr_time;
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_3_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_3_time(end+1) = f_arr_time;
    %---------------------------------------
    %ShortL-BiLS-k=4
    filename_eg = ['..\outputs\ShortL_BiLS_eg_4_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_4_time(end+1) = f_arr_time;  
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_4_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_4_time(end+1) = f_arr_time;  
    %===============================================
    %***********************************************   
    %FullL-BiLS
    filename_eg = ['..\outputs\FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_time(end+1) = f_arr_time;
    %
    filename_se = ['..\outputs\FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_time(end+1) = f_arr_time;
    %---------------------------------------
    %SLS
    filename_eg = ['..\outputs\LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_time(end+1) = f_arr_time;
    %
    filename_se = ['..\outputs\LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);    
    LSSofar_se_time(end+1) = f_arr_time;
    %----------------------------------------
    %Short-BFS
    filename_eg = ['..\outputs\ShortL_BFS',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BFS_time(end+1) = f_arr_time;
end
%--------------------------------------------
ShortL_BFS_time
log10(ShortL_BFS_time)

ShortL_BiLS_eg_4_time
log10(ShortL_BiLS_eg_4_time)

sum(LSSofar_eg_time)/sum(ShortL_BiLS_eg_4_time)
%

% [50:50:600;ShortL_BiLS_eg_4_time; log10(ShortL_BiLS_eg_4_time);...
% LSSofar_eg_time; log10(LSSofar_eg_time);...
% LSSofar_eg_time./ShortL_BiLS_eg_4_time]'
%--------------------------------------------
figure;
hold on;
%----------------------------------------------
%ShortL-BiLS-eg
h1 = plot(log10(ShortL_BiLS_eg_1_time),'--r*');
color = [0 0.5 0.12];
h2 = plot(log10(ShortL_BiLS_eg_2_time),'--s','color',color);
h3 = plot(log10(ShortL_BiLS_eg_3_time),'--b^');
h4 = plot(log10(ShortL_BiLS_eg_4_time),'--m>');
%FullL-BiLS
color = [0.2 0.35 0.5];
h5 = plot(log10(FullL_BiLS_eg_time),'--v','color',color);
%SLS
h6 = plot(log10(LSSofar_eg_time),'--ko');
%Hill Climbing
color = [0.5 0.15 0.12];
h7 = plot(log10(ShortL_BFS_time),'--s','color',color);
%----------------------------------------------
%ShortL-BiLS-se
% h1 = plot(log10(ShortL_BiLS_se_1_time),'--r*');
% color = [0 0.5 0.12];
% h2 = plot(log10(ShortL_BiLS_se_2_time),'--s','color',color);
% h3 = plot(log10(ShortL_BiLS_se_3_time),'--b^');
% h4 = plot(log10(ShortL_BiLS_se_4_time),'--m>');
% %FullL-BiLS
% color = [0.2 0.35 0.5];
% h5 = plot(log10(FullL_BiLS_se_time),'--v','color',color);
% %SLS
% h6 = plot(log10(LSSofar_se_time),'--ko');
% %ShortL-BFS
% color = [0.5 0.15 0.12];
% h7 = plot(log10(ShortL_BFS_time),'--s','color',color);
%------------------------------------------------
%
hand = legend([h1,h2,h3,h4,h5,h6,h7],...
       'ShortL-BiLS with k = 1',...
       'ShortL-BiLS with k = 2',...
       'ShortL-BiLS with k = 3',...
       'ShortL-BiLS with k = 4',...   
       'BiLS',...
       'SLS','BFS');       
%----------------------------------------------
set(hand,'fontsize',13,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
xlim([1 12]);
xticks(1:12);
xticklabels({'50','100','150','200','250','300','350','400','450','500','550','600'})
ylim([-1.5,3]);
yticks(-1.5:0.5:3);

hx = xlabel('SM instance sizes');
set(hx, 'FontSize', 13)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',13)

hy = ylabel('Average execution time (log10)');
set(hy,'FontSize',13)

grid on
ax = gca;
set(ax,'GridLineStyle','--') 
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.4;
box on
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1.2, 0.95]);
