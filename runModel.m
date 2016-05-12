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

goal = ytg(:,end); %goal coordinates for each dof
yInit = ytg(:,1); % initial coordinates for each dof
dyInit = dytg(:,1); % initial speed for each dof
goalV = dytg(:,end); % final speed of each dof 
%tau = 1; %gain term for speed of movement;

%% computing centers and variance of gaussians
T = timeScale/(tau*dt);
x = ones(1,T);
for ii = 2:T
    x(ii) = canonicalSystem(x(ii-1),dt,alphaX,tau);
end

[c,rho,psiN] = regModelParam(x,T,tPercentage,basisNumber,alphaX);

%% main loop
x = 1; %resetting phase variable for starting the movement
dy = dyInit; 
y = yInit;
newGoal = goal;

for ii = 1:T
    psi = psiN(ii,:);
    for jj = 1:gdl
        f = ((psi*w(jj,:)')/sum(psi))*x*(goal(jj)-yInit(jj))*scale;% updating forcing term
        [y(jj), dy(jj), ddy(jj),tm] = transformationSystem(alphaY, betaY, goal(jj), goalV(jj), dt, dy(jj), y(jj), f, tau,x,x(end), alphaX); %computing trajectory
        [goal(jj),dgoal(jj)] = updateGoal(newGoal(jj),goal(jj),dgoal(jj), dt,alphaG);
        if (plotGraph)
            plotTM(ii) = tm;
            plotX(ii) = x;
            plotY(jj,ii) = y(jj);
            plotdY(jj,ii) = dy(jj);
            plotddY(jj,ii) = ddy(jj);
            plotgoal(jj,ii) = goal(jj);
        end
    end
    % example of a change in goal while computing trajectory
    if(ii == 500)
        newGoal(jj) = newGoal(jj)*2;
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
        
         figure (graphName+3)
       clf
       plot(plotgoal(jj,:))
       title('Goal');
        
    end
end