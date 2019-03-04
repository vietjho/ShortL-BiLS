function [stableMatching] = BreakMarriageWoman(menShortlist,womenShortlist,M,m,M0)
n = size(menShortlist,1);
stableMatching = [];
%pre-processing for restarting of Gale-Shapley
womenMatching = zeros(1,n);
womenM0 = zeros(1,n);
%rank of men from women
for i = 1:n
  womenMatching(M(i)) = i;
  womenM0(M0(i)) = i;
end
%exchange the role of men and women
tempM = M;
M = womenMatching;
womenMatching = tempM;
%rankW(i) contains the position of the searching woman
rankW = ones(n,1);
for i = 1:n
    pos  = find(menShortlist(i,:) == M(i));
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
if (mr > n)
    break;
end
if (menShortlist(mi,mr) > 0)
    lastR = find(menShortlist(mi,:) == womenM0(mi)); 
    if (mr > lastR)
        break;
    end
    %wj in man mi's list and its patner
    wj = menShortlist(mi,mr);
    mj = womenMatching(wj);
    %rank of man mj in woman wj's list 
    mj_rank = find(womenShortlist(wj,:) == mj);
    %rank of current man mi in woman wj's list
    mi_rank = find(womenShortlist(wj,:) == mi);    
    %if woman wj prefer mi to mj, swap wj patner
    if (mi_rank < mj_rank)
        M(mi) = wj;
        womenMatching(wj) = mi;  
        if (wj ~= wi)
           M(mj) = 0;            
        end
    end
end
rankW(mi) = rankW(mi)+ 1;
end
if (found)
    stableMatching = womenMatching;
end
end
%---------------------------------------------------------------