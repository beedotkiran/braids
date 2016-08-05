function [subSal] = subsampleSaliency(sal,n)
%Ravi Kiran ESIEE A3SI, Feb 21 2013
%function calculates the new subsampled saliency map choosing every
%n partitions from the saliency
list = unique(sal);
list = list (2:end);
subSal = zeros(size(sal));
for i=1:n:length(list)/2
    thresh = (sal>=list(end - (i)));
    subSal = subSal + thresh;       
end

for i=length(list)/2+1:2*n:length(list)
    thresh = (sal>=list(end - (i)));
    subSal = subSal + thresh;       
end
