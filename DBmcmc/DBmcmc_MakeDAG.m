function bnet=DBmcmc_MakeDAG(varargin)
% MakeDAG: Make a DAG of known structure, initialize the parameters
%
% INPUT
% Structure with the following fields:
% nodeSize
% flag_quasi_deterministic 
%   If set to 1, the parameters of the network are all
%   set to either 0.9 or 0.1, with two edges feeding
%   child node modelling a noisy XOR.
%   Use only with a limit on the feed-in of 2
%   Default value= 0, in which case all the 
%   parameters are set at random.
% N_redundantNodes
%   Number of redundant nodes, that is, nodes 
%   that are isolated without any edges. 
%
% INVOCATION
% bnet=DBmcmc_MakeDAG
% OR
% bnet=DBmcmc_MakeDAG(dagPAR)

if nargin>=1
   dagPAR= varargin{1};
else
   dagPAR=DBmcmc_SetParDAG;
end

nodeSize=dagPAR.nodeSize;
flag_quasi_deterministic=dagPAR.flag_quasi_deterministic;
N_redundantNodes=dagPAR.N_redundantNodes;

if flag_quasi_deterministic & nodeSize>2
   error('Quasi deterministic setting currently only possible for nodeSize=2');
end


% --------------------------------------------------
% Make true architectur
% --------------------------------------------------

RNR3=1;
CLN1=2;
SRO4=3;
RAD51=4;
CLB2=5;
MYO1=6;
ACE2=7;
ALK1=8;
MNN1=9;
CLN2=10;
SVS1=11;
CDC5=12;

Names={'RNR3','CLN1','SRO4','RAD51','CLB2','MYO1','ACE2','ALK1','MNN1','CLN2','SVS1','CDC5'};

nNodes=12+N_redundantNodes;
inter= zeros(nNodes,nNodes);

inter(CLN2,[RNR3,CLN1,SRO4,RAD51,SVS1])=1;
inter(SVS1,MNN1)=1;
inter(ACE2,CDC5)=1;
inter(CDC5,[SVS1,CLB2,MYO1,ALK1])=1;

dag= DBmcmc_inter2dag(inter);

nNodes=2*nNodes; 
    % because a dynamic Bayesian network requires
    % dublicating the nodes

discrete_nodes=1:nNodes;
observed_nodes=1:nNodes;
node_sizes= nodeSize*ones(1,nNodes);

bnet= mk_bnet(dag,node_sizes,'names',Names,'discrete',discrete_nodes,'observed',observed_nodes);

% --------------------------------------------------
% Make parameters
% --------------------------------------------------

for node=1:nNodes
    ns=node_sizes(node);
    ps=parents(dag,node);
    psz= prod(node_sizes(ps));
    CPT= sample_dirichlet(ones(1,ns),psz);
    % bnet.CPD{node}=tabular_CPD(bnet,node,'CPT',CPT);
    bnet.CPD{node}=tabular_CPD(bnet,node);
end

if flag_quasi_deterministic & nodeSize==2
   for node=1:nNodes
       if sum(bnet.dag(:,node))==2
          bnet.CPD{node} = tabular_CPD(bnet, node, 'CPT', [0.9 0.1 0.1 0.9 0.1 0.9 0.9 0.1]);
       elseif sum(bnet.dag(:,node))==1
          bnet.CPD{node} = tabular_CPD(bnet, node, 'CPT', [0.1 0.9 0.9 0.1]);
       else
          bnet.CPD{node} = tabular_CPD(bnet, node, 'CPT', [0.1 0.9]);
       end
   end
end
