function [c,rho] = regModelParam(x, T,tPercentage,basisNumber,alphaX)

disp('Generating gaussians...');

cTemp = linspace(1,T*tPercentage,basisNumber+1); %generate a basisNumber of centers equally spaced over O:T
cTemp(end)=[];%delete last center
c = x(round(cTemp));

% x = 1;
% for ii = 0:T-1
%     x = canonicalSystem(x,dt,alphaX,tau);
%     c(ii==round(cTemp)) = x; %consider round of cTemp
% end

rho = (11/alphaX)*basisNumber./(c.^2); %variable variance for compensating exponential "time"

disp('Gaussians generated!');
clear ii
end