function [ q ] = interpolate( Q )
% q = interpolate(Q) Polinomska interpolacija u prostoru zglobova.
% Svaki od tri stupca ulaznog vektora Q predstavlja vektor varijabli zglobova
% kroz koji manipulator mora proci. Izlazni vektor q predstavlja vektor zglobova
% interpoliran s 10 jednako razmaknutih tocaka (linspace) za svaki polinom

%Ti = @(i) max(abs(q(:,i+1)-q(:,i)))/0.1;

T = max(abs(Q(:,3)-Q(:,1)));

q_velocity = [0,0,0]';
A = path_planning(Q(:,1),Q(:,2),Q(:,3),q_velocity,q_velocity,T)

q = zeros(3,10);
for i = 1:3
    q(i,:) = [polyval(A(:,i),linspace(0,T,10))];
end

end

