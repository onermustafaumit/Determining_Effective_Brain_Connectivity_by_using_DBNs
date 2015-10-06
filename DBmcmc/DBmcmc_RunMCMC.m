function [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]=DBmcmc_RunMCMC(varargin)
% RunMCMC: Runs the MCMC simulation
%
% INPUT
% data: training data
% node_sizes: vector of node sizes
% mcmcPAR [optional]:  structure with all the parameters
% If the last argument is left out, the parameters will be set interactively.
%
% OUTPUT
% t_sampled are the sampled time points of the MCMC trajectory
% (useful to have for plotting the trajectories). 
% INTERposterior is the average INTER averaged over the sampling phase
% (Recall: INTER is obtained from the respective DAG 
%  with the command DBmcmc_dag2inter.)
% The remaining arguments are self-explanatory
%
% FUNCTION CALLS
% DBmcmc_learn_struct_mcmc
%
% INVOCATION
% [sampled_graphs, accept_ratio, num_edges, t_sampled]=DBmcmc_RunMCMC(data,node_sizes)
% OR
% [sampled_graphs, accept_ratio, num_edges, t_sampled]=DBmcmc_RunMCMC(data,node_sizes,mcmcPAR)

% --------------------------------------------------
%    Input parameters
% --------------------------------------------------

data= varargin{1};
node_sizes= varargin{2};

if nargin<=2
   mcmcPAR=SetPar;
else
   mcmcPAR= varargin{3};
end

seed= mcmcPAR.seed;
nBurnIn= mcmcPAR.nBurnIn;
nSample= mcmcPAR.nSample;
nDelta= mcmcPAR.nDelta;
maxFanIn=mcmcPAR.maxFanIn;
EmaxNodeFanOut=mcmcPAR.EmaxNodeFanOut;

if nDelta>1
   nSampleEff=1+floor(nSample/nDelta);
else
   nSampleEff=nSample;
end

%rand('state',seed);
%randn('state',seed);

% --------------------------------------------------
%    MCMC
% --------------------------------------------------

if maxFanIn>0
   % Restriction on the fan-in
   [sampled_graphs, accept_ratio, num_edges, t_sampled] = DBmcmc_learn_struct_mcmc(data, node_sizes, 'burnin', nBurnIn, 'nsamples', nSample, 'delta_samples',nDelta,'EmaxNodeFanOut',EmaxNodeFanOut,'maxFanIn',maxFanIn);
else
   % No restriction on the fan-in
   [sampled_graphs, accept_ratio, num_edges, t_sampled] = DBmcmc_learn_struct_mcmc(data, node_sizes, 'burnin', nBurnIn, 'nsamples', nSample, 'delta_samples',nDelta,'EmaxNodeFanOut',EmaxNodeFanOut);
end

% ----------------------------------------------------
%    Averaged DAG, where the elements of the matrix
%    give the posterior probabilities of the edges
% ----------------------------------------------------

nSampleEff= length(sampled_graphs);
nNodes= size(sampled_graphs{1},1);
INTERposterior= zeros(nNodes);

for i=1:nSampleEff
    INTERposterior=INTERposterior+sampled_graphs{i};
end

INTERposterior= INTERposterior./nSampleEff;
