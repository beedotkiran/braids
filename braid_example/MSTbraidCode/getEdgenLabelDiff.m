function [eC, lC] = getEdgenLabelDiff(labelMats, plabelMats)
% function calculates the difference in the number of labels in the hierarchy and the number of edges
% 
minSize = min(size(labelMats2,3),size(labelMats,3));
compareVec = zeros(1,minSize);
for i=1:minSize
    %MatsCon = [imresize(labelMats(:,:,i),16,'nearest') imresize(plabelMats2(:,:,i),16,'nearest')];
    l1 = labelMats(:,:,i); l2 = plabelMats(:,:,i);
    compareVec(i) = sum(l1(:)~= l2(:))/NumSites;
%     figure(2), imshow(MatsCon,[]); colormap(jet); drawnow;
end
disp(['Number of Edges Changed in Graph = ' num2str(sum(EdgeCosts(:)~=pEdgeCosts(:)))]);    
disp(['Number of label changes in MST =' num2str(sum(compareVec))]);
eC = sum(EdgeCosts(:)~=pEdgeCosts(:))/length(pi);
lC = sum(compareVec)/minSize;