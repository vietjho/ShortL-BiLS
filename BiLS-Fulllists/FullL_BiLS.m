function FullL_BiLS()
clc;
clear all;
close all;
%define man preference list   
menList   = ReadFile('..\inputs\examples\men19viet.txt');
womenList = ReadFile('..\inputs\examples\women19viet.txt');
%man optimal and woman optimal solution
[M0] = GSManOptimal(menList,womenList);
[Mt] = GSWomanOptimal(womenList,menList);
%the size of SMP
n = size(menList,1);
%% initialize the solution
M_left = M0;
fM_left = MatchingCost(menList,womenList,M_left);
M_right = Mt;
fM_right = MatchingCost(menList,womenList,M_right);
if (fM_left < fM_right)
    M_best = M_left;
    fM_best = fM_left;
    index  = 1;
else
    M_best = M_right;
    fM_best = fM_right;
    index  = 2;
end
%initialize the propability
p = 0.05;
tic;
forward  = true;
backward = true;
iter_left = 1;
iter_right = 1;
t = 1;
while (true)   
    %-------------------search forward---------------------
    if (forward)        
        neighborSet = [];  
        for m = 1:n
            M_child = BreakMarriageMan(menList,womenList,M_left,m,Mt);
            if ~isempty(M_child)           
                neighborSet(end+1,:) = M_child;            
            end
        end    
        if (~isempty(neighborSet))
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
            [fM_next,sm1] = MatchingCost(menList,womenList,M_next);
            fM_left = MatchingCost(menList,womenList,M_left);
            if (fM_next >= fM_left)
                forward = false;
                %remember the best solution
                if (fM_best > fM_left)
                    M_best = M_left;
                    fM_best = fM_left;
                    index  = 1;
                end            
            end
            %for next iteration
            M_left = M_next;
        else
            forward = false;
        end
        iter_left = iter_left + 1;
    end
    %-------------------search backward---------------------
    if (backward)
        neighborSet = [];  
        for m = 1:n
            M_child = BreakMarriageWoman(womenList,menList,M_right,m,M0); 
            if ~isempty(M_child)           
                neighborSet(end+1,:) = M_child;            
            end
        end
        if (~isempty(neighborSet))
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
            [fM_next,sm2] = MatchingCost(menList,womenList,M_next);
            fM_right = MatchingCost(menList,womenList,M_right);
            if (fM_next >= fM_right)
                backward = false;
                %remember the best solution
                if (fM_best > fM_right)
                    M_best = M_right;
                    fM_best = fM_right;
                    index  = 2;
                end            
            end
            %for next iteration
            M_right = M_next;
        else
            backward = false;
        end
         iter_right = iter_right + 1;
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
    fprintf('\n t = %d',t);
    t = t + 1;
end
toc
fprintf('\n the algorithm stops when sm1 = %d sm2 = %d:',sm1,sm2);
fprintf('\n the iteration for forward optimal solution = %d:',iter_left);
fprintf('\n the iteration for backward optimal solution = %d:',iter_right);
%print solution
fprintf('\n the optimal solution (index = %d):\n',index);
fprintf('\n the optimal solution:\n');
DisplayMatching(menList,womenList,M_best);
end
