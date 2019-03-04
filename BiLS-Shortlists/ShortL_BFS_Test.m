function ShortL_BFS_Test()
clc;
clear all;
close all;
for i = 550:50:600
    arr_time = [];
    arr_size = [];
    f_arr_cost_eg = [];
    f_arr_cost_se = [];
    for j = i:i+19
        filename = ['..\inputs\I',num2str(j),'.mat'];
        %define man preference list
        load(filename,'menList','womenList');
        [f_time,f_cost_eg,f_cost_se,f_size] = ShortL_BFS_Tree(menList,womenList);
        arr_time(end+1) = f_time;  
        arr_size(end+1) = f_size;
        f_arr_cost_eg(end+1) = f_cost_eg;
        f_arr_cost_se(end+1) = f_cost_se;
    end
    f_arr_time = mean(arr_time);
    f_arr_size = mean(arr_size);
    fprintf('\ni = %d, time = %f,size = %f',i,f_arr_time,f_arr_size);   
    %save to file
    filename_out = ['..\outputs\ShortL_BFS',num2str(i),'.mat'];
    save(filename_out,'f_arr_time','f_arr_cost_eg','f_arr_cost_se','f_arr_size');               
end
end
%========================================================
function [f_time,f_cost_eg,f_cost_se,f_size] = ShortL_BFS_Tree(menList,womenList)
%ref. McVitie and Wilson.The stable marriage problem,CACM
%man optimal and woman optimal solution
[menShortlist0,womenShortlist0,M0] = GSManOptimalShortlists(menList,womenList);
[womenShortlist_t,menShortlist_t,Mt] = GSWomanOptimalShortlists(womenList,menList);
%merge shortlists to obtain the better shortlists
%the size of SMP
n = size(menShortlist0,1);
menShortlist = zeros(n,n);
womenShortlist = zeros(n,n);
for i = 1:n
    for j = 1:n
        if (menShortlist0(i,j) == menShortlist_t(i,j))
            menShortlist(i,j) = menShortlist0(i,j);
        end
        if (womenShortlist0(i,j) == womenShortlist_t(i,j))
            womenShortlist(i,j) = womenShortlist0(i,j);
        end
    end
end
%the best solution
M_best = M0;
fM_best = MatchingCost(menShortlist,womenShortlist,M_best);
%for generate the search tree
parentMen = 1:n;
%generate all stable matchings
parentSet = M0;
stableMatchingSet = parentSet;
tic;
t = 1;
while (true)   
    %find the stable neighbor matchings
    childSet = [];
    childMen = [];
    for i = 1:size(parentSet,1)
        M_parent = parentSet(i,:);
        startMan = parentMen(i);
        for m = startMan:n
            M_child = BreakMarriageMan(menShortlist,womenShortlist,M_parent,m,Mt);             
            if ~isempty(M_child)                       
                childSet(end+1,:) = M_child;                    
                childMen(end+1) = m;                
                stableMatchingSet(end+1,:) = M_child;                   
                %for display the search tree                
                parentIdx = find(ismember(stableMatchingSet,M_parent,'rows'));
                childIdx = find(ismember(stableMatchingSet,M_child,'rows'));                                              
                %
                %find the best solution
                fM_child = MatchingCost(menShortlist,womenShortlist,M_child);
                if (fM_best > fM_child)
                    M_best = M_child;
                    fM_best = fM_child;
                end                 
            end
        end
    end
    if (isempty(childSet))
        break;
    end    
    %for next level
    parentSet = childSet;
    parentMen = childMen;
    %fprintf('\n t = %d,size of neighbors = %d',t,size(childSet,1));
    t = t + 1;
end
f_time = toc;
%-------------------------------------------------------------
%find f_cost_eg and f_size
[fm,sm,sw] = MatchingCost(menShortlist,womenShortlist,M_best);
f_cost_eg = fm;
f_size = size(stableMatchingSet,1);
%-------------------------------------------------------------
%find f_cost_se
M = stableMatchingSet(1,:);
[fm,sm,sw] = MatchingCost(menShortlist,womenShortlist,M);
f_cost_se = abs(sm-sw);
for i = 2:f_size
    M = stableMatchingSet(i,:);
    [fm,sm,sw] = MatchingCost(menShortlist,womenShortlist,M);
    if f_cost_se > abs(sm-sw)
        f_cost_se = abs(sm-sw);
    end
end
end
%---------------------------------------------------------------