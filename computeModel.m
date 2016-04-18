close all
clear w
clear ii

%% overriding params
tau = 1; %temporal scaling (=1 == same time for learning)
T = timeScale/(tau*dt); %duration of the action

%% computing centers and variance of gaussians
[c,rho] = regModelParam(T,tPercentage,basisNumber,dt,alphaX,tau);

%% learning the demonstrated trajectory (computing the weights for each kernel)
disp('Learning trajectory...');
w = learnTrajectory(ytg, dytg, ddytg, alphaY, betaY, rho, c, dt, alphaX,tau);
disp('Trajectory learned!');