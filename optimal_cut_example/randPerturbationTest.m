clear
clc
load 25098
I = imread('25098.jpg');
[r,c] = size(ucm2); ucm2vec = ucm2(:);
ucm2 = reshape((ucm2vec>0.08).*ucm2vec,r,c);
length(unique(ucm2))
% load 140055
% I = imread('140055.jpg');
%working example for ISMM 2015 paper
% sal = (ucm2>0.08) + (ucm2>0.3) + (ucm2>0.95);
% sal = (ucm2>0.08) + (ucm2>0.1) + (ucm2>0.3) + (ucm2>0.5) + (ucm2>0.95);
[sal] = subsampleSaliency(ucm2,25);
length(unique(sal))
[H] = InitializeHierarchy(sal); 
[salMat] = InitializeSalMat(sal); 
[energyVecs] = initializeEnergy(H, I);
numLevels = size(H,3)

lambdaVec = 500:3000:10000;
SegsMat0 = zeros(size(H,1),size(H,2),length(lambdaVec));
SegsMat1 = zeros(size(H,1),size(H,2),length(lambdaVec));
Evec = zeros(1,length(lambdaVec)); E1vec = Evec; E2vec = Evec;
omegaPhi0Vec = Evec; omegaPhi1Vec = Evec; omegaPhi2Vec = Evec;
omegaDelta0 = Evec; omegaDelta1 = Evec; omegaDelta2 = Evec; 
iters = 5;
tic
parfor l=1:length(lambdaVec)
    lambda = lambdaVec(l);
    [L, E] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 0);
    Er = E; count = 1;
    while( (sum(E)<=sum(Er)) && (count<iters) )
        disp(['Iter#-' num2str(count) '-E=' num2str(sum(E)) '-Er' num2str(sum(Er))]);
        count = count + 1;
        [randSal] = randSaliency(sal);
        [randH] = InitializeHierarchy(randSal); 
        [randSalMat] = InitializeSalMat(randSal); 
        [randEnergyVecs] = initializeEnergy(randH, I);
        [L1, E1] = calculateOptimalCutBraid(randH, randEnergyVecs, lambda, I, randSalMat, 3); 
        [Lr, ~] = getEnergeticInf(L, L1, E, E1);
        [omegaPhi, omegaDelta] = updatePartitionEnergy(Lr, I);
        Er = (omegaPhi + lambda*omegaDelta);
    end
    SegsMat0(:,:,l) = L; SegsMat1(:,:,l) = Lr; 
    Evec(l) = sum(E); E1vec(l) = sum(Er);
    disp(['-->lambda=' num2str(lambdaVec(l)) '--Difference E-Ep=' num2str(Evec(l)-E1vec(l)) '--Iterations = ' num2str(count)]);
end
disp([num2str(length(lambdaVec)) '-Cuts calculated in ' num2str(toc)]);

figure(1), hold on 
h = plot(lambdaVec, Evec);
set(h, 'LineWidth',2.5)
disp(['Number of Negative dE = ' num2str(sum(gradient(Evec)<0))])
h = plot(lambdaVec, E1vec,'r');
set(h, 'LineWidth',2.5)
title('Optimal vs Perturbed Cuts')
xlabel('\lambda')
ylabel('\omega(\pi^\ast)')
legend('Hierarchy', 'Perturbed')
set(gca,'FontSize',12,'fontWeight','bold')
set(findall(gcf,'type','text'),'FontSize',16,'fontWeight','bold')
set(h, 'LineWidth',2.5)
sum(Evec-E1vec)

