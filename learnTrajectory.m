function [w] = learnTrajectory(ytg, dytg, ddytg, alphaY, betaY,psi, x)
% learnTrajectory: given a trajectory in terms of position, velocity and acceleration,
% learns the weighted PSI

goal = ytg(end);
init = ytg(1);

%% Computing target function from target trajectory
Ftarget = ddytg-alphaY*(betaY*(goal-ytg)-dytg);

%% Computing weights

s = x.*(goal-init);
psiTra = psi;
psiDiag = full(sparse(1:numel(psiTra), repmat(1:size(psiTra,1),1,size(psiTra,2)), psiTra(:)));
midMatrix = reshape(psiDiag', [1000,1000,15]);

w = zeros(1,size(psi,2));
for ii = 1:size(psi,2)
    num = (s*midMatrix(:,:,ii)*Ftarget');
    den = (s*midMatrix(:,:,ii)*s');
    w(ii) = num/den;    
end

end