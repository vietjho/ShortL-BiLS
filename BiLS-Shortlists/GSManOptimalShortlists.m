function [menShortlist,womenShortlist,M] = GSManOptimalShortlists(menList,womenList)
%Stable marriage problem with the Gale-Shapley algorithm
n = size(menList,1);
menShortlist = menList;
womenShortlist = womenList;
%M(i) contains the most preferable wonman
M = zeros(1,n);
womenMatching = zeros(1,n);
%rankW(i) contains the position of the searching woman.
rankW = ones(n,1); 
%
%Gale-Shapley algorithm
while (true)
%find a man mi who is free   
freeMen = find(M == 0);
%there is not any availble man then stop
if isempty(freeMen)
   break;
end
%choose the first free man
mi = freeMen(1);
%find the next woman's rank from m's preference list
mr = rankW(mi);
%man m proposes woman w(i)
wi = menList(mi,mr);
%if woman womenMatching(wi) is free then it becomes engaged
if (womenMatching(wi) == 0)
    M(mi) = wi;
    womenMatching(wi) = mi;
    rankW(mi) = rankW(mi) + 1;
    %remove men mj following mi from wj's list and also wi from wj
    wr = find(womenList(wi,:) == mi);
    for mj = wr+1 : n
        womenShortlist(wi,mj) = 0;
        wj = find(menList(womenList(wi,mj),:) == wi);
        menShortlist(womenList(wi,mj),wj) = 0;
    end    
else
    %if womenMatching(i) is currently engaged to mj = womenMatching(wi)    
    mj = womenMatching(wi);
    mj_rank = find(womenList(wi,:) == mj);
    mi_rank = find(womenList(wi,:) == mi);              
    %compare the ranks of mi and mj
    if (mi_rank < mj_rank)
        M(mj) = 0;           
        M(mi) = wi;
        womenMatching(wi) = mi;  
        %remove men mj following mi from wj's list and also wi from wj
        for mj = mi_rank+1 : n
            womenShortlist(wi,mj) = 0;
            wj = find(menList(womenList(wi,mj),:) == wi);
            menShortlist(womenList(wi,mj),wj) = 0;
        end
    end
    rankW(mi) = rankW(mi) + 1;
end
end
end
%---------------------------------------------------------------------