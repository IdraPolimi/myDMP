clear var
clear x
clear plotX
clear plotPSI


%%%%%system variable
goal = 0.5; %goal variable
yInit = 0; % initial state of the system

tPercentage = 0.8; %duration of influence of regression model wrt total movement duration
timeScale = 7; %scale for total duration of action; the bigger, the longer. This changes shape of "time"
dt = 0.001; %integration time
alphax = 1; %gain term for phase variable, the bigger the shorter the action. This does not change shape of "time"
%tau = 0.7; %speed gain of the system, unset for now
T = timeScale/(alphax*dt); %duration of the action
%T = 1/dt;
basisNumber = 7; %number of basis functions
c = floor(linspace(1,T-1,basisNumber)*0.5); %centers of basis functions

%% computing centers of gaussians
cTemp = linspace(0,T*tPercentage,basisNumber+2); %generate a basisNumber of centers equally spaced over O:T
cTemp(1)=[]; %delete first and last centers.
cTemp(end)=[];
x = 1;
for ii = 1:T
    x = canonicalSystem(x,dt,alphax,1);
    c(ii==round(cTemp)) = x; %consider round of cTemp
end
%%

rho = 2*basisNumber./(c.^2); %variable variance for compensating exponential "time"
%rho = 100; %fixed variance for testing

%var for plotting
plotX = [];
plotPSI = [];


%% main loop
x = 1; %starting point of phase variable
plotX(1) = x;
psi = regModel(x,rho,c);
plotPSI(1,:) = psi;
for ii = 2:T
    x = canonicalSystem(x,dt,alphax,1);
    %x = x-0.0008; %linear time, for testing;
    psi = regModel(x,rho,c);
    plotX(ii) = x;
    plotPSI(ii,:) = psi;
end

%% computing forcing function
f = 0; %for testing

%% computing trajectory
y = yInit;
plotY(1) = y;
%%ok, but no speed is specified!
for ii = 2:T
    y = y+ (goal-y)*dt+f;
    plotY(ii) = y;
end

%% plotting
figure(1)
clf
plot(plotX)


figure(2)
clf
hold on
for ii = 1:basisNumber
    plot(plotPSI(:,ii));
end

figure(3)
clf
plot(plotY)

