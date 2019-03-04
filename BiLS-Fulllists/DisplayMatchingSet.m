function DisplayMatchingSet(menList,womenList,stableMatchingSet,parentLinks,filename)
fin = fopen(filename,'w');
%-----------for all stable matching-------
for i = 1: size(stableMatchingSet,1)
    if i-1 < 10
       fprintf(fin,'M0%d = ',i-1);
    else
       fprintf(fin,'M%d = ',i-1);
    end
     stableMatching = stableMatchingSet(i,:);
    [fm,sm,sw] = MatchingCost(menList,womenList,stableMatching);    
    for j = 1:size(stableMatching,2)
        wi = stableMatching(j);
        %fprintf(fin,'%3d',wi);
        fprintf(fin,'(%d,%d)',j,wi);
    end
    fprintf(fin,'&%5d&%5d&%5d&%5d\n',sm,sw,sm + sw,abs(sm-sw));
end
%-----------for the parent links-----------
fprintf(fin,'for link nodes\n');            
for i = 1: size(parentLinks,1)
    if parentLinks(i,1) < 10     
        fprintf(fin,'M0%d',parentLinks(i,1));            
    else
       fprintf(fin,'M%d',parentLinks(i,1));    
    end
    %
    fprintf(fin,'  & %5d    =>    ',parentLinks(i,2));        
    if parentLinks(i,3) < 10
        fprintf(fin,'M0%d\n',parentLinks(i,3));            
    else
       fprintf(fin,'M%d\n',parentLinks(i,3));    
    end            
end
fclose(fin);
end