%%Generate and check direct kinematics

syms ab ah a1 a2 a3 dh d1 d4 q1 q2 q3
as = [a1 a2 0 0];
ds = [0 0 0 d4];
alphas = [-pi/2 0 pi/2 0];
thetas = [q1 q2 pi/2+q3 0];

T = simplify(FK(as, ds, thetas, alphas));
J = simplify(generateJacobian(T));

Tf = matlabFunction(T);
e_max = 0;
for i = 1:50
    for j = 1:50
        for k = 1:50
            T_ = Tf(0.7, 7, 6, (i/50)*pi/3-pi/6 , (j/50)*pi-pi/2, (k/50)*pi-pi/2);
            qs = IK_mex(double([T_(1,4) T_(2,4) T_(3,4)]));
            e_min = [100 100 100];
            for u = 1:16
                tmp = Tf( 0.7, 7, 6, qs(1,u), qs(2,u), qs(3,u));               
                e_min = min(e_min,abs([T_(1,4) T_(2,4) T_(3,4)] - tmp(1:3,4)'));
            end
            if e_min>[0.1 0.1 0.1]
                disp([j k]);
            end
            e_max = max(e_max,e_min);
        end
    end
end

% plot3(x,y,z);
% grid on;