function [G] = updateParentChildRelations(partitionIdx, Flabelled, G)
%Function updates DAG G with incoming new partition 
%partitionIdx - index of the partition to be added to the DAG
%Flabelled -  the input labelled family of partitions Flabelled
%Author B Ravi Kiran April 2014
L = Flabelled(:,:,partitionIdx);
labelList = unique(L);
%this is to calculate the new supremum comparision nodes that have been added but that dont exist in Flabelled
nodeList = getNodes(G); 
%obtain the largest supremum containing all nodes in the graph
[parentPartition] = getParents(G);
Lsup = calculateRecompositionSupremum(parentPartition, L);
supLabelList = unique(Lsup);
% There are three cases: 1) Lsup contains classes from L or 2) parent partition. 
% In such cases a simple parent child or child parent link has to be updated
% 3) When classes in Lsup are neither from L nor from parent partition .
% This means the supremum class is not present in the graph and needs to be added as a comparision node, 
% which exists in the graph purely for the purpose of comparing partially ordered partial partitions during the pruning step.

%difflist is a vector of length supLabelList and contains a ternary flag
% 0 - supremum class not present in either partition
% 1 - present in parent partition
% 2 - present in L
diffList = calculateDifferenceSet(parentPartition, L, Lsup)

for i=1:length(supLabelList)
	supLabelMat = Lsup == supLabelList(i);
	[LFlag, Llabels] = isClassInPartition(supLabelMat, L);
	[parentFlag, parentLabels] = isClassInPartition(supLabelMat, parentPartition);
	if(Lflag + parentFlag) %case 1 or 2
		if(Lflag && ~parentFlag)
			childLabels = parentPartition(L == Llabels);
			G = addDirectedEdge(G, Llabels, childLabels);
		end
		if(~Lflag && parentFlag)
			childLabels = L(parentPartition == parentLabels);
			G = addDirectedEdge(G, parentLabels, childLabels);
		end
	else %case 3
		%Function creates new node in the DAG with support supLabelMat. Parent-child links are added between it and the set of possible children in L and parentPartition
		%this children set is maintained as a linked list for this comparision node. There are two possibilites in the future:
		%A) the comparision node is turned into a proper node when the family introduces a partition with the supremum. this case is already taken care of in case 1 or 2 above.
		%B) the comparision node receives more children nodes who need to be compared with their cousins.
		G = createSupComparisionLinks(supLabelMat, parentPartition, L, parentLabels, Llabels, G);
	end
end

%functions to be written:
%isClassInPartition, addDirectedEdge, createSupComparisionLinks