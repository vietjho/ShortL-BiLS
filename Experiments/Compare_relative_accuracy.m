clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_eg_cost = [];
ShortL_BiLS_se_cost = [];

FullL_BiLS_eg_cost = [];
FullL_BiLS_se_cost = [];

LSSofar_eg_cost = [];
LSSofar_se_cost = [];

ShortL_BFS_eg_cost = [];
ShortL_BFS_se_cost = [];

Gale_Shapley_eg_cost = [];
Gale_Shapley_se_cost = [];
k = 4;
for i = 50:50:600
    %---------------------------------------
    %ShortL-BiLS with k
    filename_eg = ['..\outputs\ShortL_BiLS_eg_',num2str(k),'_',num2str(i),'.mat'];    
    load(filename_eg);   
    ShortL_BiLS_eg_cost = [ShortL_BiLS_eg_cost,f_arr_cost];    
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_',num2str(k),'_',num2str(i),'.mat'];    
    load(filename_se);   
    ShortL_BiLS_se_cost = [ShortL_BiLS_se_cost,f_arr_cost];    
    %---------------------------------------
    %FullL-BiLS
    filename_eg = ['..\outputs\FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_cost = [FullL_BiLS_eg_cost,f_arr_cost];
    
    filename_se = ['..\outputs\FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_cost = [FullL_BiLS_se_cost,f_arr_cost];
    %---------------------------------------    
    %SLS
    filename_eg = ['..\outputs\LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_cost = [LSSofar_eg_cost,f_arr_cost];
    
    filename_se = ['..\outputs\LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);
    LSSofar_se_cost = [LSSofar_se_cost,f_arr_cost];
    %----------------------------------------        
    %ShortL-BFS
    filename_bfs = ['..\outputs\ShortL_BFS',num2str(i),'.mat'];    
    load(filename_bfs);    
    ShortL_BFS_eg_cost = [ShortL_BFS_eg_cost,f_arr_cost_eg]; 
    ShortL_BFS_se_cost = [ShortL_BFS_se_cost,f_arr_cost_se]; 
    %---------------------------------------   
    %Gale-Shapley solution
    filename_gs = ['..\outputs\Gale_Shapley',num2str(i),'.mat'];    
    load(filename_gs);
    M0_eg_cost = f_arr_cost_M0(1,:);
    M0_se_cost = f_arr_cost_M0(2,:);
    
    Mt_eg_cost = f_arr_cost_Mt(1,:);
    Mt_se_cost = f_arr_cost_Mt(2,:);
    
    Gale_Shapley_eg_cost = [Gale_Shapley_eg_cost,max(M0_eg_cost,Mt_eg_cost)];
    Gale_Shapley_se_cost = [Gale_Shapley_se_cost,max(M0_se_cost,Mt_se_cost)]; 
end
%relative accuracy
c = Gale_Shapley_eg_cost - ShortL_BFS_eg_cost;
c1 = Gale_Shapley_eg_cost - ShortL_BiLS_eg_cost;
c2 = Gale_Shapley_eg_cost - FullL_BiLS_eg_cost;
c3 = Gale_Shapley_eg_cost - LSSofar_eg_cost;
[max(c/c1),max(c/c2),max(c/c3)]

d = Gale_Shapley_se_cost - ShortL_BFS_se_cost;
d1 = Gale_Shapley_se_cost - ShortL_BiLS_se_cost;
d2 = Gale_Shapley_se_cost - FullL_BiLS_se_cost;
d3 = Gale_Shapley_se_cost - LSSofar_se_cost;
[max(d/d1),max(d/d2),max(d/d3)]

%figure;
%hold on;
%--------------------------------------------------
% for eglitarian
% c1 = ShortL_BiLS_eg_cost - ShortL_BFS_eg_cost;
% c2 = Gale_Shapley_eg_cost - ShortL_BFS_eg_cost; %ShortL_BiLS_eg_cost;
% 
% idx = find(c1~=0);
% h = bar([log10(c1(idx))',log10(c2(idx))'],0.5);
% hand = legend(h,'\Delta^{(1)}','\Delta^{(2)}',...
%                 'Location','northwest','Orientation','horizontal');
% xticks(1:2:size(idx,2));
%--------------------------------------------------
%for sex-equal stable matching
% d1 = ShortL_BiLS_se_cost - ShortL_BFS_se_cost;
% d2 = Gale_Shapley_se_cost - ShortL_BFS_se_cost;
% 
% idx = find(d1~=0);
% h = bar([log10(d1(idx))',log10(d2(idx))'],0.5);
% hand = legend(h,'\delta^{(1)}','\delta^{(2)}',...
%                 'Location','northwest','Orientation','horizontal');
% xticks(1:2:size(idx,2));
%-------------------------------------------------
%
% set(hand,'fontsize',13,'FontAngle','italic');  
% legend('boxoff')
% set(gcf,'color','w');
% %
% hx = xlabel('SM instances');
% set(hx, 'FontSize', 13)
% hxa = get(gca,'XTickLabel');
% set(gca,'XTickLabel',hxa,'fontsize',13)
% % 
% hy = ylabel('The distance to the exact solution (log10)');
% set(hy,'FontSize',13)
% grid on
% box on
% %=======================================
