    q = getJointStates(joint_sub);
    
    q_leg = [q(5) , q(3), q(9), q(6) , q(4), q(10), q(7) , q(2), q(12),q(8), q(1), q(11)];
    
    % foot positions in body coordinate frame
    T_fb1 = body_foot1(q_leg(1), q_leg(2), q_leg(3));
    T_fb2 = body_foot2(q_leg(4), q_leg(5), q_leg(6));
    T_fb3 = body_foot3(q_leg(7), q_leg(8), q_leg(9));
    T_fb4 = body_foot4(q_leg(10), q_leg(11), q_leg(12));
    
    T_bg = getTF('map','odom');
    
    XB = T_bg(1:3,4);
    RB = T_bg(1:3,1:3)';
    
    FPB = [T_fb1(1:3,4); T_fb2(1:3,4); T_fb3(1:3,4); T_fb4(1:3,4)]; % pozicije šapa u lokalnom  
      
    FPG = ([XB' XB' XB' XB'] + [(RB*FPB(1:3))', (RB*FPB(4:6))', (RB*FPB(7:9))', (RB*FPB(10:12))'])';

    %FPG = [T_gf1(1:3,4); T_gf2(1:3,4); T_gf3(1:3,4); T_gf4(1:3,4)]; %pozicije šapa u globalnom
    
    J1_A =  J1A(q_leg(1), q_leg(2), q_leg(3));% naprijed lijevo
    J2_A =  J2A(q_leg(4), q_leg(5), q_leg(6));% naprijed desno
    J3_A =  J3A(q_leg(7), q_leg(8), q_leg(9));% straga desno
    J4_A =  J4A(q_leg(10), q_leg(11), q_leg(12));% straga lijevo
    
    dFPB_dq  = [J1_A zeros(3,9); zeros(3,3) J2_A zeros(3,6); zeros(3,6) J3_A zeros(3,3); zeros(3,9) J4_A];
    
    dL_dFPB = zeros(4,12);
    dL_dFPB(1,1:3) = FPB(1:3)/norm(FPB(1:3)); dL_dFPB(2,4:6) = FPB(4:6)/norm(FPB(4:6)); ...
        dL_dFPB(3,7:9) = FPB(7:9)/norm(FPB(7:9)); dL_dFPB(4,10:12) = FPB(10:12)/norm(FPB(10:12));
    
    dL_dXB = [(XB - FPG(1:3))'/norm(XB - FPG(1:3)); (XB - FPG(4:6))'/norm(XB - FPG(4:6)); ...
        (XB - FPG(7:9))'/norm(XB - FPG(7:9)); (XB - FPG(10:12))'/norm(XB - FPG(10:12))];
   
    dXB_dq = pinv(dL_dXB)*dL_dFPB*dFPB_dq;
    %dXB_dq(1,1) = 0; dXB_dq(1,4) = 0; dXB_dq(1,7) = 0; dXB_dq(1,10) = 0;
    dRB_dq = dRBdq(dXB_dq,dFPB_dq,RB,FPB);
    
    T_cmg = T_bg;
    dXML_dq = dXdq(T_cmg ,T_bg, FPG, q_leg);
    
    J_XMG = XJacobian(T_cmg, T_bg, dXB_dq, dXML_dq, dRB_dq);
    
    T_sw = T_gf1;
    dXSWL_dq = dXdq(T_sw ,T_bg, FPG, q_leg);
    J_SWG = XJacobian(T_sw, T_bg, dXB_dq, dXSWL_dq, dRB_dq);
    
    dXSWLg = goal - [T_gf1(1:3,4);T_gf2(1:3,4);T_gf3(1:3,4);T_gf4(1:3,4)];
    dXB = b_goal - XB;
    
    dpg = dXSWLg;
    dpb = [T_bg(1:3,1:3)\dpg(1:3); T_bg(1:3,1:3)\dpg(4:6); T_bg(1:3,1:3)\dpg(7:9); T_bg(1:3,1:3)\dpg(10:12)];
    
     dq_ref = dFPB_dq\[dpb(1:3); dpb(4:6) ; dpb(7:9); dpb(10:12)];
     dq1 = pinv(J_SWG)*dXSWLg(1:3)  + (eye(12) - pinv(J_SWG)*J_SWG)*dq_ref;
     dq = q_leg' + 0.01*(pinv(J_XMG)*dXB + (eye(12) - pinv(J_XMG)*J_XMG)*dq1);
%     dq = q_leg' + dFPB_dq\[dpb(1:3); dpb(4:6) ; dpb(7:9); dpb(10:12)];
    %Jj = [J1_A J2_A J3_A J4_A];
    %dq1 = dFPB_dq\[dpb(1:3); dpb(4:6) ; dpb(7:9); dpb(10:12)] + 0.2*(eye(12) - pinv(Jj)*Jj)*((q_leg - beg').^2)';
    %tmp = pinv(J_XMG)*dXB; %tmp(7) = -tmp(7); tmp(10) = -tmp(10);
    %dq = q_leg' + 0.1*tmp;

