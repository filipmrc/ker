facx = 0.03;
facz = 0.02;
q = getJointStates(joint_sub);
q_leg = [q(7) , q(3), q(5), q(8) , q(4), q(6), q(9) , q(2), q(12),q(10), q(1), q(11)]';

k = 1;
for n = 1 : 4
    T = legFK(q_leg(k),q_leg(k+1),q_leg(k+2));
    pos_current(:,n) = T(1:3,4);
    k = k + 3;
end
for i = 1:10000
    q = getJointStates(joint_sub);
    q_leg = [q(7) , q(3), q(5), q(8) , q(4), q(6), q(9) , q(2), q(12),q(10), q(1), q(11)]';
    wFL = pos_current(:,1)' + [facx*legFLx(1 + wrapN(i,nFL-1)) 0 facz*legFLz(1 + wrapN(i,nFL-1))];
    wFR = pos_current(:,2)' + [facx*legFRx(1 + wrapN(i,nFR-1)) 0 facz*legFRz(1 + wrapN(i,nFR-1))];
    wBR = pos_current(:,3)' + [facx*legBRx(1 + wrapN(i,nBR-1)) 0 facz*legBRz(1 + wrapN(i,nBR-1))];
    wBL = pos_current(:,4)' + [facx*legBLx(1 + wrapN(i,nBL-1)) 0 facz*legBLz(1 + wrapN(i,nBL-1))];
    q_t = [IK(q_leg,wFL) IK(q_leg,wFR) IK(q_leg,wBR) IK(q_leg,wBL)];
    execute(q_t);
    pause(0.01);
end