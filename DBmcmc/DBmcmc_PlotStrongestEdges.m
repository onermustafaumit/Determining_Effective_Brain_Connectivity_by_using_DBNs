function varargout=DBmcmc_PlotStrongestEdges(varargin)
% DBmcmc_PlotStrongestEdges: Plots the network with the dominant edges
% This program reads in a DAG or INTER matrix, thresholds
% the edges, and either plots the resulting INTER matrix,
% or writes this matrix out to output.
% Thesholding can either be done by value, discarding all edges
% with posterior probability below that theshold, or by number,
% whereby only a specified number of leading edges is kept.
% You can also specify a number of spurious (unconnected)
% nodes, which are immediately discarded.
%
% INPUT
% 'dag'
% Input matrix as a DAG
% 'inter'
% Input matrix as an inter matrix of edges
% between adcent time slices
% 'threshold'
% Threshold; all edges with posterior probability
% below that threshold are discarded
% 'maxNumber'
% Keep the maximal maxNumber edges
% 'NredundantNodes'
% Number of redundant nodes that are immediately 
% discarded
% The last parameer is optional, and you need to 
% specify one and only one parameter of the parameter
% pairs (dag,inter) and (threshold,maxNumber)
%
% OUTPUT
% Optional argument: thresholded inter matrix;
% all redundant nodes have been discarded.
%
% EXAMPLES
% DBmcmc_PlotStrongestEdges('inter',inter,'maxNumber',11)
%    Shows the 11 leading edges
% DBmcmc_PlotStrongestEdges('inter',inter,'threshold',0.9)
%    Shows all edges with posterior probability >= 0.9
% DBmcmc_PlotStrongestEdges('inter',inter,'maxNumber',11,'NredundantNodes',40)
% Discards 40 redundant nodes, assuming that the relevant nodes
% are in the top left corner of the inter matrix

% --> Defaults
flag_dag=0;
flag_inter=0;
flag_threshold=0;
flag_maxNumber=0;
flag_redundantNodes=0;
NredundantNodes=0;

% --> Input parameters
for i=1:2:length(varargin)
switch varargin{i} 
   case 'dag'
        dag= varargin{i+1};
        inter= DBmcmc_dag2inter(dag);
        flag_dag=1;
   case 'inter'
        inter= varargin{i+1};
        flag_inter=1;
   case 'NredundantNodes'
        NredundantNodes= varargin{i+1};
        flag_redundantNodes=1;
   case 'threshold'
        threshold= varargin{i+1};
        flag_threshold=1;
   case 'maxNumber'
        maxNumber= varargin{i+1};
        flag_maxNumber=1;
   otherwise
        error('Invalid argument'); 
   end
end

% --> Error checking
assert(flag_dag~=flag_inter);
assert(flag_dag+flag_inter>0);
assert(flag_threshold~=flag_maxNumber);
assert(flag_threshold+flag_maxNumber>0);
[M,N]=size(inter);
assert(M==N);
assert(NredundantNodes>=0);
assert(NredundantNodes<N);
if flag_maxNumber
   assert(maxNumber<N^2);
end

% --> Optional: remove redundant nodes
if flag_redundantNodes
   Nrelevant= N-NredundantNodes;
   interNew=inter(1:Nrelevant,1:Nrelevant);
   clear inter;
   inter=interNew;
   clear interNew;
   N= Nrelevant;
end

% --> Optional: Compute threshold from maxNumber
if flag_maxNumber
   X=inter(:);
   X=sort(X);
   threshold=X(N^2-maxNumber);
end

% --> Thresholding
interThresholded= (inter>threshold);

% --> Output or plot the result
if nargout>0
   varargout{1}=interThresholded;
else
   clf
   draw_layout(interThresholded); 
end

