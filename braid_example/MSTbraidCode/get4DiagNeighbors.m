function [N] = get4DiagNeighbors(i, r, c)
%%%%%%%%%%%%%%%%%%%%
% getNeighbors.m
% For a given site i=(x,y), get the four diagonal neighbors
%%%%%%%%%%%%%%%%%%%%
    [ir ic] = ind2sub([r,c], i);
    N = [];
    if ((ir < r)&&(ic > 1)), N=[N; i-r+1]; end
    if ((ir < r)&&(ic < c)), N=[N; i+r+1]; end  
    if ((ir > 1)&&(ic > 1)), N=[N; i-r-1]; end
    if ((ir > 1)&&(ic < c)), N=[N; i+r-1]; end    
end
