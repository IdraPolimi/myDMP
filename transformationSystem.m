function [y, dy, ddy] = transformationSystem(alphaY, betaY, goal, dt,dy, y,fi, tau)
% transformationSystem: compute a single step of the dynamical system.
% [y, dy, ddy] = transformationSystem(tauY, alphaY, betaY, goal, dy, y, tau)
% y'' = tauY*(alphaY*(betaY*(goal-y)-y'));

ddy = (alphaY*(betaY*(goal-y)-dy/tau)+fi)*tau;
%ddy = alphaY*(betaY*(goal-y)-dy)+fi;
dy = (dt*ddy*tau)+dy;
y = (dt*dy)+y;

end