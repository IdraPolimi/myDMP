tPercentage = 0.90; %duration of influence of regression model wrt total movement duration
timeScale = 1; %scale for total duration of action; the bigger, the longer. *DO NOT CHANGE
dt = 0.001; %integration time *DO NOT CHANGE
alphaX = 7.5; %gain term for "time", change the shape of time; set so that x->0 in T timestamp. *DO NOT CHANGE
tau = 1; %deafult gain term for the speed of the action; > 1 --> speed up movements, <1 --> slow down moevments.
alphaY = 25; %gain term for trajectory acceleration *DO NOT CHANGE
betaY = alphaY/4; %gain term for trajectory acceleration (set equal alphaY/4 for critical dampening) *DO NOT CHANGE
basisNumber = 15; %number of basis functions
