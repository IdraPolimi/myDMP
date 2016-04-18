function [x] = canonicalSystem(x, dt, alphax,tau)
% canonicalSystem: compute the phase variable x for each time instant;
% [x] = canonicalSystem(x, dt, alpha, tau)
% x' = tau* -alphax *x

x = tau*dt*(-alphax*x)+x;
%x = dt*(-alphax*x)+x;
%if abs(x)<0.7*10^-3
%    x = 0;
%end
end