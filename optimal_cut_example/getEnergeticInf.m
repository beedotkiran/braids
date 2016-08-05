function [L, energyVec] = getEnergeticInf(L1, L2, E1, E2)
% function calculates the energetic infimum between two labeled partitions L1, L2
% B Ravi Kiran 8 December 2014
[Lsup] = calculateRecompositionSupremum(L1, L2);
l1Max = max(L1(:));
L2 = L2 + l1Max; %labels with different values;
energyArray = [E1 E2];
L = zeros(size(L1));
for suplabel = 1:max(Lsup(:))
	matSup = Lsup==suplabel;
	L1labels = unique(L1(matSup));
	L2labels = unique(L2(matSup));
    %Accumulate Energies over supremum from L1 and L2
    energyL1 = sum(E1(L1labels));
    energyL2 = sum(E2(L2labels-l1Max));
	if(energyL1<energyL2)
%         disp('Child Optimal');
		L(matSup) = L1(matSup);
    else
%         disp('Parent Optimal');
		L(matSup) = L2(matSup);		
    end
end

%Map back labels and energies
uniqueLabels = unique(L);
energyVec = zeros(1,length(uniqueLabels));
for i=1:length(uniqueLabels)
    energyVec(i) = energyArray(uniqueLabels(i));
end
partitionL = seg2bdry(L);
L = bwlabel(~partitionL);
L = L(2:2:end,2:2:end);