function [stableMatching] = BreakMarriageMan(menList,womenList,M,m,Mt)
%ref. McVitie and Wilson.The stable marriage problem,CACM,1971
n = size(menList,1);
stableMatching = [];
%pre-processing for restarting of Gale-Shapley
womenMatching = zeros(1,n);
%rank of men from women
for i = 1:n
  womenMatching(M(i)) = i;
end
%rankW contains the position of the searching woman.
rankW = ones(n,1);
for i = 1:n
    pos = find(menList(i,:) == M(i));
    rankW(i) = rankW(i) + pos;
end
%break m
wi = M(m);
M(m) = 0;
%restart Gale-Shapley
found = false;
while (true)
%find a man mi who is free   
mi = find(M == 0);
%break man mi
if (mi < m)
    break;
end
%there is not any availble man then stop
if isempty(mi)    
   found = true;
   break;
end
%rank of woman wj in man mi's list
mr = rankW(mi);
%lastR = find(menList(mi,:) == Mt(mi)); 
if (mr > n) %used for woman-optimal (mr > lastR)
    break;
end
%wj in man mi's list and its patner
wj = menList(mi,mr);
mj = womenMatching(wj);
%rank of man mj in woman wj's list 
mj_rank = find(womenList(wj,:) == mj);
%rank of current man mi in woman wj's list
mi_rank = find(womenList(wj,:) == mi);    
%if woman wj prefer mi to mj, swap wj patner
if (mi_rank < mj_rank)
    M(mi) = wj;
    womenMatching(wj) = mi;  
    if (wj ~= wi)
       M(mj) = 0; 
    end
end        
rankW(mi) = rankW(mi) + 1;
end
if (found)
    stableMatching = M;
end
end
%---------------------------------------------------------------