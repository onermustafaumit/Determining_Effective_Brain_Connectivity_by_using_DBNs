function varargout=DBmcmc_InterPosteriorAverage(Results)
% Compute the average INTER matrix from several simulations.
% Optionally, the standard deviations for the edges can be
% computed as well.
%
% INPUT
% Results - Results structure
%
% OUTPUT
% Average INTER matrix and (optionally) matrix of standard deviations
%
% INVOCATION
% INTERaverage=DBmcmc_InterPosteriorAverage(Results)
% [INTERaverage,INTERstd]=DBmcmc_InterPosteriorAverage(Results)

N= length(Results);
[n1,n2]= size(Results{1}.INTERposterior);
INTER= zeros(n1,n2,N);
for n=1:N
    INTER(:,:,n)=Results{n}.INTERposterior;
end

INTERaverage= mean(INTER,3);
if nargout>1
   INTERstd= std(INTER,0,3);
end

varargout{1}= INTERaverage;
if nargout>1
   varargout{2}= INTERstd;
end
