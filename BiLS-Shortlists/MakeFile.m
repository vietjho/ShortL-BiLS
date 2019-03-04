function MakeFile()
clc;
clear all;
close all;
for i = 50:50:600
    for j = i:i+19
        fprintf('\ni = %d',i);
        filename = ['..\inputs\I',num2str(j),'.mat'];
        %create data file
        x = randi(i,i,i);
        [x,menList] = sort(x,2);
        y = randi(i,i,i);
        [y,womenList] = sort(y,2);     
        %comments if not want to overwite
        save(filename,'menList','womenList');
    end
end
end
%*******************************************************************