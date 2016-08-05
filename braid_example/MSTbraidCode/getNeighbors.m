function [N] = getNeighbors(i, r, c)
% getNeighbors.m
% For a pixel i=(x,y), get the four neighbors
% B Ravi Kiran

    [ir ic] = ind2sub([r,c], i);
    N = [];
    if ir < r, N=[N; i+1]; end
    if ir > 1, N=[N; i-1]; end  
    if ic < c, N=[N; i+r]; end
    if ic > 1, N=[N; i-r]; end    
end
