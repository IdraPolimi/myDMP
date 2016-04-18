function [w] = learnTrajectory(ytg, dytg, ddytg, alphaY, betaY,rho,c,dt, alphaX,tau)
% learnTrajectory: given a trajectory in terms of position, velocity and acceleration,
% learns the weighted PSI

goal = ytg(end);
init = ytg(1);

%% Computing target function from target trajectory
Ftarget = ddytg-alphaY*(betaY*(goal-ytg)-dytg);

%% Computing weights
x(1) = 1;
for ii = 1:length(ytg)
    psi(:,ii) = regModel(x(ii),rho,c);
    s(ii) = x(ii)*(goal - init);
    x(ii+1) = canonicalSystem(x(ii),dt,alphaX,tau);
end

for ii = 1:length(c)
    midMatrix = diag(psi(ii,:));
    num = (s*midMatrix*Ftarget');
    den = (s*midMatrix*s');
    w(ii) = num/den;
    
end
end