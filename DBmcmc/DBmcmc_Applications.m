function varargout=DBmcmc_Application(varargin)
% DBmcmc_Application: Application of DBmcmc
%
% INPUT
% 'data', dataIN: 
% Data matrix, where rows are genes and columns 
% are time points: Size= Ngenes*Ndata
% The data must either be binary (range: 0,1)
% or ternary (range: -1,0,1)
% To specify more than oine data set, give this
% command repeatedly.
% All the other inputs are optional, and have to 
% be preceeded by the respective keyword.
% 'flag_binary', flag_binary
% flag_binary==1 --> binary, otherwise (and default) ternary
% 'NredundantNodes' --> number or redundant nodes (default==0)
% 'mcmcPAR'
% Parameter structure to control MCMC simulation.
% If this argument is not specified, the function
% will read in mcmcPAR.mat from the current directory.
% 'nSimu'
% Number of MCMC simulations
%
% OUTPUT
% If an output argument is specified, the results
% will be written out to it.
% Otherwise, the results will be saved to file
% Results.mat
%
% FUNCTION CALLS
 % DBmcmc_DataReadIn, DBmcmc_RunMCMC,
% DBmcmc_PlotResult [optional]
%
% EXAMPLES
% DBmcmc_Application('data',dataIN)
%     Input data: dataIN
% DBmcmc_Application('data',dataIN1,'data',dataIn2)
%      Concatenates two input data sets.
% DBmcmc_Application('data',dataIN,'nSimu',3)
%     Repeat the simulation three times
% DBmcmc_Application('data',dataIN,'NredundantNodes',40)
%     40 extra redundant, unconnected nodes will be created.
% DBmcmc_Application('data',dataIN,'NredundantNodes',40,...
%                        'flag_binary',1)
%     Nodes are binary rahter than ternary
%

% --------------------------------------------------
% Defaults
% --------------------------------------------------
mcmcPAR=0;
dagPAR=0;
dataPAR=0;
flag_binary=0;
NredundantNodes=0;
nSimu=1;

% --------------------------------------------------
% Input parameters 
% --------------------------------------------------
N_dataSets=0;
nargs = length(varargin);
for i=1:2:nargs
   switch varargin{i},
      case 'data'
            N_dataSets=N_dataSets+1;
            dataIN{N_dataSets}=varargin{i+1};
      case 'NredundantNodes'
            NredundantNodes = varargin{i+1};
      case 'flag_binary'
            flag_binary= varargin{i+1};
      case 'mcmcPAR'
            mcmcPAR= varargin{i+1};
      case 'nSimu'
            nSimu= varargin{i+1};
      otherwise
            error('Wrong argument, possibly a mistyped keyword'); 
   end
end

% --------------------------------------------------
% Input parameters
% --------------------------------------------------
if mcmcPAR==0
   load mcmcPAR.mat;
end

% --------------------------------------------------
% Read in and transform data
% --------------------------------------------------

% Sorry, the following code fragment is embarassingly unwieldy,
% but I cannot be bothered spending any more time on this
% program.

if N_dataSets==1
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==2
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==3
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==4
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==5
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==6
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'data',dataIN{6},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'data',dataIN{6},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==7
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'data',dataIN{6},...
        'data',dataIN{7},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'data',dataIN{6},...
        'data',dataIN{7},...
        'flag_binary',flag_binary);
end
end

if N_dataSets==8
if NredundantNodes>0 
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'data',dataIN{6},...
        'data',dataIN{7},...
        'data',dataIN{8},...
        'NredundantNodes',NredundantNodes,...
        'flag_binary',flag_binary);
else
   [data,nodeSizes]=DBmcmc_DataReadIn('data',dataIN{1},...
        'data',dataIN{2},...
        'data',dataIN{3},...
        'data',dataIN{4},...
        'data',dataIN{5},...
        'data',dataIN{6},...
        'data',dataIN{7},...
        'data',dataIN{8},...
        'flag_binary',flag_binary);
end
end

if N_dataSets>8
   error('I cannot deal with more than eight data sets.')
end


% --------------------------------------------------
% MCMC learning simulations, optionally repeated
% --------------------------------------------------

seed0=mcmcPAR.seed;
for n=1:nSimu
    mcmcPAR.seed=seed0+n-1;
    rand('state',mcmcPAR.seed);
    randn('state',mcmcPAR.seed);

    % --------------------------------------------------
    % MCMC learning
    % --------------------------------------------------
    disp('I start the MCMC simulation ...')
    [INTERposterior, sampled_graphs, accept_ratio, ...
     num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);

    % --------------------------------------------------
    %  Store results
    % --------------------------------------------------
    Results{n}.INTERposterior=INTERposterior;
    Results{n}.t_sampled=t_sampled;
    Results{n}.num_edges=num_edges;
    Results{n}.accept_ratio=accept_ratio;
end

% --------------------------------------------------
%  Save or output results
% --------------------------------------------------
if nargout==0
   save Results.mat Results;
else
   varargout{1}=Results;
end


% --------------------------------------------------
%  Plot results
% --------------------------------------------------
DBmcmc_PlotResults(t_sampled,accept_ratio,num_edges,INTERposterior,bnet_true.dag);
DBmcmc_EdgesOverThresh(Results);



