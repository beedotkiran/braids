function [N] = get8Neighbors(i, r, c)
%%%%%%%%%%%%%%%%%%%%
% getNeighbors.m
% For a given site i=(x,y), get the four neighbors
%%%%%%%%%%%%%%%%%%%%
    [ir ic] = ind2sub([r,c], i);
    N = [];
    if ir < r, N=[N; i+1]; end
    if ir > 1, N=[N; i-1]; end  
    if ic < c, N=[N; i+r; i+r-1; i+r+1]; end
    if ic > 1, N=[N; i-r; i-r-1; i-r+1]; end    
end
