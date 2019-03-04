function BruteForceDemo()
%Brute-Force Algorithm for stable marriage problem
clc;
clear all;
close all;
menList   = ReadFile('example\men8irving.txt');
womenList = ReadFile('example\women8irving.txt');
n = size(menList,1);
%generate matching list
men    = 1:n;
women  = 1:n;
matchings = perms(women);
%find sm, sw,eg, sf (stable man,stable woman,egalitarian, sex fair)
stableMatchings = [];
sm = [];
sw = [];
eg = [];
sf = [];
tic;
for i = 1:size(matchings,1)
    matching = matchings(i,:);
    if (stable_matching(menList,womenList,matching) == true)
        stableMatchings(end+1,:) = matching;
        [sm1,sw1] = matching_cost(menList,womenList,matching);
        sm(end+1,1) = sm1;
        sw(end+1,1) = sw1;
        eg(end+1,1) = sm1 + sw1;
        sf(end+1,1) = abs(sm1-sw1);
    end
end
toc
%sort by men cost
[val,k] = sort(sm);
sm = sm(k);
sw = sw(k);
eg = eg(k);
sf = sf(k);
stableMatchings = stableMatchings(k,:);
%write to file
fin = fopen('test.txt','w');
for i = 1: size(stableMatchings,1)
    if i-1 < 10
       fprintf(fin,'M0%d = ',i-1);
    else
       fprintf(fin,'M%d = ',i-1);
    end     
    matching = stableMatchings(i,:);   
    for j = 1:size(matching,2)
        wi = matching(j);
        fprintf(fin,'%3d',wi);
    end
    fprintf(fin,'%5d%5d%5d%5d\n',sm(i),sw(i),eg(i),sf(i));
end
fclose(fin);
[v_man,man_optimal] = min(sm); 
[v_wom,wom_optimal] = min(sw);
[v_ega,ega_optimal] = min(eg);
[v_sex,sex_optimal] = min(sf);

fprintf('\n man optimal index     : %d',man_optimal);
fprintf('\n woman optimal index   : %d',wom_optimal);
fprintf('\n ega_optimal index     : %d',ega_optimal);
fprintf('\n sex-fair optimal index: %d',sex_optimal);
fprintf('\n');
end
%--------------------------------------------------
function [rk] = rank(matrixRank,p1,p2)
%rank p2 in preference list PL of p1
rk = find(matrixRank(p1,:) == p2);
end
%--------------------------------------------------
function [f] = stable_matching(menList,womenList,matching)
n = size(matching,2);
m = matching;
w = zeros(1,n);
%rank of men from women
for i = 1:n
  w(m(i)) = i;
end
%ref. to the SMP Structures and Algorithms-lecture21
f = true;
for i = 1:n
    mi = i;
    wi = m(mi);
    wr = find(menList(mi,:) == wi);
    wlist = menList(mi,1:wr-1);    
    for j = 1:size(wlist,2)
        wj = wlist(j);
        mj = w(wj);
        %check a blocking pairs        
        if rank(womenList,wj,mi) < rank(womenList,wj,mj)
          f = false;
          break;
        end
    end
    if (f == false)
        break;
    end
end 
end
%-------------------------------------------------
function [sm,sw] = matching_cost(menList,womenList,matching)
n = size(matching,2);
sm = 0;
sw = 0;
for i = 1:n 
    mi = i;
    wi = matching(i);    
    mr = find(menList(mi,:) == wi);
    wr = find(womenList(wi,:) == mi);
    sm = sm + mr;
    sw = sw + wr;    
end 
end
%-------------------------------------------------