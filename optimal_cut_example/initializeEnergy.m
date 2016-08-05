function [energyVecs] = initializeEnergy(H, I)
% intializes energy vector for each labeled partition in the stack H 
% B Ravi Kiran 8 December 2014
for level=1:size(H,3)
	Lmat = H(:,:,level);
	[omegaPhiVec, omegaDeltaVec] = updatePartitionEnergy(Lmat, I);
	energyVecs(level).omegaPhiVec = omegaPhiVec;
	energyVecs(level).omegaDeltaVec = omegaDeltaVec;
end
