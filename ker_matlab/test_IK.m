e_max = 0;
global leg_fk
index = [];
for i = 1:50
    for j = 1:50
        for k = 1:50
            T_ = leg_fk((i/50)*pi/3-pi/6 , (j/50)*pi/2-pi/4, (k/50)*2*pi/3-pi/3);
            %disp(T_(1:3,4)')
            %ql = getJointStates(joint_sub);%[(i/50)*pi/3-pi/6, (j/50)*pi-pi/2,(k/50)*pi-pi/2];
            [qq] = IK([(i/50)*pi/3-pi/6 , (j/50)*pi-pi/2, (k/50)*pi-pi/2],double([T_(1,4) T_(2,4) T_(3,4)]));
            qs = wrapToPi(qq);
            e_min = [100 100 100];
            for u = 1:1;
                u=1;
                tmp = leg_fk( qs(1,u), qs(2,u), qs(3,u));
                % ZA GAZEBO
                Q = [qs(1,u), qs(1,u), qs(1,u), qs(1,u), qs(2,u), qs(3,u), -qs(2,u), -qs(3,u), qs(2,u), qs(3,u), -qs(2,u), -qs(3,u)];
                execute([qs(:,u)' 0 0 0 0 0 0 0 0 0]);    
                e_min = min(e_min,abs([T_(1,4) T_(2,4) T_(3,4)] - tmp(1:3,4)'));
                pause(0.1);
            end
            e_max = max(e_max,e_min);
        end
    end
end