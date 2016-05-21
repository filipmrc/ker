e_max = 0;
% leg_fk = matlabFunction(subs(T_leg_foot1,{'a1','a2','d4'},{0.0272,0.056,0.03958}),'File', 'leg_fk.m');
for i = 1:1
    for j = 1:1
        for k = 1:1
            T_ = leg_fk((i/50)*pi/3-pi/6 , (j/50)*pi-pi/2, (k/50)*pi-pi/2);
            qs = IK(double([T_(1,4) T_(2,4) T_(3,4)]));
            e_min = [100 100 100];
            for u = 1:size(qs,2);
                tmp = leg_fk( qs(1,u), qs(2,u), qs(3,u));
                % ZA GAZEBO
                %Q = [qs(1,u), 0, 0, 0, qs(2,u), qs(3,u), 0, 0, 0, 0, 0, 0];
                %send_msgs(Q,shoulder_pub,leg_pub);    
                e_min = min(e_min,abs([T_(1,4) T_(2,4) T_(3,4)] - tmp(1:3,4)'));
                pause(2);
            end
            e_max = max(e_max,e_min);
        end
    end
end