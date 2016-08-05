function [H] = InitializeHierarchy(sal)
% label partitions from thresholding the saliency function
% input hierarchy does not consist of the root partition with single class
% B Ravi Kiran 8 December 2014
threshList = unique(sal);
threshList = threshList(2:end);
for i=1:length(threshList)
	partition = sal>=threshList(i);
	L = bwlabel(~partition);
	H(:,:,i) = L(2:2:end, 2:2:end); %subsample to get labels
end
