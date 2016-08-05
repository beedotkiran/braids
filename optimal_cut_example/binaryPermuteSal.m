function [Lnew] = binaryPermuteSal(LpMat, LcMat,numPts)
%function permutes contours of child partition within each parent label in LpMat
%B Ravi Kiran

pLabels = unique(LpMat);
pLabels = pLabels(pLabels>0);
childPartition = LcMat==0;
LnewVec = childPartition(:);
numPts = 3;
for i=1:length(pLabels)
    parentMat = LpMat == pLabels(i);
    childMat = childPartition.*parentMat;
    childMatVec = childMat(:);
    if(unique(childMatVec)==0)
        continue; 
    end
    onesIdx = find(childMatVec);
    randIdx = randi(length(onesIdx),numPts);
    randZeroIdx = onesIdx(randIdx);
    LnewVec(randZeroIdx) = 0; 
end
    
LnewMat = bwlabel(~reshape(LnewVec,size(LpMat,1),size(LpMat,2)));
Lnew = LnewMat(2:2:end, 2:2:end);

