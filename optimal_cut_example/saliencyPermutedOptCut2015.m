clear
clc
% load 25098
% I = imread('25098.jpg');

load 187029
I = imread('187029.jpg');

%working example for ISMM 2015 paper
% load 140055
% I = imread('140055.jpg');

sal = (ucm2>0.01) + (ucm2>0.2) + (ucm2>0.3) + (ucm2>0.5) + (ucm2>0.7) + (ucm2>0.95);
% [r,c] = size(ucm2);
% ucm2 = ucm2(:);
% ucm2 = ucm2.*(ucm2>0.3);
% ucm2 = reshape(ucm2,r,c);
% sal = subsampleSaliency(ucm2,20);
[H] = InitializeHierarchy(sal);
[salMat] = InitializeSalMat(sal);
numLevels = size(H,3)
[energyVecs] = initializeEnergy(H, I);
% lambda = 1000;
lambdaVec = 0:100:1000;
SegsMat0 = zeros(size(H,1),size(H,2),length(lambdaVec));
SegsMat1 = zeros(size(H,1),size(H,2),length(lambdaVec));
SegsMat2 = zeros(size(H,1),size(H,2),length(lambdaVec));
Evec = zeros(1,length(lambdaVec)); E1vec = Evec; E2vec = Evec;
omegaPhi0Vec = Evec; omegaPhi1Vec = Evec; omegaPhi2Vec = Evec;
omegaDelta0 = Evec; omegaDelta1 = Evec; omegaDelta2 = Evec; 
tic
parfor l=1:length(lambdaVec)
    disp(['Lambda=' num2str(lambdaVec(l))])
    lambda = lambdaVec(l);
%     tic; [SegsMat0(:,:,l), E] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 0); eltime = toc;
%     tic; [SegsMat1(:,:,l), E1] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 1); eltime1 = toc;
%     tic; [SegsMat2(:,:,l), E2] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 5); eltime2 = toc;
    tic; [L, E] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 0); eltime = toc;
    tic; [L1, E1] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 6); eltime1 = toc;
%     tic; [L2, E2] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 2); eltime2 = toc;
    [a, b] = updatePartitionEnergy(L, I); omegaPhi0Vec(l) = sum(a); omegaDelta0Vec(l) = sum(b);  
    [a1, b1] = updatePartitionEnergy(L1, I); omegaPhi1Vec(l) = sum(a1); omegaDelta1Vec(l) = sum(b1);  
%     [a2, b2] = updatePartitionEnergy(L2, I); omegaPhi2Vec(l) = sum(a2); omegaDelta2Vec(l) = sum(b2);  
    SegsMat0(:,:,l) = L; SegsMat1(:,:,l) = L1; %SegsMat2(:,:,l) = L2;
%     disp(['Time for Min Cut from Hierarchy:' num2str(eltime1)])
%     disp(['Time for Min Cut from Perturbed Hierarchy:' num2str(eltime2)])
%     disp(['E(' num2str(lambda) '):' num2str(sum(E1))])
    % disp(['E(Hp):' num2str(sum(E2))])
%     disp(['EnergyDiff = ' num2str(sum(E1)-sum(E2)) '--Equal Cuts ? = ' num2str(isequal(seg2bdry(L1),seg2bdry(L2)))]);
%     [omegaPhi0, omegaDelta0] = updatePartitionEnergy(SegsMat0(:,:,l), I); E = (omegaPhi0 + lambda*omegaDelta0);
%     [omegaPhi1, omegaDelta1] = updatePartitionEnergy(SegsMat1(:,:,l), I); E1 = (omegaPhi1 + lambda*omegaDelta1);
%     [omegaPhi2, omegaDelta2] = updatePartitionEnergy(SegsMat2(:,:,l), I); E2 = (omegaPhi2 + lambda*omegaDelta2);
%     disp(['EnergyDiff = ' num2str(sum(E1)-sum(E2)) '--Equal Cuts ? = ' num2str(isequal(seg2bdry(L1),seg2bdry(L2)))]);
    Evec(l) = sum(E);
    E1vec(l) = sum(E1);
%     E2vec(l) = sum(E2);
end
toc

figure(1),
h = plot(lambdaVec, Evec);
set(h, 'LineWidth',2.5)
disp(['Number of Negative dE = ' num2str(sum(gradient(Evec)<0))])
hold on 
h = plot(lambdaVec, E1vec,'r');
set(h, 'LineWidth',2.5)

% plot(lambdaVec, E2vec,'g')
title('Optimal vs Perturbed Cuts')
xlabel('\lambda')
ylabel('\omega(\pi^\ast)')
% legend('Hierarchy', '1-iters', '5-iters')
legend('Hierarchy', 'Perturbed')
set(gca,'FontSize',12,'fontWeight','bold')
set(findall(gcf,'type','text'),'FontSize',16,'fontWeight','bold')
set(h, 'LineWidth',2.5)
% disp(['Number of Negative dEp = ' num2str(sum(gradient(E2vec)<0))])
% plot(lambdaVec, Evec-E2vec,'-.k')
% 
% figure(2), 
% plot(lambdaVec, omegaPhi0Vec); hold on; plot(lambdaVec, omegaPhi1Vec,'r'); plot(lambdaVec, omegaPhi1Vec,'g');
% figure(3), 
% plot(lambdaVec, omegaDelta0Vec); hold on; plot(lambdaVec, omegaDelta1Vec,'r'); plot(lambdaVec, omegaDelta2Vec,'g')

sum(Evec-E1vec)

