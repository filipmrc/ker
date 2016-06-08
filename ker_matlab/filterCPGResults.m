function [x,z] = filterCPGResults(X)
%FILTERCPGRESULTS Summary of this function goes here
%   Detailed explanation goes here

X_l = X(end-3000:end,:);
term = X_l(1,:);
cur = X_l(50,:);
i = 50;
while ((abs(cur(1,1)-term(1,1))> 10e-3) || ((abs(cur(1,2)-term(1,2)))> 10e-3)) 
    cur = X_l(i,:); i = i +1;
end
    
x = -X_l(1:25:(i-1),1);
z = X_l(1:25:(i-1),2);
end



