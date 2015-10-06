function dataPAR=DBmcmc_SetParData
% SetParData: Sets parameters for the training data
% and writes them out to structure dataPAR
%
% OUTPUT
% dataPAR: Structure with all the parameters
%
% INVOCATION
% dataPAR=DBmcmc_SetParData

dataPAR.nData= input('Type in the size of the training set.');
save dataPAR.mat dataPAR;

