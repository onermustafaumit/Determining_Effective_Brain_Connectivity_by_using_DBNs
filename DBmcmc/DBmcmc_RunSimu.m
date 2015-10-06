function varargout=DBmcmc_RunSimu(varargin)
% RunSimu: Runs the whole analysis
%
% INPUT
% In the case of no input, the function reads 
% in the parameters from the structure files
% mcmcPAR.mat, dagPAR.mat, and dataPAR.mat
% Alternatively, these parameter structures can
% also be passed to the function as arguments
%
% OUTPUT
% If an output argument is specified, the results
% will be written out to it.
% Otherwise, they will be saved to file.
%
% FUNCTION CALLS
% DBmcmc_MakeDAG, DBmcmc_SampleData,
% DBmcmc_RunMCMC, DBmcmc_AnalyzeMCMC,
% DBmcmc_PlotResult [optional]
%
% INVOCATION
% DBmcmc_RunSimu  or  DBmcmc_Results=RunSimu
% or
% DBmcmc_RunSimu(mcmcPAR,dagPAR,dataPAR)
% or
% DBmcmc_Results=RunSimu(mcmcPAR,dagPAR,dataPAR)

% --------------------------------------------------
% Input parameters
% --------------------------------------------------
if nargin==3
   mcmcPAR=varargin{1};
   dagPAR=varargin{2};
   dataPAR=varargin{3};
else
   load mcmcPAR.mat;
   load dagPAR.mat;
   load dataPAR.mat;
end
rand('state',mcmcPAR.seed);
randn('state',mcmcPAR.seed);

% --------------------------------------------------
% Make true DAG
% --------------------------------------------------
bnet_true= DBmcmc_MakeDAG(dagPAR);

% --------------------------------------------------
% Sample data from the true network
% --------------------------------------------------
data=  DBmcmc_SampleData(bnet_true,dataPAR.nData);

% --------------------------------------------------
% MCMC learning
% --------------------------------------------------
disp('I start the MCMC simulation ...')
[INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,bnet_true.node_sizes,mcmcPAR);

% --------------------------------------------------
% Analysis
% --------------------------------------------------
[PtrueEdges,PfalseEdges,nodeConnectivityPredicted,nodeConnectivityThreshPredicted,nodeConnectivityTrue]= DBmcmc_AnalyzeMCMC(INTERposterior,bnet_true);

% --------------------------------------------------
%  Save results
% --------------------------------------------------
Results.INTERposterior=INTERposterior;
Results.PtrueEdges=PtrueEdges;
Results.PfalseEdges=PfalseEdges;
Results.nodeConnectivityPredicted=nodeConnectivityPredicted;
Results.nodeConnectivityThreshPredicted=nodeConnectivityThreshPredicted;
Results.nodeConnectivityTrue=nodeConnectivityTrue;
Results.t_sampled=t_sampled;
Results.num_edges=num_edges;
Results.accept_ratio=accept_ratio;
if nargout==0
   save Results.mat Results;
else
   varargout{1}=Results;
end

% --------------------------------------------------
%  Plot results
% --------------------------------------------------
% DBmcmc_PlotResults(t_sampled,accept_ratio,num_edges,INTERposterior,bnet_true.dag);




