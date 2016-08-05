function [Lsub] = getRandomNetOpening(partition)
    partitionVec = partition(:);
    onesIdx = find(partitionVec);
    randIdx = randi(length(onesIdx),1);
    randZeroIdx = onesIdx(randIdx);
    partitionVec(randZeroIdx) = 0;
    L = bwlabel(~reshape(partitionVec,size(partition,1),size(partition,2)));
    Lsub = L(2:2:end, 2:2:end);