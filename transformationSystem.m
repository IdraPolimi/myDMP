function [y, dy, ddy,yta] = transformationSystem(alphaY, betaY, goal, goalV,dt,dy, y,fi, tau,x,xEnd, alphaX)
% transformationSystem: compute a single step of the dynamical system.
% [y, dy, ddy] = transformationSystem(tauY, alphaY, betaY, goal, dy, y, tau)
% y'' = (1-x)*tauY*(alphaY*(betaY*(yta-y)+(goalV-y'));

yta = (goal + goalV*log(xEnd)/alphaX) -goalV.*log(x)/alphaX; %compute moving target
ddy = ((1-x)^2)*tau*(alphaY*(betaY*(yta-y)+(goalV-dy)))+tau*fi; 
y = (dt*dy*tau)+y;
dy = (dt*ddy*tau)+dy;

end