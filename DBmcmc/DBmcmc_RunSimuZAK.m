function varargout=DBmcmc_RunSimuZAK(mcmcPAR,flag_redundantNodes)
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
rand('state',mcmcPAR.seed);
randn('state',mcmcPAR.seed);

% --------------------------------------------------
% Make_data
% --------------------------------------------------
if flag_redundantNodes
   [data,INTERtrue]=DBmcmc_DataZak('NredundantNodes',40);
   Nnodes=50; 
else
   [data,INTERtrue]=DBmcmc_DataZak;
   Nnodes=10;
end
NodeSizes=3*ones(2*Nnodes,1);

% --------------------------------------------------
% MCMC learning
% --------------------------------------------------
disp('I start the MCMC simulation ...')
[INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,NodeSizes,mcmcPAR);

% --------------------------------------------------
%  Save results
% --------------------------------------------------
Results.INTERposterior=INTERposterior;
Results.t_sampled=t_sampled;
Results.num_edges=num_edges;
if nargout==0
   save Results.mat Results;
else
   varargout{1}=Results;
end

% --------------------------------------------------
%  Plot results
% --------------------------------------------------
% DBmcmc_PlotResults(t_sampled,accept_ratio,num_edges,INTERposterior,bnet_true.dag);




