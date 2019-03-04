function ShortL_BiLS()
clc;
clear all;
close all;
%define man preference list   
menList   = ReadFile('..\inputs\examples\men19viet.txt');
womenList = ReadFile('..\inputs\examples\women19viet.txt');
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
%% initialize the solution
M_left = M0;
fM_left = MatchingCost(menShortlist,womenShortlist,M_left);
M_right = Mt;
fM_right = MatchingCost(menShortlist,womenShortlist,M_right);
if (fM_left < fM_right)
    M_best = M_left;
    fM_best = fM_left;
else
    M_best = M_right;
    fM_best = fM_right;  
end
%initialize the propability
p = 0.05;
tic;
forward  = true;
backward = true;
neighborLeft = M0;
neighborRight = Mt;
k = 1;
t = 1;
while (true)   
    %-------------------search forward---------------------
    if (forward)        
        neighborSet = []; 
        for h = 1:size(neighborLeft,1)
            M_temp = neighborLeft(h,:);
            for m = 1:n
                M_child = BreakMarriageMan(menShortlist,womenShortlist,M_temp,m,Mt);
                if ~isempty(M_child)           
                    neighborSet(end+1,:) = M_child;            
                end
            end    
        end
        if (~isempty(neighborSet))
            %find the best neighbor matchings
            neighborCost = [];
            for i = 1:size(neighborSet,1)
                M_child = neighborSet(i,:);
                fM_child = MatchingCost(menShortlist,womenShortlist,M_child);
                neighborCost(end+1) = fM_child;
            end
            if (rand() <= p)
                j = randi([1,size(neighborSet,1)]);
                index_arr = j;
            else
                [~,index_arr] = sort(neighborCost);
                j = index_arr(1);
            end        
            M_next = neighborSet(j,:);
            [fM_next,sm1] = MatchingCost(menShortlist,womenShortlist,M_next);
            fM_left = MatchingCost(menShortlist,womenShortlist,M_left);
            if (fM_next >= fM_left)   
                forward = false;
                %remember the best solution
                if (fM_best > fM_left)
                    M_best = M_left;
                    fM_best = fM_left;
                end            
            end
            %for next iteration
            M_left = M_next;
            if (size(index_arr,2) == 1)
                neighborLeft = neighborSet(index_arr(1),:);
            else
                if k > size(neighborSet,1)
                    neighborLeft = neighborSet;
                else
                    neighborLeft = neighborSet(index_arr(1:k),:);
                end
            end
        else
            forward = false;
        end
    end
    %-------------------search backward---------------------
    if (backward)
        neighborSet = [];  
        for h = 1:size(neighborRight,1)
            M_temp = neighborRight(h,:);
            for m = 1:n
                M_child = BreakMarriageWoman(womenShortlist,menShortlist,M_temp,m,M0); 
                if ~isempty(M_child)           
                    neighborSet(end+1,:) = M_child;            
                end
            end
        end
        if (~isempty(neighborSet))
            %find the best neighbor matchings
            neighborCost = [];
            for i = 1:size(neighborSet,1)
                M_child = neighborSet(i,:);
                fM_child = MatchingCost(menShortlist,womenShortlist,M_child);
                neighborCost(end+1) = fM_child;
            end
            if (rand() <= p)
                j = randi([1,size(neighborSet,1)]);
                index_arr = j;
            else
                [~,index_arr] = sort(neighborCost);
                j = index_arr(1);
            end
            M_next = neighborSet(j,:);
            [fM_next,sm2] = MatchingCost(menShortlist,womenShortlist,M_next);
            fM_right = MatchingCost(menShortlist,womenShortlist,M_right);
            if (fM_next >= fM_right)
                backward = false;
                %remember the best solution
                if (fM_best > fM_right)
                    M_best = M_right;
                    fM_best = fM_right;
                end            
            end
            %for next iteration
            M_right = M_next;
            if (size(index_arr,2) == 1)
                neighborRight = neighborSet(index_arr(1),:);
            else
                if k > size(neighborSet,1)
                    neighborRight = neighborSet;
                else
                    neighborRight = neighborSet(index_arr(1:k),:);
                end
            end
        else
            backward = false;
        end
    end    
    %
    if ((~forward)&&(~backward))
        if (sm1 <= sm2)
            forward = true;
            backward = true;        
        else
            break;
        end
    end
    %fprintf('\n t = %d',t);
    t = t + 1;
end
toc
%print solution
fprintf('\n the optimal solution:\n');
DisplayMatching(menShortlist,womenShortlist,M_best);
end
