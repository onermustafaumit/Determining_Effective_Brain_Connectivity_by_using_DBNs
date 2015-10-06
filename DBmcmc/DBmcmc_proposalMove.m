function varargout=DBmcmc_proposalMove(varargin)
% DBmcmc_proposalMove: Proposal move for MCMC
% There are two operation modes. If the input argument
% contains only one varaiable, dag, then the proposal 
% moves are unrestricted. An edge is either added or 
% deleted. The number of dags in the neighbourhood of the 
% specified dags is N^2 - E + E = N^2, where N is the number
% of nodes and E the number of edges. This expression is 
% the same for the forward and the backward move, so the 
% Hastings ratio is equal one. A maximum fan-in has to 
% be imposed via the prior.
% Alternatively, the fan-in can be imposed by the
% proposal move, where moves violating the restriction 
% on the feed-in are immediately discarded.
% This makes the computation of the Hastings ratio slightly
% more involved. In this case, use the function 
% DBmcmc_size_nbrs_of_dag to compute the number of graphs
% in the neighbourhood of the specified graph, and from
% this the Hastings ratio.
% The first alternative is simpler, and I recommend using
% using it rather than the second alternative.
%
% INPUT
% dag: current dag
% maxFanIn: maximum fan-in [optional]
%
% OUTPUT
% dag_new: proposed new dag
% operation: string indicating the operation: delete or add
% nodes: affected nodes, that is, pair of nodes where either
%        an edge has been deleted or created.
%
% INVOCATION
% [dag_new,nodes,operation]=DBmcmc_proposalMove(dag)
% OR (better don't use this:)
% [dag_new,nodes,operation]=DBmcmc_proposalMove(dag,maxFanIn)

dag=varargin{1};
inter=DBmcmc_dag2inter(dag);

if nargin>=2
   flag_maxFanIn=1;
   maxFanIn=varargin{2};
else
   flag_maxFanIn=0;
end

if ~flag_maxFanIn
   N_nodes=size(inter,1);
   i=ceil(N_nodes*rand);
   j=ceil(N_nodes*rand);
   nodes=[i j];
   % Now just flip the edge state: 
   % Delete an existing edge, or introduce a new edge
   inter(i,j)= ~inter(i,j);
end

dag_new=DBmcmc_inter2dag(inter);

varargout{1}=dag_new;
nodes(2)=nodes(2)+N_nodes;
     % Recall that when transforming INTER-->DAG,
     % target nodes have to be shifted by + N_nodes,
     % while source nodes reamin unchanged.   
varargout{2}=nodes;

if inter(i,j)
   operation='add';
else
   operation='del';
end
varargout{3}=operation;










% -----------------------------------------------------------
if flag_maxFanIn

error('Check this part of the code before using this option')

% Compute number of dags in the neighbourhood 
N_nbrs= DBmcmc_size_nbrs_of_dag(dag,maxFanIn);
% Integer random number in {1,2,...,N_nbrs}
n_move= ceil(N_nbrs*rand); 

% Indices of edges
[I,J] = find(inter);
% Number of edges
N_edges=length(I);

if n_move<=N_edges
   % Deletion of an edge 
   i = I(n_move); j = J(n_move);
   inter_new = inter;
   inter_new(i,j) = 0;
   operation = 'del';
   nodes = [i j];
else
   % Addition of an edge
   operation = 'add';
   [I,J] = find(~inter);
   if ~flag_maxFanIn
       % No restriction on the fan-in
       n_move= n_move-N_edges;
       i = I(n_move);
       j = J(n_move);
       nodes = [i j];
       inter_new = inter;
       inter_new(i,j) = 1;
   else
      % Restricted fan-in
      nnbrs= N_edges;
      % Loop over all possible edge additions and discard those
      % that are not permissible.
      e=0;
      while nnbrs~=n_move & e<=length(I)
          e=e+1;
          i = I(e); j = J(e);
          nodes = [i j];
          inter_new = inter;
          inter_new(i,j) = 1;
          if sum(inter_new(:,j)) <= maxFanIn
             % restrict the maximum fan-in
             nnbrs = nnbrs + 1;
          end
      end
   end
end

dag_new=DBmcmc_inter2dag(inter_new);

varargout{1}=dag_new;
varargout{2}=nodes;
varargout{3}=operation;

end  % if flag_MaxFanIn
% -----------------------------------------------------------


