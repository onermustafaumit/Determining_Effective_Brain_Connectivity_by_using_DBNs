function varargout=DBmcmc_DataReadIn(varargin)
% DBmcmc_DataReadIn - Reads in the data 
% and transforms them into a format that the
% subsequent analysis programs can process. 
% These are the following operations:
% First, the data are transformed into a format for
% dynamic Bayesian networks. Data of the form
% x(1), x(2), x(3), ... , x(N)
% y(1), y(2), y(3), ... , y(N)
% become:
% x(1), x(2), x(3), ... , x(N-1)
% y(1), y(2), y(3), ... , y(N-1)
% x(2), x(3), x(4), ... , x(N)
% y(2), y(3), y(4), ... , y(N)
% Second, the ranges are transformed form
% binary: 0,1 --> 1,2
% ternary: -1, 0, 1 --> 1, 2, 3
% Third, the data are transformed from array to cell format.
% Fourth, and optionally, noisy redundant nodes can be added.
%
% INPUT
% 'data', dataIN: 
% Data matrix, where rows are genes and columns 
% are time points: Size= Ngenes*Ndata
% The data must either be binary (range: 0,1)
% or ternary (range: -1,0,1)
% To specify more than oine data set, give this
% command repeatedly.
% 'flag_binary', flag_binary
% flag_binary==1 --> binary, otherwise (and default) ternary
% 'NredundantNodes' --> number or redundant nodes (default==0)
%
% OUTPUT
% Cell array, to be read in by the subsequent programs.
% Optionally, the function can also output the vector
% of nodes sizes.
%
% EXAMPLES
% dataOUT=DBmcmc_DataReadIn('data',dataIN)
%      Creates only the data in the right output format
% dataOUT=DBmcmc_DataReadIn('data',dataIN1, 'data',dataIn2)
%      Concatenates two input data sets.
% dataOUT=DBmcmc_DataZak('data',dataIN,'NredundantNodes',40)
%      Creates 40 redundant (unnconnected) nodes
% dataOUT=DBmcmc_DataZak('data',dataIN,'NredundantNodes',40,...
%                        'flag_binary',1)
%      Here, the redundant nodes are binary
% [dataOUT,nodesSizes]=DBmcmc_DataReadIn('data',dataIN)
% This also outputs the vector of node sizes.

% Activate: transformation [-1 0 1] --> [1 2 3]
% Activate transformation array --> cell

%---------------------------------------------------
%  Input Data
%---------------------------------------------------

% Input and defaults
flag_binary=0;
NredundantNodes=0;
N_dataSets=0;
nargs = length(varargin);
for i=1:2:nargs
   switch varargin{i},
      case 'data'
            N_dataSets=N_dataSets+1;
            dataIN{N_dataSets}=varargin{i+1};
             [Ngenes(N_dataSets),Ndata(N_dataSets)]= ...
              size(dataIN{N_dataSets});
      case 'NredundantNodes'
            NredundantNodes = varargin{i+1};
      case 'flag_binary'
            flag_binary= varargin{i+1};
      otherwise
            error('Wrong argument, possibly a mistyped keyword'); 
   end
end

% Check that all data sets have the same number of genes
if N_dataSets>1
   for n=1:N_dataSets-1
       if Ngenes(n)~=Ngenes(n+1)
          error('All data sets must have the same number of genes');
       end
   end
end
Nnodes=Ngenes(1);


%---------------------------------------------------
%  Output Data: Generation
%---------------------------------------------------

% Makes the output data matrix. Note that this must be
% a cell array with double the number of lines (=nodes)
% so as to match the way dynamic Bayesian networks
% are simulated (recall the difference between INTER and DAG).

NtotalCols= sum(Ndata)- N_dataSets;
dataOUT= zeros(2*Nnodes,NtotalCols);
n=0;
for nDataSet= 1:N_dataSets
    for nData=1:Ndata(nDataSet)-1
        n=n+1;
        dataOUT(1:Nnodes,n)= dataIN{nDataSet}(1:Nnodes,nData);
        dataOUT(Nnodes+1:2*Nnodes,n)= dataIN{nDataSet}(1:Nnodes,nData+1);
    end
end

[test1,test2]= size(dataOUT);
assert(test2==NtotalCols);


%---------------------------------------------------
% Optional: Add spurious nodes
%---------------------------------------------------
if  NredundantNodes>0
   NtotalNodes= Nnodes+NredundantNodes;
   X= rand(2*NtotalNodes,NtotalCols); % random numbers in [0,1]
   if flag_binary
       X= zeros(2*NtotalNodes,NtotalCols)+ (X>0.5);
   else  % ternary
       X= -ones(2*NtotalNodes,NtotalCols)+ (X>1/3) + (X>2/3);
   end
   X(1:2*Nnodes,1:NtotalCols)=dataOUT;
   clear dataOUT;
   dataOUT=X;
   clear X;
   Nnodes=NtotalNodes;
end


%---------------------------------------------------
%  Output Data: Format for BNET toolbox
%---------------------------------------------------

if flag_binary
   dataOUT= dataOUT+1;
   % shift [0,1] --> [1,2]
else % ternary
   dataOUT= dataOUT+2;
   % shift [-1,0,1] --> [1,2,3]
end

%---------------------------------------------------
%  Output Data: Actual output
%---------------------------------------------------

dataOUT= num2cell(dataOUT);

% Output data
varargout{1}= dataOUT;

% Output vector of node sizes
if flag_binary
   varargout{2}= 2*ones(1,2*Nnodes);
else
   varargout{2}= 3*ones(1,2*Nnodes);
end
