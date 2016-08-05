function [L, E] = calculateAlphaOptimalCutBraid(H, energyVecs, lambda, I, salMat, numIter, alpha)
% Calculates optimal cut from the stack/hierarchy H, energy values in energy vector per partition in the stack H. Scale parameter lambda.
% B Ravi Kiran 27 May 2015
numLevels = size(H,3);
level = 1;
L = H(:,:,level); %initialize with 1st indexed partition from stack H 
E = energyVecs(level).omegaPhiVec + lambda*energyVecs(level).omegaDeltaVec;
numPtsVec = 3*ones(1,numLevels);
numPtsVec(round(numLevels/2):end) = 1;
while(level<numLevels)
	level = level + 1;
	Lprime = H(:,:,level); %Parent Level
	Eprime = energyVecs(level).omegaPhiVec + lambda*energyVecs(level).omegaDeltaVec;
    [L, ~] = getAlphaEnergeticInf(L, Lprime, E, Eprime, alpha);
    [omegaPhi, omegaDelta] = updatePartitionEnergy(L, I);
%     isequal(sum(E),sum(omegaPhi + lambda*omegaDelta))
    E = (omegaPhi + lambda*omegaDelta);

    %% Perturbation part
    while(numIter>0)
        Lnew = binaryPermuteSal(salMat(:,:,level), salMat(:,:,level-1), numPtsVec(level));
        flagEqual = isequal(Lnew, H(:,:,level)) + isequal(Lnew, H(:,:,level-1));
%         figure(1), imshow([Lprime Lnew H(:,:,level-1)],[]); colormap(jet); drawnow; pause(0.1);
%         title(['Equal Cut Flags ?' num2str(isequal(seg2bdry(Lprime),seg2bdry(Lnew))) ',' num2str(isequal(seg2bdry(H(:,:,level-1)),seg2bdry(Lnew)))])
%         drawnow;
        [omegaPhiVecNew, omegaDeltaVecNew] = updatePartitionEnergy(Lnew, I);
        Enew = omegaPhiVecNew + lambda*omegaDeltaVecNew;
%         disp(['Pertubation iteration ' num2str(numIter) 'New L Equal ? = ' num2str(flagEqual)]);
        [Lp, ~] = getAlphaEnergeticInf(Lnew, L, Enew, E,alpha);
        [omegaPhi, omegaDelta] = updatePartitionEnergy(Lp, I);
        Ep = (omegaPhi + lambda*omegaDelta);
%         disp([ 'Enew, Ep, E = ' num2str(sum(Enew)) ',' num2str(sum(Ep)) ',' num2str(sum(E))]);
        if(sum(Ep)<sum(E))
            E = Ep; L = Lp;
            disp('Perturbed solution better than Original');
        end
        numIter = numIter - 1;
    end
%     dispstate = ['->cut#' num2str(level-1) '#Lab' num2str(max(L(:))) '--Sum(E)=' num2str(sum(E))];
%     debugdispstate = ['--Sum(Ed)' num2str(Edash)];
%     disp([dispstate]);
end

