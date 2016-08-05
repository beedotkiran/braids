function [G] = InitializeGraph(MaxLabels)
% Function buils the graph with vertices corresponding to the different
% classes in the Family of partitions F with a total number of labels MaxLabels.
% The graph is implmented by asymmetric sparse matrix representing the DAG
% Author B Ravi Kiran April 2014

G = sparse(MaxLabels, MaxLabels);

% other implementations can be introduced based on the method of extraction of the optimal cuts.


