function LS_BestSoFar_Test()
clc;
clear all;
close all;
for i = 50:50:600
    arr_time = [];
    f_arr_cost = [];
    for j = i:i+19
        filename = ['..\inputs\I',num2str(j),'.mat'];
        %define man preference list
        load(filename,'menList','womenList');    
        [f_time,f_cost] = LocalSearchBestSoFar(menList,womenList);
        arr_time(end+1) = f_time;  
        f_arr_cost(end+1) = f_cost;
    end
    f_arr_time = mean(arr_time);
    fprintf('\ni = %d, mean of time = %f',i,f_arr_time);   
    %save to file
    filename_out = ['..\outputs\LSBestSoFar_se',num2str(i),'.mat'];
    save(filename_out,'f_arr_time','f_arr_cost');
end
end
%==========================================================================
function [f_time,f_cost] = LocalSearchBestSoFar(menList,womenList)
%man optimal and woman optimal solution
[M0] = GSManOptimal(menList,womenList);
[Mt] = GSWomanOptimal(womenList,menList);
%the size of SMP
n = size(menList,1);
%propability
p = 0.05;
%
M = M0;
M_best = M;
fM_best = MatchingCost(menList,womenList,M_best);
tic;
t = 1;
while (true)   
    neighborSet = [];
    %find the stable neighbor matchings
    for m = 1:n
        M_child = BreakMarriageMan(menList,womenList,M,m,Mt);                
        if ~isempty(M_child)           
            neighborSet(end+1,:) = M_child;            
        end
    end
    if (isempty(neighborSet))
        break;
    end
    %find the best neighbor matchings
    neighborCost = [];
    for i = 1:size(neighborSet,1)
        M_child = neighborSet(i,:);
        fM_child = MatchingCost(menList,womenList,M_child);
        neighborCost(end+1) = fM_child;
    end
    if (rand() <= p)
        j = randi([1,size(neighborSet,1)]);
    else
        [val,j]  = min(neighborCost);
    end
    M_next = neighborSet(j,:);
    fM_next = MatchingCost(menList,womenList,M_next);
    if (fM_next < fM_best)
        M_best = M_next;
        fM_best = fM_next;
    end
    %for next iteration
    M = M_next;
    %fprintf('\n t = %d,size of neighbors = %d',t,size(neighborSet,1));
    t = t + 1;
end
f_time = toc;
%print solution
[fm,sm,sw] = MatchingCost(menList,womenList,M_best);
f_cost = fm;
end
%---------------------------------------------------------------
