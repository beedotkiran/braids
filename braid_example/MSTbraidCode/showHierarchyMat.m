function [] = showHierarchyMat(labelMat)

for i=1:size(labelMats,3)
    figure, imshow(imresize(labelMats(:,:,i),32,'nearest'),[]); colormap(jet); drawnow;
end