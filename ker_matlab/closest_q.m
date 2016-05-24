function [ q ] = closest_q( q0, Q )
% Function returns the closest joint values due to the previous joint state
% Inputs:
%         q0 -> previous joint state (k-1)
%         Q  -> valid joint values (k)
% Output:
%         q  -> closest next joint state

n = size(Q,2);      % number of valid joint states

maks = 0;            % start with zero error
min = inf;          % search for the minimum among joint with max effort
index_i = 0;        % index for finding the closest valid joint state
index_j = 0;

for i = 1:3
    if ( max(abs(q0(i)-Q(i,:))) > maks)   % minimize the greatest error
        index_i = i; 
        maks = max(abs(q0(i)-Q(i,:)));
    end
end

for j = 1:n
    if ( abs(q0(index_i)-Q(index_i,j)) < min )
        min = abs(q0(index_i)-Q(index_i,j));
        index_j = j;
    end
end
q = Q(:,index_j);

end

