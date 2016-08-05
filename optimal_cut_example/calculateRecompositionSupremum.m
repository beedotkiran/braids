function [Lr1, Lr2] = calculateRecompositionSupremum(L1, L2)
% function calculates the common support begin recomposed by different 
% partial partitions from labeled partitions L1, L2
% create a bipartite graph between intersecting class pair from l1,m1 from (L1, L2)
% B Ravi Kiran 8 December 2014

Lr1 = zeros(size(L1));
Lr2 = zeros(size(L1));

%% bipartite intersection graph construction
%unroll graph into [max(L1(:))+max(L2(:))] \times [max(L1(:))+max(L2(:))] sparse graph
numX = max(L1(:));
numY = max(L2(:));

IsubGraph = sparse(numX, numY);

for i=1:numX
	mat = L1 == i;
	L2labels = unique(L2(mat));
		IsubGraph(i, L2labels) = 1;
end

Igraph = [sparse(numX, numX) IsubGraph; IsubGraph.'  sparse(numY, numY)];
%calculates connected components of graph
[S,C] = graphconncomp(Igraph);

% h = view(biograph(Igraph));

% colors = jet(S);
%  for i = 1:numel(h.nodes)
%      h.Nodes(i).Color = colors(C(i),:);
%  end

 for i=1:numX
 	mat = L1 == i;
 	Lr1(mat) = C(i);
 end

 for i=1:numY
 	mat = L2 == i;
 	Lr2(mat) = C(numX+i);
 end


