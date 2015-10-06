function N_nbrs= DBmcmc_size_nbrs_of_dag(varargin)
% DBmcmc_size_nbrs_of_dag: Computes the size of the neighbourhood
% of a specified DAG.
% This is the number of DAGs that can be obtained by deletion
% or addition of an arc, computed as follows:
% N: total number of nodes
% S: saturated target nodes, that have already reached 
%    the maximum fan-in
% E: number of edges
% I: maximum permissible fan-in
% Number of eges that can be removed: E
% Number of edges that can be added when source nodes are  
%    not saturated: N(N-S)-(E-SI)
% Total number of permissible operations:
% N(N-S)-(E-SI)+E= N^2-S(N-I)
% Node: This function call is needed for computing the 
% Hastings ratio.
%
% INPUT
% dag: a DAG, to be internally transformed into INTER
% maxFanIn: maximum fan-in per node [optional]
% The optional parameter must be preceeded by their respective keyword.
%
% OUTPUT
% N_nbrs: number of DAGS in the neighbourhood of the
%         specified DAG.
%
% INVOCATION (examples)
% N_nbrs= DBmcmc_size_nbrs_of_dag(dag)
% OR
% N_nbrs= DBmcmc_size_nbrs_of_dag(dag,'maxFanIn',maxFanIn)

dag= varargin{1};
maxFanIn=0; 
for i=2:2:nargs
    switch varargin{i},
        case 'maxFanIn'
             maxFanIn = varargin{i+1};
        case 'maxNodeFanOut'
             maxNodeFanOut = varargin{i+1};
             % Obsolete: no longer used
        otherwise 
	     error('Wrong argument, possibly a mistyped keyword'); 
     end
end

inter=DBmcmc_dag2inter(dag);
N= size(inter,1);
N_saturatedNodes=sum(sum(inter,1)>=maxFanIn);

N_nbrs= N^2-N_saturatedNodes*(N-maxFanIn);
