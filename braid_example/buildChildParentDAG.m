function [G] = buildChildParentDAG(Flabelled)
%Pricinple function that builds the DAG across the input family of partitions Flabelled
%Author B Ravi Kiran April 2014

% buildChildParentDAG(Flabelled(:,:,1:n) = <L1, L2, ... Ln>) function builds the inclusion and intersection relation as a directed graph and undirected graph respectively
% each partition Li has label sets that are not necessarily contiguous
% output: Tree structure with directed edges between parents and their children, non-directed edges between intersecting partial partitions with no inclusion relation


%Intialize first partition in the graph as the parent partition and grow the graph 
%but progressively adding new child by climbing down the parent-child chain

%create graph
MaxLabels = max(Flabelled(:));
G = InitializeGraph(MaxLabels);
G = addLeaves(unique(Flabelled(:,:,1)),G); %call to add the first partition as leaves
%add parent or child relations starting from partition 2 to partition n st starting implictly on the partition 1
%This step updates the parent, child, braid relation by adding directed edges on the intialized graph $G$.
for partitionIdx = 2:n
	% Update the parent child relation increamentally based on incoming partition from the family F
	G = updateParentChildRelations(partitionIdx, Flabelled, G);
	% calculate the supremum between incoming partition and provisional leaves in G.
end

