function [M] = GSWomanOptimal(menList,womenList)
%Stable marriage problem with the Gale-Shapley algorithm
n = size(menList,1);
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
%choose a random man
r  = randi(size(freeMen,1),1,1);
mi = freeMen(r);
%find the next woman's rank from the history list for man mi
mr = rankW(mi);
%man m proposes woman w(i)
wi = menList(mi,mr);
%if woman womenMatching(wi) is free then it becomes engaged
if (womenMatching(wi) == 0)
    M(mi) = wi;
    womenMatching(wi) = mi;
    rankW(mi) = rankW(mi) + 1;    
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
    end
    rankW(mi) = rankW(mi) + 1;
end
end
M = womenMatching;
end
%---------------------------------------------------------------------