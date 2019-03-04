function Gale_Shapley_Test()
clc;
clear all;
close all;
for i = 50:50:600
    f_arr_cost_M0 = [];
    f_arr_cost_Mt = [];
    for j = i:i+19
        filename = ['..\inputs\I',num2str(j),'.mat'];
        %define man preference list
        load(filename,'menList','womenList');
        [f_cost_M0,f_cost_Mt] = Gale_Shapley(menList,womenList);
        f_arr_cost_M0(:,end+1) = f_cost_M0; %[eg,se]'
        f_arr_cost_Mt(:,end+1) = f_cost_Mt; %[eg,se]'
    end
    fprintf('\ni = %d',i);   
    %save to file
    filename_out = ['..\outputs\Gale_Shapley',num2str(i),'.mat'];
    save(filename_out,'f_arr_cost_M0','f_arr_cost_Mt');
end
end
%============================================================
function [f_cost_M0,f_cost_Mt] = Gale_Shapley(menList,womenList)
%man optimal and woman optimal solution
[menShortlist0,womenShortlist0,M0] = GSManOptimalShortlists(menList,womenList);
[womenShortlist_t,menShortlist_t,Mt] = GSWomanOptimalShortlists(womenList,menList);

[fm,sm,sw] = MatchingCost(menList,womenList,M0);
f_cost_M0 = [sm+sw,abs(sm-sw)]';
[fm,sm,sw] = MatchingCost(menList,womenList,Mt);
f_cost_Mt = [sm+sw,abs(sm-sw)]';
end
