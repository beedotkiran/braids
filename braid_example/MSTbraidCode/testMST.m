W = [.41 .29 .41 .32 .50 .45 .38 .32 .36 .29 .21];
Worig = W;
uW = unique(W);
for i=1:length(uW)
    nW(i) = sum(W==uW(i));
end
dupvals = uW(find(nW>1));
for i=1:length(dupvals)
    idx = find(W==dupvals(i));
    W(idx) = W(idx) + rand(1,length(idx))*0.01;
end

DG = sparse([1 1 2 2 3 4 4 5 5 6 6],[2 6 3 5 4 1 6 3 4 2 5],Worig);
UG = tril(DG + DG');
[ST,pred] = graphminspantree(UG);
view(biograph(ST))
DG = sparse([1 1 2 2 3 4 4 5 5 6 6],[2 6 3 5 4 1 6 3 4 2 5],W);
UG = tril(DG + DG');
[ST,pred] = graphminspantree(UG);
view(biograph(ST))