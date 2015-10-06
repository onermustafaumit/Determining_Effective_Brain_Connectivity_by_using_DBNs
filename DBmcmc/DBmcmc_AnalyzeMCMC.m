function varargout=DBmcmc_AnalyzeMCMC(varargin)
%  AnalyzeMCMC: Analyze the results of the MCMC trajectory
%
% INPUT
% INTERposterior: INTER averaged over the sampling period of the MCMC simulation;
% matrix whose elements represent the posterior probabilities 
% of the edges.
% (Recall: INTER is obtained from the respective DAG 
%  with the command DBmcmc_dag2inter.)
% bnet_true: True bnet object or true DAG
% thresh: Threshold for thresholding INTERposterior.
%         Optional; default value= 0.5 
%
% OUTPUT
% PtrueEdges
%     Average posterior probability of a edge
% PfalseEdges
%     Average posterior probability of a spurious edge
% nodeConnectivityPredicted
%     Predicted average number of edges connected to a node,
%     predicted from the average INTER (whose elements denote
%     posterior probabilities. 
% nodeConnectivityThreshPredicted
%     Predicted average number of edges connected to a node,
%     predicted from the average INTER after thresholding
%     (setting posterior probabilties > thresh to 1, and those < thresh
%     to 0).
% nodeConnectivityTrue
%     True number of edges connected to a node
% ROC_sensiVspeci
%     ROC matrix, where the first row gives the sensitivity,
%     and the second row the specificity 
% ROC_trueVfalseEdges
%     ROC matrix, where the first row gives the number of
%     recovered true edges, and the second row the number
%     of spurious (false) edges.
%
% INVOCATION
% [PtrueEdges,PfalseEdges,nodeConnectivityPredicted,nodeConnectivityThreshPredicted,nodeConnectivityTrue,ROC_sensiVspeci,ROC_trueVfalseEdges,relativeAUROC]=DBmcmc_AnalyzeMCMC(INTERposterior,bnet_true,thresh)

INTERposterior=varargin{1};
bnet_true=varargin{2};
if nargin>=3
   thresh=varargin{3};
else
   thresh=0.5;
end

nNodes=size(INTERposterior,1);
if isobject(bnet_true)
   % bnet is an object
   INTERtrue= DBmcmc_dag2inter(bnet_true.dag);
else
   % bnet is a DAG matrix 
   INTERtrue= DBmcmc_dag2inter(bnet_true);
end
if size(INTERposterior)~=size(INTERtrue)
     error('INTERposterior and INTERtrue do not have the same dimension.')
end

% --------------------------------------------------
% True and predicted connectivity per node
% --------------------------------------------------

for n=1:nNodes
    nodeConnectivityPredicted(n)= sum(INTERposterior(n,:))+sum(INTERposterior(:,n))-INTERposterior(n,n);
end

for n=1:nNodes
    nodeConnectivityThreshPredicted(n)= sum(INTERposterior(n,:)>thresh)+sum(INTERposterior(:,n)>thresh)-(INTERposterior(n,n)>thresh);
end

for n=1:nNodes
    nodeConnectivityTrue(n)= sum(INTERtrue(n,:))+sum(INTERtrue(:,n))-INTERtrue(n,n);
end

% --------------------------------------------------
% Average probabilities on true and spurious edges
% --------------------------------------------------

NtrueEdges=sum(sum(INTERtrue));
NfalseEdges=sum(sum(~INTERtrue));
% Posterior matrix where all false edges are set to zero
trueEdges=INTERposterior.*INTERtrue;
scoreTrueEdges=sum(sum(trueEdges));
PtrueEdges=scoreTrueEdges/NtrueEdges;
% Posterior matrix where all true edges are set to zero
falseEdges=INTERposterior.*~INTERtrue;
scoreFalseEdges=sum(sum(falseEdges));
PfalseEdges=scoreFalseEdges/NfalseEdges;

% --------------------------------------------------
% ROC 
% --------------------------------------------------

% Add two extra points for thresholds 
% -infty and +infty so as to get an ROC
% curve from 0 to 100 percent.
falseEdgesOverThreshold=zeros(1,NtrueEdges+2);
falseEdgesOverThreshold(NtrueEdges+2)=NfalseEdges;
trueEdgesOverThreshold=[0,1:NtrueEdges,NtrueEdges];

[I,J,vectorScoresTrueEdges]=find(trueEdges);
if(length(vectorScoresTrueEdges)<NtrueEdges)
   % This can happen when the posterior probability
   % of a true edge is zero.
   for i=length(vectorScoresTrueEdges)+1:NtrueEdges
       vectorScoresTrueEdges(i)=0;
       trueEdgesOverThreshold(i+1)=NtrueEdges;
   end 
end
assert(length(vectorScoresTrueEdges)==NtrueEdges);
vectorScoresTrueEdges=sort(vectorScoresTrueEdges);
falseEdges=falseEdges-INTERtrue;
  % Sets true edges from 0 to -1 to distinguish them 
  % from spurious edges with 0 score 
for n=NtrueEdges:-1:1
    falseEdgesOverThreshold(NtrueEdges-n+2)= ...
    sum(sum(falseEdges>=vectorScoresTrueEdges(n)));
    assert(falseEdgesOverThreshold(NtrueEdges-n+2)<= ...
           NfalseEdges);
end

ROC_trueVfalseEdges(1,:)= ...
trueEdgesOverThreshold;
ROC_trueVfalseEdges(2,:)= ...
falseEdgesOverThreshold;

ROC_sensiVspeci(1,:)= ...
trueEdgesOverThreshold/NtrueEdges;
ROC_sensiVspeci(2,:)= ... 
falseEdgesOverThreshold/NfalseEdges;

AUROC= 1.0-numInt(ROC_sensiVspeci);
relativeAUROC= 100*(AUROC-0.5)/(1-0.5);

% --------------------------------------------------
% Output
% --------------------------------------------------

varargout{1}=PtrueEdges;
varargout{2}=PfalseEdges;
varargout{3}=nodeConnectivityPredicted;
varargout{4}=nodeConnectivityThreshPredicted;
varargout{5}=nodeConnectivityTrue;
varargout{6}=ROC_sensiVspeci;
varargout{7}=ROC_trueVfalseEdges;
varargout{8}=relativeAUROC;


% --------------------------------------------------
% FUNCTION: Numrical Integration
% --------------------------------------------------

function varargout=numInt(z)
% numInt: Simple numerical integration
% 
% INPUT
% Two-by-N matrix, where
% z(1,:): vector of x values
% z(2,:): vector of y values
% 
% OUTPUT
% int: numerical value of the integral
% sigma: standard error [optional] 
%
% INVOCATION
% [int,sigma]= numInt(z)

N=size(z,2);
x= z(1,:);
y= z(2,:);
x2= x(2:N);
y2= y(2:N);
x1= x(1:N-1);
y1= y(1:N-1);
d= x2-x1;
 
lowerBound= y1*d';
upperBound= y2*d';

varargout{1}= (lowerBound+upperBound)/2;
varargout{2}= abs(upperBound-lowerBound)/2;
