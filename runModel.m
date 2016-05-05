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
goal = ytg(:,end);
goalV = dytg(:,end)-0.5;
yInit = ytg(:,1);
yVInit = dytg(:,1);
dyInit = dytg(:,1);

%% computing centers and variance of gaussians
T = timeScale/(tau*dt);
x = ones(1,T);
for ii = 2:T
    x(ii) = canonicalSystem(x(ii-1),dt,alphaX,tau);
end

[c,rho,psiN] = regModelParam(x,T,tPercentage,basisNumber,alphaX);

%% main loop
xEnd = x(end);
x = 1;
dy = dyInit;
y = yInit;
for ii = 1:T
    psi = psiN(ii,:);
    for jj = 1:gdl
        f = ((psi*w(jj,:)')/sum(psi))*x*(goal(jj)-yInit(jj));% updating forcing term
        [y(jj), dy(jj), ddy(jj),tm] = transformationSystem(alphaY, betaY, goal(jj), goalV(jj), dt, dy(jj), y(jj), f, tau,x,xEnd, alphaX); %computing trajectory
        if (plotGraph)
            plotTM(ii) = tm;
            plotX(ii) = x;
            plotY(jj,ii) = y(jj);
            plotdY(jj,ii) = dy(jj);
            plotddY(jj,ii) = ddy(jj);
        end
    end
    x = canonicalSystem(x,dt,alphaX, tau);
end

%% plotting
if(plotGraph)
       figure(9)
    clf
    plot(plotTM)
    title('TM');
    
    figure(10)
    clf
    plot(plotX)
    title('Time (cycle)');
    
    figure(2)
    clf
    hold on
    for ii = 1:basisNumber
        plot(psiN(:,ii));
    end
    title('Basis functions');
    
    for jj = 1:gdl
        graphName = jj*10;
        figure(graphName)
        clf
        plot(plotY(jj,:),'r')
        hold on
        plot(ytg(jj,:),'k')
        title('Output trajectory');
        
        figure(graphName+1)
        clf
        plot(plotdY(jj,:),'r')
        hold on
        plot(dytg(jj,:),'k')
        title('Output Velocity');
        
        figure(graphName+2)
        clf
        plot(plotddY(jj,:),'r')
        hold on
        plot(ddytg(jj,:),'k')
        title('Output Acceleration');
        
    end
end