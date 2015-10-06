function DBmcmc_EdgesOverThresh(varargin)
% DBmcmc_EdgesOverThresh - Proportion of edges
% with a posterior probability over a given threshold
%
% INPUT
% Results.mat (optional)
% If no input argument is specified, the function
% reads in Results.mat from the current directory
%
% INVOCATION
% DBmcmc_EdgesOverThresh OR DBmcmc_EdgesOverThresh(Results)


% clf

if nargin>0
   Results=varargin{1};
else
   load Results.mat;
end

colour= 'rgbmcrgbmcrgbmcrgbmcrgbmc';
for nResults=1:length(Results)

INTERposterior=Results{nResults}.INTERposterior;
[Mx My]= size(INTERposterior);
N= Mx*My;
INTERposterior= reshape(INTERposterior,1,N);

sum(INTERposterior>=0.5)/N;

for i=1:101
    thresh(i)=(i-1)/100;
    x(i)=sum(INTERposterior>=thresh(i))/N;
end
figure
plot(thresh,x,colour(nResults),'Linewidth',2);
grid on
hold on

end % nResults

set(gca,'Fontsize',15)
xlabel('Threshold');
ylabel('Proportion of edges');
