function [H] = InitializeSalMat(sal)
% label partitions from thresholding the saliency function
% B Ravi Kiran 8 December 2014
threshList = unique(sal);
threshList = threshList(2:end);
for i=1:length(threshList)
	partition = sal>=threshList(i);
	H(:,:,i) = bwlabel(~partition);
end
