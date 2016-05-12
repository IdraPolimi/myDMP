function [goal, dgoal] = updateGoal(newGoal,goal,dgoal, dt,alphaG)
%

ddgoal = alphaG*(newGoal-goal)- dgoal;
goal = goal + dt*alphaG*dgoal;
dgoal = dgoal + dt*ddgoal*alphaG;
