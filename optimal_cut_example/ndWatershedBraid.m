function [Wmats] = ndWatershedBraid(I)

% I = imresize(I,2);
numDim = size(I,3);
dimMinimaMats = zeros(size(I,1), size(I,2));
sumI = zeros(size(I,1), size(I,2));
Wmats = zeros(size(I,1), size(I,2));
for i=1:numDim
    dimMinimaMats(:,:,i) = imregionalmin(I(:,:,i));
    sumI = sumI + double(I(:,:,i));
end

for i=1:numDim
    Wmats(:,:,i) = watershed(imimposemin(sumI,dimMinimaMats(:,:,i)));
    imwrite(Wmats(:,:,i)==0, ['wshed' num2str(i) '.png']);
end