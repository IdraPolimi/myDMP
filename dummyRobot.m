function [yNew, error] = dummyRobot(yDes, yActual,t)

dt = 0.001;
error = yDes-yActual;
v= 100*error;

if (t> 100 && t<250)
    yNew = yActual;
else
yNew = yActual +v*dt;
end