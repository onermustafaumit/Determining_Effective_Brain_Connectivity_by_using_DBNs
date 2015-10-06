function varargout=DBmcmc_RunMultiSimu(varargin)
% RunMultiSimu: Runs the simulation several times
% by making multiple calls of function RunSimu
%
% INPUT
% nSimu: number of simulations
% If this is the only input, the function reads 
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
% DBmcmc_RunSimu
%
% INVOCATION
% DBmcmc_RunMultiSimu(n)  or   DBmcmc_Results=RunMultiSimu(n)
% or
% DBmcmc_RunMultiSimu(n,mcmcPAR,dagPAR,dataPAR)
% or
% DBmcmc_Results=RunMultiSimu(n,mcmcPAR,dagPAR,dataPAR)
% where
% n is the number of simulations you want to run.

% --------------------------------------------------
% Input parameters
% --------------------------------------------------
nSimu=varargin{1};
if nargin==4
   mcmcPAR=varargin{2};
   dagPAR=varargin{3};
   dataPAR=varargin{4};
else
   load mcmcPAR.mat;
   load dagPAR.mat;
   load dataPAR.mat;
end

seed0=mcmcPAR.seed;
for n=1:nSimu
    mcmcPAR.seed=seed0+n-1;
    Results{n}=DBmcmc_RunSimu(mcmcPAR,dagPAR,dataPAR);
end

% --------------------------------------------------
%  Save results
% --------------------------------------------------
if nargout==0
   save Results.mat Results;
else
   varargout{1}=Results;
end





