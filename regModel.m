function [psi] = regModel(x,rho,c)
% regModel: compute the regression model exp(0.5*rho*(x-c)^2)

psi = exp((-0.5*rho).*((x-c).^2));
end