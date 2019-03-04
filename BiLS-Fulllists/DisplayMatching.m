function DisplayMatching(menList,womenList,stableMatching)
fprintf('\n');
for i = 1:size(stableMatching,2)
    fprintf('%4d',stableMatching(i));
end
%fprintf('\n');
[fm,sm,sw] = MatchingCost(menList,womenList,stableMatching);
fprintf('\n (sm = %d, sw = %d, sm + sw = %d,|sm - sw| = %d)\n',sm, sw, sm + sw, abs(sm - sw));
end
