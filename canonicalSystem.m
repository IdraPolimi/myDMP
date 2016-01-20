function [x] = canonicalSystem(x, dt, alphax, tau)
% canonicalSystem: compute the phase variable x for each time instant;
% [x] = canonicalSystem(x, dt, alpha, tau)
% tau*x' = -alphax *x

x = dt*(-alphax*x)*tau+x;
end