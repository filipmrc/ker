function [q] = getJointStates(joint_sub)
%GETJOINTSTATES Get current joint states
%   Get current joint states from /joint_states ROS message
joints = joint_sub.LatestMessage;
q = joints.Position(1:12)'; 
end

