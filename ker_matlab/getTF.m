function [ T ] = getTF(f2,f1)
%GETTF Get transformation between frames
%   Detailed explanation goes here

global tftree;
Tf_12 = getTransform(tftree,f2,f1);
tr_12 = [Tf_12.Transform.Translation.X, ...
    Tf_12.Transform.Translation.Y, ...
    Tf_12.Transform.Translation.Z]';
q_12 = [Tf_12.Transform.Rotation.W, ...
    Tf_12.Transform.Rotation.X, ...
    Tf_12.Transform.Rotation.Y, ...
    Tf_12.Transform.Rotation.Z];

R_12 = quat2rotm(q_12);
T = [R_12 tr_12; 0 0 0 1];

end

