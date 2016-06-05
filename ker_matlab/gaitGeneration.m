%   Generate gait from parameters

alpha = 1; mu = 1; omega = 1; tau = 1;

[T, X, FL, FR, BR, BL] = sim('CPG.slx');

%   View results
plot(FL(17000:end,1),FL(17000:end,2));
%plot(T(10000:end),[FL(10000:end,1) FR(10000:end,1) BR(10000:end,1) BL(10000:end,1)])

legFLx = 0.03*FL(17000:end,1);
legFLz = 0.03*FL(17000:end,2);

plot(legFLx,legFLz);