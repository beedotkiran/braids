function [Lmin, Emin] = calculateOptimalCutBraidRandSalIter(sal, lambda, I, numIter)
% Iteratre over optimal cuts produced from rand saliency functions
% B Ravi Kiran 9 May 2016
[H] = InitializeHierarchy(sal);
[salMat] = InitializeSalMat(sal);
[energyVecs] = initializeEnergy(H, I);
[Lmin, Emin] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 0);
for i=1:numIter
    [randSal] = randSaliency(sal);
    [salMat] = InitializeSalMat(randSal);
    [energyVecs] = initializeEnergy(H, I);
    [L, E] = calculateOptimalCutBraid(H, energyVecs, lambda, I, salMat, 3);
    if(E<Emin)
        Emin = E; Lmin = L;
        disp('Rand Soln. better than initial');
    end
end