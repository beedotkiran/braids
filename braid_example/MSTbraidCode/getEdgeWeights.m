function [EdgeCosts] = getEdgeWeights(I, weight)

%Internal Parameters
imageMaxVal = 255; 
Ir = I(:,:,1); Irvec = double(Ir(:)); Irnvec = Irvec/imageMaxVal;
Ig = I(:,:,2); Igvec = double(Ig(:)); Ignvec = Igvec/imageMaxVal;
Ib = I(:,:,3); Ibvec = double(Ib(:)); Ibnvec = Ibvec/imageMaxVal;
I = rgb2gray(I); Ivec = double(I(:)); Invec = Ivec/imageMaxVal;
N = length(Ibvec);
[rows, cols] = find(weight);

%grad = (Irnvec(rows)-Irnvec(cols)).^2 + (Ignvec(rows)-Ignvec(cols)).^2 + (Ibnvec(rows)-Ibnvec(cols)).^2;
grad = (Invec(rows)-Invec(cols)).^2;
costVec = grad; %alpha + exp(-grad/3);
EdgeCosts = sparse(rows,cols,costVec,N,N);