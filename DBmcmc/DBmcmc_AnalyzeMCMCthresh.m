function varargout=DBmcmc_AnalyzeMCMCthresh(varargin)
%  AnalyzeMCMCthresh: Analyze the results of the MCMC trajectory
% As opposed to DBmcmc_AnalyzeMCMC, the posterior 
% INTER matrix is thresholded. From this the total
% number of true and false positive edges are computed,
% as well as their probabilities
%
% INPUT
% INTERposterior: INTER averaged over the sampling period of the MCMC simulation;
% matrix whose elements represent the posterior probabilities 
% of the edges.
% (Recall: INTER is obtained from the respective DAG 
%  with the command DBmcmc_dag2inter.)
% bnet_true: True bnet
% thresh: Threshold for thresholding INTERposterior.
%         Optional; default value= 0.5 
%
% OUTPUT
% NtrueEdges
%     Number of recovered true edges
% NfalseEdges
%     Number of false edges
% PtrueEdges
%     Average posterior probability of a true edge
% PfalseEdges
%     Average posterior probability of a spurious edge

% INVOCATION
% [NtrueEdges,NfalseEdges,PtrueEdges,PfalseEdges]=DBmcmc_AnalyzeMCMCthresh(INTERposterior,bnet_true,thresh)

INTERposterior=varargin{1};
bnet_true=varargin{2};
if nargin>=3
   thresh=varargin{3};
else
   thresh=0.5;
end

INTERposterior=(INTERposterior>thresh);

nNodes=size(INTERposterior,1);
INTERtrue= DBmcmc_dag2inter(bnet_true.dag);
if size(INTERposterior)~=size(INTERtrue)
     error('INTERposterior and INTERtrue do not have the same dimension.')
end


% --------------------------------------------------
% Average probabilities on true and spurious links
% --------------------------------------------------

NtrueEdges=sum(sum(INTERposterior.*INTERtrue));
PtrueEdges=NtrueEdges/sum(sum(INTERtrue));
NfalseEdges=sum(sum(INTERposterior.*~INTERtrue));
PfalseEdges=NfalseEdges/sum(sum(~INTERtrue));


% --------------------------------------------------
% Output
% --------------------------------------------------
varargout{1}=NtrueEdges;
varargout{2}=NfalseEdges;
varargout{3}=PtrueEdges;
varargout{4}=PfalseEdges;

