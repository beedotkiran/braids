function [eC, lC] = imageMSTtest(alpha, NumTrees)
%alpha - strenghth of random perturbation on edge weights
%NumTrees - Number of different trees to be generated
I = imread('25098.jpg');
Ig = rgb2gray(I);
k = 20;
xyorigin = 100;
xr = xyorigin:xyorigin+k-1;
yr = xyorigin:xyorigin+k-1;
IgSub = double(Ig(xr,yr));
NumSites = length(IgSub(:));
W = getAdjacencyMatrix(IgSub);
[rows, cols] = find(W);
grad = abs(IgSub(rows)-IgSub(cols));
EdgeCosts = sparse(rows,cols,grad,NumSites,NumSites);
tic;
[ST, pred] = graphminspantree(EdgeCosts, 'Method', 'Kruskal'); 
disp(['MST calculation in ' num2str(toc) 'seconds']);

[labelMats] = getLabelsFromMST(ST,NumSites,IgSub);

%perturb the graph
for ntreeCounter = 1:NumTrees
	gradOrig = grad;
	[pi,pj,pgrad] = find(gradOrig);
	uW = unique(pgrad);
	for i=1:length(uW)
	    nW(i) = sum(pgrad==uW(i));
	end
	dupvals = uW(find(nW>1));

	for i=1:length(dupvals)
	    [idx] = find(gradOrig==dupvals(i));
	    gradOrig(idx) = gradOrig(idx) + round(alpha*rand(length(idx),1));
	end
	pEdgeCosts = sparse(rows,cols,gradOrig,NumSites,NumSites);
	tic;
	[pST, ppred] = graphminspantree(pEdgeCosts, 'Method', 'Kruskal'); 
	disp(['Perturbed MST calculation in ' num2str(toc) 'seconds']);
	nTrees{ntreeCounter} = pST;
	[plabelMats] = getLabelsFromMST(pST,NumSites,IgSub);
	disp(['Number of levels in orignal MST = ' num2str(size(labelMats,3))]);
	disp(['Number of levels in perturbed MST = ' num2str(size(plabelMats,3))])
end