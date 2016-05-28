function [q] = getJointStates(joint_sub)
%GETJOINTSTATES get the joint states
%   Detailed explanation goes here
joints = joint_sub.LatestMessage;
q = joints.Position(1:12)'; 
end

