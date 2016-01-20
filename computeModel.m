clear var
clear x
clear plotX
clear plotPSI


%%%%%system variable
dt = 0.001; %integration time
alphax = 5; %gain term for phase variable, set 
%tau = 0.7; %speed gain of the system, unset for now
T = (1.5/dt)*1.2; %duration of the action
basisNumber = 8; %number of basis functions
c = linspace(0.8,0.1,basisNumber); %centers of basis functions
rho = 0.02; %variance of basis functions


%%%%%var for plotting
plotX = [];
plotPSI = [];


%%main loop
x = 1; %starting point of phase variable
plotX(1) = x;
psi = regModel(x,1/rho,c);
plotPSI(1,:) = psi;
for ii = 2:T
    x = canonicalSystem(x,dt,alphax,1);
    %x = x-0.0008; %linear time, for testing;
    psi = regModel(x,1/rho,c);
    plotX(ii) = x;
    plotPSI(ii,:) = psi;
end

%%plotting
time = linspace(0,T*0.001,T);
figure(1)
clf
plot(plotX)


figure(2)
clf
hold on
for ii = 1:basisNumber
    plot(time,plotPSI(:,ii));
end

