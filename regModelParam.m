function [c,rho] = regModelParam(T,tPercentage,basisNumber,dt,alphaX,tau)

disp('Generating gaussians...');
cTemp = linspace(0,T*tPercentage,basisNumber+1); %generate a basisNumber of centers equally spaced over O:T
cTemp(end)=[];%delete last center
x = 1;
for ii = 0:T-1
    x = canonicalSystem(x,dt,alphaX,tau);
    c(ii==round(cTemp)) = x; %consider round of cTemp
end
rho = (11/alphaX)*basisNumber./(c.^2); %variable variance for compensating exponential "time"
disp('Gaussians generated!');
clear ii
end