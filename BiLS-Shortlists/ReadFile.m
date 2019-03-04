function [A] = ReadFile(filename)
fin = fopen(filename,'r');
%read the number of people
n = fscanf(fin,'%d',1);
A = zeros(n,n);
for i = 1:n
    for j = 1:n            
        p =  fscanf(fin,'%d',1);
        A(i,j) = p;
    end   
end
fclose(fin);
%------------------------------------------------------
