function [flatSal] = flattenSaliency(sal)
%flatten saliency 
%B Ravi Kiran
uniqueSalVal = unique(sal);
uniqueSalVal = uniqueSalVal(uniqueSalVal>0);
flatSal = zeros(size(sal));

for i=1:length(uniqueSalVal)
    flatSal = flatSal + 1*(sal>=uniqueSalVal(i));
end
