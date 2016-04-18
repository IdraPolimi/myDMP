close all

clear y
clear dy
clear ddy
clear plotY
clear plotdY
clear plotddY
clear plotX
clear plotPSI

%% overriding params
plotGraph = true;
tau =1;
goal = ytg(end);
yInit = ytg(1);
dyInit = dytg(1);

%% computing centers and variance of gaussians
T = timeScale/(tau*dt);
[c,rho] = regModelParam(T,tPercentage,basisNumber,dt,alphaX,tau);

%% main loop
x = 1;
dy = dyInit;
y = yInit;
for ii = 1:T
    psi = regModel(x,rho,c);
    f(ii) = ((psi*w')/sum(psi))*x*(goal-yInit);% updating forcing term
    [y, dy, ddy] = transformationSystem(alphaY, betaY, goal, dt, dy, y, f(ii), tau); %computing trajectory
    if (plotGraph)
        plotX(ii) = x;
        plotPSI(ii,:) = psi;
        plotY(ii) = y;
        plotdY(ii) = dy;
        plotddY(ii) = ddy;
    end
    x = canonicalSystem(x,dt,alphaX, tau);
end

%% plotting
if(plotGraph)
    figure(10)
    clf
    plot(plotX)
    title('Time (cycle)');
    
    figure(2)
    clf
    hold on
    for ii = 1:basisNumber
        plot(plotPSI(:,ii));
    end
    title('Basis functions');
    
    figure(11)
    clf
    plot(plotY,'r')
    hold on
    plot(ytg,'k')
    title('Output trajectory');
    
    figure(12)
    clf
    plot(plotdY,'r')
    hold on
    plot(dytg,'k')
    title('Output Velocity');
    
    figure(13)
    clf
    plot(plotddY,'r')
    hold on
    plot(ddytg,'k')
    title('Output Acceleration'); 
end