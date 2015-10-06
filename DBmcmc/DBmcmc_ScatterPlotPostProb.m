function DBmcmc_ScatterPlotPostProb(varargin)
% Scatter plot of posterior probabilities on edges for 2 simulations
% You either look at the individual results as subplots, or
% at the average scores in a single plot
%
% INPUT
% Mandatory:
% Results1, Results2
% Results structures from two simulations
% Optional:
% Mode (either 'single' or 'average')
% Default: single
% Single means that individual results are shown in suplots.
% Average means that the posterior probabilities for the edges
% are averaged over all MCMC simulations, and then a single
% average scatter plot is produced
%
% INVOCATION
% DBmcmc_ScatterPlotPostProb(Results1,Results2)
% DBmcmc_ScatterPlotPostProb(Results1,Results2,'average')


clf

Results1= varargin{1};
Results2= varargin{2};
flag_average=0

if nargin>2
   switch varargin{3},
      case 'single'
           flag_average=0;
      case 'average'
           flag_average=1;
      otherwise
           error('Wrong argument, possibly a mistyped keyword'); 
   end
end

% -----------------------------------------------

if ~flag_average
% Individual results shown in subplots

N1= length(Results1);
N2= length(Results2);

[m,n]=size(Results1{1}.INTERposterior)
mn1= m*n;
[m,n]=size(Results2{1}.INTERposterior);
mn2= m*n;
assert(mn1==mn2);
mn=mn1;

n=0;
for n1=1:N1
    for n2=1:N2
        n=n+1;
        x=reshape(Results1{n1}.INTERposterior,1,mn);
        y=reshape(Results2{n2}.INTERposterior,1,mn);
        subplot(N1,N2,n) 
        plot(x,y,'b.','MarkerSize',10)
        hold on
        plot([0 1],[0 1],'r-')
    end
end

end  % --> flag_average

% -------------------------------------------------
 
if flag_average
% Average results shown in a single plots

INTERaverage1=DBmcmc_InterPosteriorAverage(Results1);
INTERaverage2=DBmcmc_InterPosteriorAverage(Results1);

[m,n]=size(INTERaverage1)
mn1= m*n;
[m,n]=size(INTERaverage2);
mn2= m*n;
assert(mn1==mn2);
mn=mn1;

x=reshape(INTERaverage1,1,mn);
y=reshape(INTERaverage2,1,mn);
plot(x,y,'b.','MarkerSize',10)
hold on
plot([0 1],[0 1],'r-')
 
end  % --> flag_average
