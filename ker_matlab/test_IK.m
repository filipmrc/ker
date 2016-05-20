e_max = 0;
Tf_leg = matlabFunction(T_leg_foot1);
for i = 1:50
    for j = 1:50
        for k = 1:50
            T_ = Tf_leg(0.7, 7, 6, (i/50)*pi/3-pi/6 , (j/50)*pi-pi/2, (k/50)*pi-pi/2);
            qs = IK_mex(double([T_(1,4) T_(2,4) T_(3,4)]));
            e_min = [100 100 100];
            for u = 1:16
                tmp = Tf_leg( 0.7, 7, 6, qs(1,u), qs(2,u), qs(3,u));               
                e_min = min(e_min,abs([T_(1,4) T_(2,4) T_(3,4)] - tmp(1:3,4)'));
            end
            disp(sum(e_min.^2));
                %%disp([j k]);
            %%end
            e_max = max(e_max,e_min);
        end
    end
end