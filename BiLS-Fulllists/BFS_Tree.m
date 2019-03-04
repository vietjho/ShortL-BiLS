function BFS_Tree()
%ref. McVitie and Wilson.The stable marriage problem,CACM,1971
clc;
clear all;
close all;
%define man preference list   
menList   = ReadFile('..\inputs\examples\men19viet.txt');
womenList = ReadFile('..\inputs\examples\women19viet.txt');
%man optimal and woman optimal solution
[M0] = GSManOptimal(menList,womenList);
[Mt] = GSWomanOptimal(womenList,menList);
%the best solution
M_best = M0;
fM_best = MatchingCost(menList,womenList,M_best);
%n is the size of SMP
n = size(menList,1);
%for generate the search tree
parentMen = 1:n;
parentLinks = [0,0,0];
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
            M_child = BreakMarriageMan(menList,womenList,M_parent,m,Mt);             
            if ~isempty(M_child)                       
                childSet(end+1,:) = M_child;                    
                childMen(end+1) = m;                
                stableMatchingSet(end+1,:) = M_child;                   
                %for display the search tree                
                parentIdx = find(ismember(stableMatchingSet,M_parent,'rows'));
                childIdx = find(ismember(stableMatchingSet,M_child,'rows'));
                parentLinks(end+1,:) = [parentIdx-1,m,childIdx-1];                                               
                %
                %find the best solution
                fM_child = MatchingCost(menList,womenList,M_child);
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
    fprintf('\n t = %d,size of neighbors = %d',t,size(childSet,1));
    t = t + 1;
end
fprintf('\n');
elapsedTime = toc;
fprintf('\n elapsed time = %f',elapsedTime);
matchingSize = size(stableMatchingSet,1);
%display the stable matchings
DisplayMatching(menList,womenList,M_best);
fprintf('\n size of all stable matching set = %d',matchingSize);
fprintf('\n Open file outputs\\example1.txt to see all stable matchings\n');
DisplayMatchingSet(menList,womenList,stableMatchingSet,parentLinks,'..\outputs\example1.txt');
end
%---------------------------------------------------------------