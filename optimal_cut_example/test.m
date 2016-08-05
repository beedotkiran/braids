clear
clc
close all
% logfilename = [date num2str(now) '.txt'];
% diary(logfilename);

load 25098
I = imread('25098.jpg');
% lambdaVec = 0:100:40e3;
lambda = 250;
dealmode = 1; %normal 2 - random
[r,c] = size(ucm2);
ucm2 = ucm2(:);
ucm2 = ucm2.*(ucm2>0.18);
ucm2 = reshape(ucm2,r,c);
sal = subsampleSaliency(ucm2,20);
[H] = InitializeHierarchy(sal);
[Hnew] = InitializePartitions(H, dealmode);
[energyVecs] = initializeEnergy(Hnew, I);
% viewStack(Hnew);
lambdaVec = 0:100:5000;
Evec = zeros(1,length(lambdaVec)); Epvec = Evec;
parfor l=1:length(lambdaVec)
    lambda = lambdaVec(l);
    tic; [L1, E] = calculateOptimalCut(H, energyVecs, lambda); eltime1 = toc;
    Evec(l) = sum(E);
end
figure, plot(lambdaVec, Evec)
title('Lambda Vs Energy');
xlabel('\lambda');
ylabel('E(\lambda)');

% dealmode = 2; %normal 2 - random
% [Hnew] = InitializePartitions(H, dealmode);
% viewStack(Hnew);
% [energyVecs] = initializeEnergy(Hnew, I);
% tic; [L2, E2] = calculateOptimalCut(Hnew, energyVecs, lambda); eltime2 = toc;
% disp(['Optimal cut T=' num2str(eltime1)  'secs--Permuted Optimal Cut Time=' num2str(eltime2) 'secs--Equality=' num2str(isequal(L1,L2))])
% diary off