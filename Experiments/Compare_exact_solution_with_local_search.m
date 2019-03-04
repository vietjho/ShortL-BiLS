clc;
clear all;
close all;
%
ShL_BiLS_eg_1_cost = [];
ShL_BiLS_se_1_cost = [];

ShL_BiLS_eg_2_cost = [];
ShL_BiLS_se_2_cost = [];

ShL_BiLS_eg_3_cost = [];
ShL_BiLS_se_3_cost = [];

ShL_BiLS_eg_4_cost = [];
ShL_BiLS_se_4_cost = [];

ShL_BiLS_eg_5_cost = [];
ShL_BiLS_se_5_cost = [];

FuL_BiLS_eg_cost = [];
FuL_BiLS_se_cost = [];

LSS_eg_cost = [];
LSS_se_cost = [];
%
for i = 50:50:600
    %---------------------------------------
    %ShortL-BiLS - k =1
    filename_eg = ['..\outputs\ShortL_BiLS_eg_1_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_1_cost = f_arr_cost;
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_1_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_1_cost = f_arr_cost;
    %----------------------------------------    
    %ShortL-BiLS - k =2
    filename_eg = ['..\outputs\ShortL_BiLS_eg_2_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_2_cost = f_arr_cost;
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_2_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_2_cost = f_arr_cost;
    %---------------------------------------    
    %ShortL-BiLS - k =3
    filename_eg = ['..\outputs\ShortL_BiLS_eg_3_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_3_cost = f_arr_cost;
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_3_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_3_cost = f_arr_cost;
    %---------------------------------------
    %ShortL-BiLS - k =4
    filename_eg = ['..\outputs\ShortL_BiLS_eg_4_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_4_cost = f_arr_cost;  
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_4_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_4_cost = f_arr_cost; 
    %---------------------------------------
    %ShortL-BiLS - k =5
    filename_eg = ['..\outputs\ShortL_BiLS_eg_5_',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_5_cost = f_arr_cost;  
    %
    filename_se = ['..\outputs\ShortL_BiLS_se_5_',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_5_cost = f_arr_cost; 
    %---------------------------------------
    %FullL-BiLS
    filename_eg = ['..\outputs\FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_cost = f_arr_cost;
    %
    filename_se = ['..\outputs\FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_cost = f_arr_cost;
    %----------------------------------------   
    %SLS
    filename_eg = ['..\outputs\LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_cost = f_arr_cost;
    %
    filename_se = ['..\outputs\LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);
    LSSofar_se_cost = f_arr_cost;
    %----------------------------------------
    %ShortL-BFS
    filename_bfs = ['..\outputs\ShortL_BFS',num2str(i),'.mat'];    
    load(filename_bfs);    
    ShortL_BFS_eg_cost = f_arr_cost_eg;
    ShortL_BFS_se_cost = f_arr_cost_se;  
    
    eg1 = 0; eg2 = 0; eg3 = 0; eg4 = 0; eg5 = 0; eg6 = 0; eg7 = 0;
    se1 = 0; se2 = 0; se3 = 0; se4 = 0; se5 = 0; se6 = 0; se7 = 0;
    
    for j = 1:20
        %ShortL-BiLS - k = 1
        if ShortL_BiLS_eg_1_cost(j) == ShortL_BFS_eg_cost(j)
            eg1 = eg1 + 1;
        end
        if ShortL_BiLS_se_1_cost(j) == ShortL_BFS_se_cost(j)
            se1 = se1 + 1;
        end        
        %ShortL-BiLS - k = 2
        if ShortL_BiLS_eg_2_cost(j) == ShortL_BFS_eg_cost(j)
            eg2 = eg2 + 1;
        end
        if ShortL_BiLS_se_2_cost(j) == ShortL_BFS_se_cost(j)
            se2 = se2 + 1;
        end
        %ShortL-BiLS - k = 3
        if ShortL_BiLS_eg_3_cost(j) == ShortL_BFS_eg_cost(j)
            eg3 = eg3 + 1;
        end
        if ShortL_BiLS_se_3_cost(j) == ShortL_BFS_se_cost(j)
            se3 = se3 + 1;
        end
        %ShortL-BiLS - k = 4
        if ShortL_BiLS_eg_4_cost(j) == ShortL_BFS_eg_cost(j)
            eg4 = eg4 + 1;
        end     
        if ShortL_BiLS_se_4_cost(j) == ShortL_BFS_se_cost(j)
            se4 = se4 + 1;
        end
        %ShortL-BiLS - k = 5
        if ShortL_BiLS_eg_5_cost(j) == ShortL_BFS_eg_cost(j)
            eg5 = eg5 + 1;
        end     
        if ShortL_BiLS_se_5_cost(j) == ShortL_BFS_se_cost(j)
            se5 = se5 + 1;
        end
        %----------------------------
        if FullL_BiLS_eg_cost(j) == ShortL_BFS_eg_cost(j)
            eg6 = eg6 + 1;
        end
        if FullL_BiLS_se_cost(j) == ShortL_BFS_se_cost(j)
            se6 = se6 + 1;
        end
        %---------------------------
        if LSSofar_eg_cost(j) == ShortL_BFS_eg_cost(j)
            eg7 = eg7 + 1;
        end
        if LSSofar_se_cost(j) == ShortL_BFS_se_cost(j)
            se7 = se7 + 1;
        end        
    end 
    ShL_BiLS_eg_1_cost(end+1) = eg1;    
    ShL_BiLS_se_1_cost(end+1) = se1;    
    
    ShL_BiLS_eg_2_cost(end+1) = eg2;    
    ShL_BiLS_se_2_cost(end+1) = se2;    
    
    ShL_BiLS_eg_3_cost(end+1) = eg3;    
    ShL_BiLS_se_3_cost(end+1) = se3;
    
    ShL_BiLS_eg_4_cost(end+1) = eg4;    
    ShL_BiLS_se_4_cost(end+1) = se4; 
    
    ShL_BiLS_eg_5_cost(end+1) = eg5;    
    ShL_BiLS_se_5_cost(end+1) = se5; 
    
    FuL_BiLS_eg_cost(end+1) = eg6;
    FuL_BiLS_se_cost(end+1) = se6;

    LSS_eg_cost(end+1) = eg7;
    LSS_se_cost(end+1) = se7;

end
ShL_BiLS_eg_1_cost = ShL_BiLS_eg_1_cost*100/20;
ShL_BiLS_se_1_cost = ShL_BiLS_se_1_cost*100/20;    

ShL_BiLS_eg_2_cost = ShL_BiLS_eg_2_cost*100/20;    
ShL_BiLS_se_2_cost = ShL_BiLS_se_2_cost*100/20;    

ShL_BiLS_eg_3_cost = ShL_BiLS_eg_3_cost*100/20;    
ShL_BiLS_se_3_cost = ShL_BiLS_se_3_cost*100/20;

ShL_BiLS_eg_4_cost = ShL_BiLS_eg_4_cost*100/20;    
ShL_BiLS_se_4_cost = ShL_BiLS_se_4_cost*100/20; 

ShL_BiLS_eg_5_cost = ShL_BiLS_eg_5_cost*100/20;    
ShL_BiLS_se_5_cost = ShL_BiLS_se_5_cost*100/20;

FuL_BiLS_eg_cost = FuL_BiLS_eg_cost*100/20;
FuL_BiLS_se_cost = FuL_BiLS_se_cost*100/20;

LSS_eg_cost = LSS_eg_cost*100/20;
LSS_se_cost = LSS_se_cost*100/20;

%Percentage of egalitarion 
[ShL_BiLS_eg_1_cost', ShL_BiLS_eg_2_cost', ShL_BiLS_eg_3_cost', ...
 ShL_BiLS_eg_4_cost', FuL_BiLS_eg_cost',LSS_eg_cost']

sum([ShL_BiLS_eg_1_cost', ShL_BiLS_eg_2_cost', ShL_BiLS_eg_3_cost', ...
ShL_BiLS_eg_4_cost', FuL_BiLS_eg_cost',LSS_eg_cost'])/12


%Percentage of sex-equality cost
[ShL_BiLS_se_1_cost',ShL_BiLS_se_2_cost',ShL_BiLS_se_3_cost',...
 ShL_BiLS_se_4_cost', FuL_BiLS_se_cost',LSS_se_cost']

sum([ShL_BiLS_se_1_cost',ShL_BiLS_se_2_cost',ShL_BiLS_se_3_cost',...
 ShL_BiLS_se_4_cost', FuL_BiLS_se_cost',LSS_se_cost'])/12

