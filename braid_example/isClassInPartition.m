function [LFlag, Llabels]  = isClassInPartition(classMat, L)
%function returns a binary flag based on the presence of subset of pixels in labelled partition L
%Author B Ravi Kiran April 2014

L = L(:);
classMat = classMat(:);
labelList = unique(L);
LFlag = 0;

for i=i:length(labelList)
	labelMat = L == labelList(i);
	LFlag = labelMat == classMat;
end




