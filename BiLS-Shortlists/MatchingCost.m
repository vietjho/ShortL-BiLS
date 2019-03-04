function [fm,sm,sw] = MatchingCost(menShortlist,womenShortlist,M)
n = size(M,2);
sm = 0;
sw = 0;
for i = 1 : n 
    mi = i;
    wi = M(i);
    mr = find(menShortlist(mi,:) == wi);
    wr = find(womenShortlist(wi,:) == mi);
    sm = sm + mr;
    sw = sw + wr;    
end
%egalitarian cost
%fm = sm+sw;
%sex-equal cost
fm = abs(sm-sw);
end
%-------------------------------------------------