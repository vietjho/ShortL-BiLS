function ShortL_BFS_Graph()
%ref. McVitie and Wilson.The stable marriage problem,CACM,1971
%but reject the rule R2
%clc;
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
%the best solution
M_best = M0;
fM_best = MatchingCost(menShortlist,womenShortlist,M_best);
%n is the size of SMP
n = size(menShortlist,1);
%generate the search tree
parentLinks = [0,0,0];
%generate all stable matchings
parentSet = M0;
stableMatchingSet = parentSet;
tic;
t = 1;
while (true)   
    %find the stable neighbor matchings
    childSet = [];
    for i = 1:size(parentSet,1)
        M_parent = parentSet(i,:);
        for m = 1:n
            M_child = BreakMarriageMan(menShortlist,womenShortlist,M_parent,m,Mt);
            if ~isempty(M_child)                   
                childIdx = find(ismember(childSet,M_child,'rows'));                
                if isempty(childIdx)                
                    childSet(end+1,:) = M_child;    
                    childIdx = find(ismember(stableMatchingSet,M_child,'rows'));
                    if isempty(childIdx)
                        stableMatchingSet(end+1,:) = M_child;                        
                    end
                end                
                %for display the graph search
                parentIdx = find(ismember(stableMatchingSet, M_parent, 'rows'));
                childIdx = find(ismember(stableMatchingSet, M_child, 'rows'));
                %
                rowLink = [parentIdx-1,m,childIdx-1];
                rowIdx = find(ismember(parentLinks,rowLink,'rows'));
                if isempty(rowIdx)
                    parentLinks(end+1,:) = rowLink;
                end
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
    fprintf('\n t = %d,size of neighbors = %d',t,size(childSet,1));
    t = t + 1;
end
fprintf('\n');
elapsedTime = toc;
fprintf('\n elapsed time = %f',elapsedTime);
matchingSize = size(stableMatchingSet,1);
%display the stable matchings
DisplayMatching(menShortlist,womenShortlist,M_best);
fprintf('\n size of all stable matching set = %d',matchingSize);
fprintf('\n Open file outputs\\examples\\example2.txt to see all stable matchings\n');
DisplayMatchingSet(menShortlist,womenShortlist,stableMatchingSet,parentLinks,'..\outputs\examples\example2.txt');
end
%---------------------------------------------------------------