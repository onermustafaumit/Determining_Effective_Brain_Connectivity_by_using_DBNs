function randomData= RandomData(varargin)
% RandomData: Generate random binary or trinomial data
%
% INPUT
% Nrows: Number of rows
% Ncols: Number of columns
% random_seed [optional]
% flag_binary [optional] (default= 0): 
% flag_binary==1 --> binary data
% flag_binary==0 --> triomial data
% 
% OUTPUT 
% randomData: Nrows-by-Ncols matrix of 
% binary or trinomial random data
%
% INVOCATION
% randomData= RandomData(Nrows,Ncols)
% or
% randomData= RandomData(Nrows,Ncols,rand_seed)
% or
% randomData= RandomData(Nrows,Ncols,rand_seed,flag_binary)

Nrows=varargin{1};
Ncols=varargin{2};
if nargin>2
   rand_seed=varargin{3};
end
if nargin>3
   flag_binary=varargin{4};
else
   flag_binary=0;
end

rand('seed',rand_seed);

X= rand(Nrows,Ncols); % random numbers in [0,1]
if flag_binary
   X= zeros(Nrows,Ncols)+ (X>0.5);
else  % trinomial
   X= -ones(Nrows,Ncols)+ (X>1/3) + (X>2/3);
end

randomData=X;
