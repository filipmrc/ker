%   Generate gait from parameters

%alpha = 3; mu = 1; omega = 4.5; tau = 1;
alpha = 1; mu = 1; omega = 1; tau = 1;

[T, X, FL, FR, BR, BL] = sim('CPG.slx');

%   View results
plot(FL(17000:end,1),FL(17000:end,2));
%plot(T(10000:end),[FL(10000:end,1) FR(10000:end,1) BR(10000:end,1) BL(10000:end,1)])

[legFLx, legFLz] = filterCPGResults(FL);
[legFRx, legFRz] = filterCPGResults(FR);
[legBRx, legBRz] = filterCPGResults(BR);
[legBLx, legBLz] = filterCPGResults(BL);

wrapN = @(x, N) (1 + mod(x-1, N));
nFL = min(length(legFLx),length(legFLz));
nFR = min(length(legFRx),length(legFRz));
nBR = min(length(legBRx),length(legBRz));
nBL = min(length(legBLx),length(legBLz));
