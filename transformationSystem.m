function [y, dy, ddy,yta] = transformationSystem(alphaY, betaY, goal, goalV,dt,dy, y,fi, tau,x,xEnd, alphaX)
% transformationSystem: compute a single step of the dynamical system.
% [y, dy, ddy] = transformationSystem(tauY, alphaY, betaY, goal, dy, y, tau)
% y'' = tauY*(alphaY*(betaY*(goal-y)-y'));

%tm = (goal + goalV*log(xEnd)) - goalV.*log(x);
yta = (goal + goalV*log(xEnd)/alphaX) -goalV.*log(x)/alphaX;
ddy = (1-x)*tau*(alphaY*(betaY*(yta-y)+(goalV-dy)))+tau*fi;
%ddy = tau*(alphaY*(betaY*(tm-y)+ (goalV- dy)/tau))+tau*fi;
y = (dt*dy*tau)+y;
dy = (dt*ddy*tau)+dy;

end