N = 3; M = 3;                  %# grid size
CONNECTED = 8;                 %# 4-/8- connected points

%# which distance function
if CONNECTED == 4,     distFunc = 'cityblock';
elseif CONNECTED == 8, distFunc = 'chebychev'; end

%# compute adjacency matrix
[X Y] = meshgrid(1:N,1:M);
X = X(:); Y = Y(:);
adj = squareform( pdist([X Y], distFunc) == 1 );

%# plot adjacency matrix
subplot(121), spy(adj)

%# plot connected points on grid
[xx yy] = gplot(adj, [X Y]);
subplot(122), plot(xx, yy, 'ks-', 'MarkerFaceColor','r')
axis([0 N+1 0 M+1])
%# add labels
[X Y] = meshgrid(1:N,1:M);
X = reshape(X',[],1) + 0.1; Y = reshape(Y',[],1) + 0.1;
text(X, Y(end:-1:1), cellstr(num2str((1:N*M)')) )