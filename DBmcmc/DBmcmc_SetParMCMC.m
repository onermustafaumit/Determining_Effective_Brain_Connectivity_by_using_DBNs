function mcmcPAR=DBmcmc_SetParMCMC
% SetPar: Sets parameters for the MCMC simulation
% and writea them out to structure mcmcPAR
%
% OUTPUT
% mcmcPAR: Structure with all the parameters
%
% INVOCATION
% mcmcPAR=DBmcmc_SetParMCMC

mcmcPAR.seed= input('Random number seed?');
mcmcPAR.nBurnIn=input('Type in the length of the burn-in phase');
mcmcPAR.nSample=input('Type in the length of the sampling phase.');
mcmcPAR.nDelta=input('Type in the length of the interval between consecutive samples.');
mcmcPAR.maxFanIn=input('Type maxFanIn, or 0 if you do not want to restrict the fan-in.');
mcmcPAR.EmaxNodeFanOut=input('Type EmaxNodeFanOut, the prior expectation of nodes with non-zero fan-out, or 0 for a flat prior.');

mcmcPAR

save mcmcPAR.mat mcmcPAR;

