clear
clc
load 25098
I = imread('25098.jpg');
% load 140055
% I = imread('140055.jpg');
% sal = (ucm2>0.08) + (ucm2>0.3) + (ucm2>0.95);
[r,c] = size(ucm2);
ucm2 = ucm2(:);
ucm2 = ucm2.*(ucm2>0.1);
ucm2 = reshape(ucm2,r,c);
sal = subsampleSaliency(ucm2,5);
[H] = InitializeHierarchy(sal);
[salMat] = InitializeSalMat(sal);
numLevels = size(H,3)
[energyVecs] = initializeEnergy(H, I);
% lambda = 2000;
lambdaVec = 0:100:2000;
alphaVec = [0:0.2:1];
SegsMat0 = zeros(size(H,1),size(H,2),length(alphaVec));
% SegsMat1 = zeros(size(H,1),size(H,2),length(lambdaVec));
% SegsMat2 = zeros(size(H,1),size(H,2),length(lambdaVec));
% Evec = zeros(1,length(lambdaVec)); E1vec = Evec; E2vec = Evec;
Evec = zeros(1,length(alphaVec)); 
EalphalambdaMat = zeros(length(alphaVec),length(lambdaVec)); 
omegaPhi0Vec = Evec; omegaPhi1Vec = Evec; omegaPhi2Vec = Evec;
omegaDelta0 = Evec; omegaDelta1 = Evec; omegaDelta2 = Evec; 

for l=1:length(lambdaVec)
    lambda = lambdaVec(l)
    parfor a=1:length(alphaVec)
        alpha = alphaVec(a);
    %     tic; [SegsMat0(:,:,l), E] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 0); eltime = toc;
    %     tic; [SegsMat1(:,:,l), E1] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 1); eltime1 = toc;
    %     tic; [SegsMat2(:,:,l), E2] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 5); eltime2 = toc;
        [L, E] = calculateAlphaOptimalCutBraid(H, energyVecs, lambda, I, salMat, 0, alpha);
    %     figure(1), imshow(L,[]); colormap(jet); title(['\alpha=' num2str(alpha)]); drawnow; 
          Evec(a) = sum(E);
          SegsMat0(:,:,a) = L;
    end
    EalphalambdaMat(:,l) = Evec;
    writeStackIdx(SegsMat0,['Lambda-' num2str(lambda)]);
end

cc = hsv(length(lambdaVec));
figure(2),
legendText = [];
for l=1:length(lambdaVec)
    h = plot(alphaVec, EalphalambdaMat(:,l),'color',cc(l,:))
    if(l==1) hold on; end
end

xlabel('\alpha')
ylabel('\omega(\pi^\ast(\alpha))')
legend([ cellstr(num2str(((lambdaVec))'))])
set(gca,'FontSize',12,'fontWeight','bold')
set(findall(gcf,'type','text'),'FontSize',16,'fontWeight','bold')
title(['\lambda-cut at different values of \alpha \in [0:0.25:1.5]'])
set(h, 'LineWidth',2.5)
