clear
clc
addpath('D:\RaviDocs\ToolBoxes\matlab_bgl-4.0.1\matlab_bgl');
I = imread('25098.jpg');
r = 481;
c = 321;
load N8matrix-481x321
[EdgeCosts] = getEdgeWeights(I, weight);
uniqueEdgeValues = unique(find(EdgeCosts));
tic; T = mst(EdgeCosts); toc;
disp(['Number of Edges = ' num2str(length(find(EdgeCosts)))]);
disp(['Number of Unique Valued Edges = ' num2str(length(uniqueEdgeValues))]);
disp(['Residual Degenerate number of edges = ' num2str(length(find(EdgeCosts))-length(uniqueEdgeValues))]);