function varargout=DBmcmc_ROC(varargin)
% DBmcmc_ROC: Draws ROC curves
%             and (optionally) computes average AuROC
% Dirk Husmeier, 26 May 2003
% Revised: 1 August 2003
%
% INPUT
% Results - Results.mat structure written out 
%           to file by DBmcmc_Application
% INTERtrue: True inter-slice connectivity matrix 
% flag_average: 1= average different inter matrices
% [optional]       and get one ROC curve
%               0= plot all ROC curves separately
%               Default (if not specified) = 0
%
% OUTPUT (optional)
% AuROC, std_AuROC
% Average normalized area under the ROC curve and std.
% error. The standard error is computed from a collection
% of ROC curves, stored in Results{1:n}.
% If n=1, the std. error is zero.
% Normalization means that 0 is a random predictor, 
% and 100 corresponds to a perfect.
% WARNING: This option doesn't work yet!
%
% FUNCTION CALLS
% DBmcmc_makeROC (found in this file below)
% No longer use the old program: DBmcmc_makeROC_old
% If you do want to use it, though, replace
% DBmcmc_makeROC --> DBmcmc_makeROC_old
% in the program code.
%
% INVOCATION
% DBmcmc_ROC(INTERtrue,Results)
% OR
% [AuROC, std_AuROC]= DBmcmc_ROC(INTERtrue,Results)


INTERtrue= varargin{1};
Results= varargin{2};
if nargin>2
   flag_averaging=varargin{3};
else
   flag_averaging=0;
end
N_simu= length(Results);

% ------------------------
%  Compute ROCs
% ------------------------
if flag_averaging==0
   % No averaging; all ROCs plotted separately
   for n=1:N_simu
        INTERposterior= Results{n}.INTERposterior;
        [ROC_sensiVspeci(:,:,n),AuROC(n)]=DBmcmc_makeROC(INTERtrue,INTERposterior);
   end
else
   % Average ROC plotted
   INTERposterior= Results{1}.INTERposterior;
   INTERposterior= INTERposterior-INTERposterior;
        % zero matrix of the right dimension
   for n=1:N_simu
        INTERposterior= INTERposterior+Results{n}.INTERposterior;
   end
   INTERposterior= INTERposterior/N_simu;
   N_simu=1;
   [ROC_sensiVspeci(:,:,1),AuROC(1)]=DBmcmc_makeROC(INTERtrue,INTERposterior);
end

% ------------------------
%  Plot
% ------------------------
graphCol='brmkcbrmkcbrmkc';
plot([0,1],[0,1],'g--','LineWidth',2)
for n=1:N_simu
    hold on
    plot(ROC_sensiVspeci(2,:,n),ROC_sensiVspeci(1,:,n),graphCol(n),'LineWidth',3);
end
axis('square')
axis([-0.02 1.02 -0.02 1.02])
set (gca, 'Fontsize', 15)
xlabel('False positives')
ylabel('True positives')

% ------------------------
%  Output
% ------------------------
if nargout>=1
   varargout{1}= mean(AuROC);
end
if nargout>=2
   varargout{2}= std(AuROC);
end

%================================================
% DBmcmc_makeROC
%================================================

function varargout=DBmcmc_makeROC(varargin)
%  DBmcmc_ROC: Compute ROC curves
%
% INPUT
% INTERposterior: Posterior probabilities of the
%                 inter-slice edges 
% INTERtrue: True inter-slice connectivity matrix 
%
% OUTPUT
% ROC_sensiVspeci: 
% 2-by-NtrueEdges matrix, where the first row vector
% gives the proportion of true postive edges (TPs),
% and the second row vector gives the number of false
% positive edges (FPs).
% AuROC:
% Optional: The area under the ROC curve, normalized
% so that 0 is a random predictor, and 100 a perfect
% predictor.
%
% FUNCTION CALLS
% numInt: Numerical integration, for AuROC
% (found in this file below)
%
% INVOCATION
% ROC_sensiVspeci=DBmcmc_makeROC(INTERtrue,INTERposterior)
% OR
% [ROC_sensiVspeci,AuROC]=DBmcmc_makeROC(INTERtrue,INTERposterior)

INTERtrue= varargin{1};
INTERposterior= varargin{2};
if size(INTERtrue,1)~=size(INTERtrue,2)
     error('INTERtrue must be a quadratic matrix.')
end
N_nodes= size(INTERposterior,1);
if size(INTERtrue,1)~=N_nodes
     error('INTERtrue and INTERposterior must have the same size!')
end

% Total number of true edges
NTP= sum(sum(INTERtrue));
% Total number of  false edges
NFP= sum(sum(~INTERtrue));

N_discretization=100;
TP= zeros(1,N_discretization+2);
FP= zeros(1,N_discretization+2);
for n=1:N_discretization+2
    thresh=(n-1)/N_discretization;
    INTERposteriorThresh=(INTERposterior>=thresh);
    TP(n)= sum(sum(INTERposteriorThresh.*INTERtrue));
    FP(n)= sum(sum(INTERposteriorThresh.*~INTERtrue));
end

ROC_sensiVspeci= [TP/NTP; FP/NFP];
AUROC= numInt(ROC_sensiVspeci);
relativeAUROC= 100*(AUROC-0.5)/(1-0.5);

% --------------------------------------------------
% Output
% --------------------------------------------------
varargout{1}= ROC_sensiVspeci;
varargout{2}= relativeAUROC;

%================================================
% FUNCTION: Numerical Integration
%================================================

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
x= z(2,:);   % FP
y= z(1,:);   % TP
x2= x(2:N);
y2= y(2:N);
x1= x(1:N-1);
y1= y(1:N-1);
d= abs(x2-x1);
 
lowerBound= y1*d';
upperBound= y2*d';

varargout{1}= (lowerBound+upperBound)/2;
varargout{2}= abs(upperBound-lowerBound)/2;






% OBSOLETE

%================================================
% DBmcmc_makeROC_old
%================================================
% Computes the TP and FP scores only for the
% posterior probability values of the true edges.
% I found that this can give accurate ROC curves
% and therefore no longer use this function.
% This function was used for the computation
% of the ROC curves in my BioInf article.

function varargout=DBmcmc_makeROC_old(varargin)
%  DBmcmc_ROC: Compute ROC curves
%
% INPUT
% INTERposterior: Posterior probabilities of the
%                 inter-slice edges 
% INTERtrue: True inter-slice connectivity matrix 
%
% OUTPUT
% ROC_sensiVspeci: 
% 2-by-NtrueEdges matrix, where the first row vector
% gives the proportion of true postive edges (TPs),
% and the second row vector gives the number of false
% positive edges (FPs).
% AuROC:
% Optional: The area under the ROC curve, normalized
% so that 0 is a random predictor, and 100 a perfect
% predictor.
%
% FUNCTION CALLS
% numInt: Numerical integration, for AuROC
% (found in this file below)
%
% INVOCATION
% ROC_sensiVspeci=DBmcmc_makeROC(INTERtrue,INTERposterior)
% OR
% [ROC_sensiVspeci,AuROC]=DBmcmc_makeROC(INTERtrue,INTERposterior)

INTERtrue= varargin{1};
INTERposterior= varargin{2};
if size(INTERtrue,1)~=size(INTERtrue,2)
     error('INTERtrue must be a quadratic matrix.')
end
N_nodes= size(INTERposterior,1);
if size(INTERtrue,1)~=N_nodes
     error('INTERtrue and INTERposterior must have the same size!')
end

% --------------------------------------------------
% Prepare ROC
% --------------------------------------------------

NtrueEdges=sum(sum(INTERtrue));
NfalseEdges=sum(sum(~INTERtrue));
% Posterior matrix where all false edges are set to zero
trueEdges=INTERposterior.*INTERtrue;
% Posterior matrix where all true edges are set to zero
falseEdges=INTERposterior.*~INTERtrue;

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

AUROC= numInt(ROC_sensiVspeci);
relativeAUROC= 100*(AUROC-0.5)/(1-0.5);

% --------------------------------------------------
% Output
% --------------------------------------------------
varargout{1}= ROC_sensiVspeci;
varargout{2}= relativeAUROC;
