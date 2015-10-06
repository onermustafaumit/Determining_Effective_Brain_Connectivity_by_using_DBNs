function dagPAR=DBmcmc_SetParDAG
% SetPar: Sets parameters for the DAG
% and writes them out to structure dagPAR
%
% OUTPUT
% dagPAR: Structure with all the parameters
%
% INVOCATION
% dagPAR=DBmcmc_SetPar

dagPAR.nodeSize= input('Node size (2: binomial, 3: trinomial)?');
dagPAR.flag_quasi_deterministic= input('Quasi deterministic parameter setting? (0:no, 1:yes)');
dagPAR.N_redundantNodes= input('How many redundant nodes?');

save dagPAR.mat dagPAR;

