function [] = viewStack(H)
% view hierarchy/stack of partitions 
% input hierarchy does not consist of the root partition with single class
% B Ravi Kiran 8 December 2014
pile = [];
for i=1:size(H,3)
	pile = [pile label2rgb(H(:,:,i),'jet')];
end
figure, imshow(pile,[]); drawnow;
