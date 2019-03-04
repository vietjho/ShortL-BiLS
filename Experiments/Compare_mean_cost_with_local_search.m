clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_eg_1_cost = [];
ShortL_BiLS_se_1_cost = [];
ShortL_BiLS_eg_2_cost = [];
ShortL_BiLS_se_2_cost = [];
ShortL_BiLS_eg_3_cost = [];
ShortL_BiLS_se_3_cost = [];
ShortL_BiLS_eg_4_cost = [];
ShortL_BiLS_se_4_cost = [];

FullL_BiLS_eg_cost = [];
FullL_BiLS_se_cost = [];
HillClimbing_eg_cost = [];
HillClimbing_se_cost = [];
LSSofar_eg_cost = [];
LSSofar_se_cost = [];

ShortL_BFS_eg_cost = [];
ShortL_BFS_se_cost = [];

for i = 50:50:600
    %---------------------------------------
    %ShortL-BiLS - k =1
    filename_eg = ['ShortL_BiLS_eg_1_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_1_cost = [ShortL_BiLS_eg_1_cost,f_arr_cost];
    %
    filename_se = ['ShortL_BiLS_se_1_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_1_cost = [ShortL_BiLS_se_1_cost,f_arr_cost];
    %----------------------------------------    
    %ShortL-BiLS - k =2
    filename_eg = ['ShortL_BiLS_eg_2_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_2_cost = [ShortL_BiLS_eg_2_cost,f_arr_cost];
    %
    filename_se = ['ShortL_BiLS_se_2_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_2_cost = [ShortL_BiLS_se_2_cost,f_arr_cost];
    %---------------------------------------    
    %ShortL-BiLS - k =3
    filename_eg = ['ShortL_BiLS_eg_3_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_3_cost = [ShortL_BiLS_eg_3_cost,f_arr_cost];
    %
    filename_se = ['ShortL_BiLS_se_3_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_3_cost = [ShortL_BiLS_se_3_cost,f_arr_cost];
    %---------------------------------------
    %ShortL-BiLS - k =4
    filename_eg = ['ShortL_BiLS_eg_4_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_4_cost = [ShortL_BiLS_eg_4_cost,f_arr_cost];  
    %
    filename_se = ['ShortL_BiLS_se_4_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_4_cost = [ShortL_BiLS_se_4_cost,f_arr_cost]; 
    %---------------------------------------
    %FullL-BiLS
    filename_eg = ['FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_cost = [FullL_BiLS_eg_cost,f_arr_cost];
    %
    filename_se = ['FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_cost = [FullL_BiLS_se_cost,f_arr_cost];
    %---------------------------------------
    %Hill Climbing
    filename_eg = ['HillClimbing_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    HillClimbing_eg_cost = [HillClimbing_eg_cost,f_arr_cost];
    %
    filename_se = ['HillClimbing_se',num2str(i),'.mat'];    
    load(filename_se);    
    HillClimbing_se_cost = [HillClimbing_se_cost,f_arr_cost];
    %----------------------------------------   
    %SLS
    filename_eg = ['LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_cost = [LSSofar_eg_cost,f_arr_cost];
    %
    filename_se = ['LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);
    LSSofar_se_cost = [LSSofar_se_cost,f_arr_cost];
    %----------------------------------------
    %ShortL-BFS
    filename_bfs = ['ShortL_BFS',num2str(i),'.mat'];    
    load(filename_bfs);    
    ShortL_BFS_eg_cost = [ShortL_BFS_eg_cost,f_arr_cost_eg];
    ShortL_BFS_se_cost = [ShortL_BFS_se_cost,f_arr_cost_se];      
    
end
% %----------------------------------------------------------
c1 = ShortL_BiLS_eg_4_cost - ShortL_BFS_eg_cost;
idx = find(c1~=0);
c2 = FullL_BiLS_eg_cost - ShortL_BFS_eg_cost;
c3 = HillClimbing_eg_cost - ShortL_BFS_eg_cost;
c4 = LSSofar_eg_cost - ShortL_BFS_eg_cost;
h = bar([log10(c1(idx))',log10(c2(idx))',log10(c3(idx))',log10(c4(idx))'],0.5);
hand = legend(h,'ShortL-BiLS with k = 4',...
                'BiLS','Hill-Climbing','SLS',...
                'Location','northwest','Orientation','horizontal');
 xticks(1:2:28);
%------------------------------------------------------------

%------------------------------------------------------------
set(hand,'fontsize',13,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
%
hx = xlabel('SM instances');
set(hx, 'FontSize', 13)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',13)
% 
hy = ylabel('The cost distance (log10)');
set(hy,'FontSize',13)
grid on
box on