function pValue=ProbNetH0(NtrueEdgesFound,NtrueEdges,Nnodes)
% ProbNetH0 - computes the probability for a network under H0,
% the null hypothesis of random, unrelated nodes
%
% INPUT
% NtrueEdgesFound: Number of detected true edges
% NtrueEdges: Total number of true edges
% Nnodes: Number of nodes in the network
%
% OUTPUT
% pValue: p-value
%
% INVOCATION
% pValue=ProbNetH0(NtrueEdgesFound,NtrueEdges,Nnodes)

NpossibleEdges=Nnodes^2;
P=NtrueEdges/NpossibleEdges;
Q= 1-P;
pValue=0;
for n=NtrueEdgesFound:NtrueEdges
    pValue= pValue + ...
            ChooseTDH(NtrueEdges,n)*...
             P^n * Q^(NpossibleEdges-n);
end


function x=ChooseTDH(N,n)
numerator=N;
for i=1:n-1
    numerator=numerator*(N-i);
end
x= numerator/factorial(n);
