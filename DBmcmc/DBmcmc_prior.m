function prior=DBmcmc_prior(dag,maxFanIn,EmaxNodeFanOut)
% DBmcmc_prior: Computes the prior probability of a DAG.
% If maxFanIn>0:
% Sharp cut-off for the maximum fan-in of a node.
% If EmaxNodeFanOut>0:
% Exponential distribution for the number of source nodes
% with non-zero fan-out: P= (1-p)p^m
% Expectation value: E= p/1-p ==> p= E/(1+E)
% maxFanIn=0,EmaxNodeFanOut=0 gives a uniform prior
%
% INPUT
% dag: dag whose prior is to be computed
% maxFanIn: maximum fan-in of target nodes
% EmaxNodeFanOut: expectation value for the maximum number
%                 of source nodes with non-zero fan-out.
%  
% OUTPUT
% prior: the prior probability
%
% INVOCATION
% prior=DBmcmc_prior(dag,maxFanIn,E_maxNodeFanOut)

inter=DBmcmc_dag2inter(dag);

fanIns=sum(inter,1);
if maxFanIn>0 & max(fanIns) > maxFanIn
   % Maximum fan-in exceeded, so prior is 0
   prior=0;
else
   if EmaxNodeFanOut>0
      % Geometric distribution on the number of nodes
      fanOuts=sum(inter,2);
      N_activeSourceNodes=length(find(fanOuts));
      p=EmaxNodeFanOut/(1+EmaxNodeFanOut);
      prior= (1-p)*p^N_activeSourceNodes;
   else
      prior=1; 
   end
end
