%   Generate gait from parameters

alpha = 3; mu = 1; omega = 4.5; tau = 1;

[T, X, FL, FR, BR, BL] = sim('CPG.slx');

%   View results
%plot(FL(17000:end,1),FL(17000:end,2));
%plot(T(10000:end),[FL(10000:end,1) FR(10000:end,1) BR(10000:end,1) BL(10000:end,1)])

legFLx = 0.03*FL(17000:end,1);
legFLz = 0.03*FL(17000:end,2);

legFRx = 0.03*FR(17000:end,1);
legFRz = 0.03*FR(17000:end,2);

legBRx = 0.03*FR(17000:end,1);
legBRz = 0.03*FR(17000:end,2);

legBLx = 0.03*FR(17000:end,1);
legBLz = 0.03*FR(17000:end,2);

plot(legFLx,legFLz);