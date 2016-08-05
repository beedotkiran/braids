function [labelMats] = getLabelsFromMST(ST,NumSites,IgSub)

[I,J,MinEdgeVals] = find(ST);
uniqueEdgeVals = unique(MinEdgeVals);

CG = sparse(NumSites, NumSites);
Ilabel = zeros(size(IgSub));
% h = view(biograph(CG));
labelMats = zeros(size(IgSub,1), size(IgSub,2),length(uniqueEdgeVals));
tic;
for j=1:length(uniqueEdgeVals)
    edgeOrder = find(MinEdgeVals==uniqueEdgeVals(j));
    CG(I(edgeOrder),J(edgeOrder)) = 1;
    [S,C] = graphconncomp(CG, 'Directed', 'False');
%     colors = jet(S);
%     for i = 1:numel(h.nodes)
%       h.Nodes(i).Color = colors(C(i),:);
%     end
%     pause(1)
%     figure(2), imshow(reshape(C,size(IgSub,1),size(IgSub,2)),[]); colormap(jet); drawnow;
%     disp(['Unique Edge index =' num2str(j) '--Number of Components' num2str(length(unique(C)))]);
    labelMats(:,:,j) = reshape(C,size(IgSub,1),size(IgSub,2));
end
disp(['Time to calculate hierarchy = ' num2str(toc) 'seconds']);
