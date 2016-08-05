function [weight] = initNeighbors(r,c,connectivity)
% initNeighbors.m
% make sparse adjacency matrix 'weight' for 4/8 connecitivty
% NxN matrix holding binary cost for now
% B Ravi Kiran

%load N8matrix
%return

%     r = size(I,1); c = size(I,2); 
    N = r*c;
%     
%     if(r==481)&&(c==321)&&(connectivity==8)
%          load N8matrix-481x321
%          return;
%     end
%     
%     if(r==481)&&(c==321)&&(connectivity==4)
%          load N4matrix-481x321
%          return;
%     end
    
    
    weight = sparse(N, N);
    diagWeight = sqrt(2);
    
    if(connectivity==4)
        for i=1:N
            j = getNeighbors(i, r, c); %neighbors{i};
            weight(i, j) = 1;
        end
    else %8 connectivity
        for i=1:N
            j = getNeighbors(i, r, c); %neighbors{i};
            weight(i, j) = 1;
            k = get4DiagNeighbors(i, r, c); %neighbors{i};
            weight(i, k) = diagWeight;
        end
    end
end


