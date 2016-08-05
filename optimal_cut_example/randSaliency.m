function [randSal] = randSaliency(sal)
%creates random hierarchy by randomly regrouping leaves to create a
%hierarchy represented by randSal
%B Ravi Kiran
uniqueSalVal = unique(sal);
uniqueSalVal = uniqueSalVal(uniqueSalVal>0);
randSal = zeros(size(sal));
tic
parfor i=1:length(uniqueSalVal)
    partition = sal>=uniqueSalVal(i);
    [Lsub] = getRandomNetOpening(partition);
    randSal = randSal + seg2bdry(Lsub);
end
% figure, imshow(label2rgb(randSal,'jet',[0.6 0.6 0.6]),[]); 
% disp(['Time Elapsed=' num2str(toc)]);
% disp(['Number of levels=' num2str(length(unique(randSal)))]);

