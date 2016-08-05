function [L, E] = calculateOptimalCut(H, energyVecs, lambda)
% Calculates optimal cut from the stack/hierarchy H, energy values in energy vector per partition in the stack H. Scale parameter lambda.
% B Ravi Kiran 8 December 2014
numLevels = size(H,3);
level = 1;
L = H(:,:,level); %initialize with 1st indexed partition from stack H 
E = energyVecs(level).omegaPhiVec + lambda*energyVecs(level).omegaDeltaVec;
while(level<numLevels)
	level = level + 1;
	Lprime = H(:,:,level);
	Eprime = energyVecs(level).omegaPhiVec + lambda*energyVecs(level).omegaDeltaVec;
	[L, E] = getEnergeticInf(L, Lprime, E, Eprime);
    %disp(['->cut#' num2str(level-1) '---#labels=' num2str(max(L(:))) '---Time=' num2str(eltime)]);
end

