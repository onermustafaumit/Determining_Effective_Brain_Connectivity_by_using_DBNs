function varargout=DBmcmc_DataZak(varargin)
% DBmcmc_DataZak - Makes the data from Zak et al., 
% Proc. Int. Conf. Sys. Biol., 2001, 231-238
%
% INPUT
% 'flag_binary', flag_binary
% flag_binary==1 --> binary, otherwise (and default) ternary
% 'NredundantNodes' --> number or redundant nodes (default==0)
%
% EXAMPLES
% data=DBmcmc_DataZak
%      Creates onlye the data
% [data,inter_true]=DBmcmc_DataZak
%      Returns the data amd the true INTER matrix
% [data,inter_true]=DBmcmc_DataZak('NredundantNodes',40)
%      Network with 40 redundant (unnconnected) nodes

% Inpu
flag_binary=0;
NredundantNodes=0;
nargs = length(varargin);
for i=1:2:nargs
 switch varargin{i},
  case 'NredundantNodes', NredundantNodes = varargin{i+1};
  case 'flag_binary', flag_binary= varargin{i+1};
  otherwise, error('Wrong argument, possibly a mistyped keyword'); 
 end
end

maxValue=2;
Ndata=12; % number of sampled data points

NactiveNodes=10;
Nnodes= NactiveNodes+NredundantNodes;

data= zeros(Nnodes,Ndata);

A=1; B=2; C=3; D=4; E=5; F=6; G=7; H=8; J=9; K=10;

data(A,:)=[2 0 0 0 2 2 2 2 2 2 0 0];
data(B,:)=[1 2 2 2 1 1 1 1 1 1 0 0];
data(C,:)=[2 0 0 0 1 1 2 2 2 2 1 1];
data(D,:)=[0 2 2 2 0 0 0 0 0 0 0 0];
data(E,:)=[2 0 0 0 0 0 1 2 2 2 2 2];
data(F,:)=[0 2 0 0 0 0 0 0 0 0 0 0];
data(G,:)=[0 0 1 2 2 1 1 0 0 0 0 0];
data(H,:)=[2 2 2 1 0 2 2 2 2 2 2 2];
data(J,:)=[0 0 0 1 2 0 0 0 0 0 0 0];
data(K,:)=[0 0 1 2 2 1 1 0 0 0 0 0];
assert(K==NactiveNodes);

if NredundantNodes>0
   data(NactiveNodes+1:Nnodes,:)= ...
   floor((maxValue-eps)*rand(NredundantNodes,Ndata));
end

if nargout==0
   % Plots the data
   clf
   for i=1:NactiveNodes
       subplot(ceil(NactiveNodes/2),2,i)
       plot(data(i,:),'b-') 
       hold on
       plot(data(i,:),'rx') 
       axis([1 Ndata -0.2 2.2]);
   end  
else
   % Makes the output data matrix. Note that this must be
   % a cell array with double the number of lines (=nodes)
   % so as to match the way I simulate dynamic Bayesian networks
   % (recall the difference between INTER and DAG).
   data = data+1; % (range [0,2] --> [1,3])
   outputData= zeros(2*Nnodes,Ndata-1);
   for n=1:Ndata-1
       outputData(1:Nnodes,n)= data(1:Nnodes,n);
       outputData(Nnodes+1:2*Nnodes,n)= data(1:Nnodes,n+1);
   end
   outputData= num2cell(outputData);
   varargout{1}= outputData;
end 

if nargout>=2
   % Makes the true INTER matrix for the dynamic Bayesian network
   inter= zeros(NactiveNodes,NactiveNodes);
   inter(A,[A,B,C])=1; 
   inter(C,[D,G,K])=1;
   inter(D,[C,E])=1;
   inter(F,[B,D])=1;
   inter(G,H)=1;
   inter(K,J)=1;
   varargout{2}=inter;
end
