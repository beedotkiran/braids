clear
clc
alphaVec = 0:0.1:1;
parfor a=1:length(alphaVec)
    edgeChangeCount = 0;
    labelChangeCount = 0;
    for i=1:10
        [eC, lC] = imageMSTtest(alphaVec(a));
        edgeChangeCount = edgeChangeCount + eC;
        labelChangeCount = labelChangeCount + lC;
    end
edgeChangeCountVec(a) = edgeChangeCount/10;
labelChangeCountVec(a) = labelChangeCount/10;
end
figure
plot(edgeChangeCountVec);
hold on
plot(labelChangeCountVec, 'r');