function varargout=DBmcmc_RandomTrainDataGenerator(Ngenes,T,seed)
% DBmcmc_RandomDataGenerator - Generates random data
%
% INPUT
% Ngenes - number of genes
% T - length of the time series
% seed - random number generator seed
% 
% OUTPUT
% The output is either written out to file train_random.mat,
% if no output argument is specified. Otherwise, it
% is stored in the output variable

rand('state',seed);

x= rand(Ngenes,T);
x= (x>1/3)+(x>2/3);
x= x-1;

if nargout>0
   varargout{1}=x;
else
   train_random=x;
   save train_random.mat train_random;
end
