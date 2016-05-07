%%Generate and check direct kinematics

syms a2 a3 d1 q1 q2 q3
as = [0 a2 a3];
ds = [d1 0 0];
alphas = [pi 0 0];
thetas = [-pi/2+q1 q2 q3];

T = FK(as, ds, thetas, alphas);
J = generateJacobian(T);

x = zeros(1,101);
y = zeros(1,101);
z = zeros(1,101);

for i=1:101
    T_ = subs(T, {'q1' 'q2' 'q3' 'a2' 'a3' 'd1'},{(i-1)*(2*pi/100) 0 0 1 1 0.2});
    x(i) = T_(1,4);
    y(i) = T_(2,4);
    z(i) = T_(3,4);
end

plot3(x,y,z);
grid on;