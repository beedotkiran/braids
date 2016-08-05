clear
clc
% load 25098
% I = imread('25098.jpg');
load 140055
I = imread('140055.jpg');
[r,c] = size(ucm2);
ucm2 = ucm2(:);
ucm2 = ucm2.*(ucm2>0.25);
ucm2 = reshape(ucm2,r,c);
sal = subsampleSaliency(ucm2,10);
[H] = InitializeHierarchy(sal);
[energyVecs] = initializeEnergy(H, I);
lambda = 500;
E1 = energyVecs(1).omegaPhiVec + lambda*energyVecs(1).omegaDeltaVec;
E2 = energyVecs(2).omegaPhiVec + lambda*energyVecs(2).omegaDeltaVec;
[L, E] = getEnergeticInf(H(:,:,1), H(:,:,2), E1, E2);
[omegaPhiVec, omegaDeltaVec] = updatePartitionEnergy(L, I);
Eprime = omegaPhiVec + lambda*omegaDeltaVec;
isequal(Eprime,E)
