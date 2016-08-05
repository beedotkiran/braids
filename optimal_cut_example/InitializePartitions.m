function [Hnew] = InitializePartitions(H, dealmode)
% function deals partitions from modes: 1. a hierarchy in order 2. a hierarchy out of ordere 3. a Braid
% input hierarchy does not consist of the root partition with single class
% B Ravi Kiran 8 December 2014
switch dealmode
	case 1
		Hnew = H;
	case 2
		randIndexList = randperm(size(H,3));
		Hnew = zeros(size(H));
		for i=1:length(randIndexList)
			Hnew(:,:,randIndexList(i)) = H(:,:,i);
		end
	otherwise
		disp('To be implemented');
end