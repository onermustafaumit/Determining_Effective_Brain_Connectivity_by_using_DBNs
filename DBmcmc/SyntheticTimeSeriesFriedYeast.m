function data=SyntheticTimeSeriesFriedYeast(varargin)
% Generate a synthetic time series from the 
% Yeast genetic network in Friedman et al.
%
% INPUT
% T: Number of data points.
% Optional; default=50.
% randSeed: random number generator seed
% Optional, default: 17
%
% OUTPUT
% The output data are of the following format:
% Rows --> Genes
% Columns --> Time points
%
% EXAMPLES
% data= SyntheticTimeSeriesFriedYeast
%      Default settings
% data= SyntheticTimeSeriesFriedYeast(20)
%      Produces a data set of 20 exemplars
% data= SyntheticTimeSeriesFriedYeast(20,3)
%      Sets the random number generator seed to 3

% Defaults
randSeed=17; % Random number generator seed
T= 50; % Length of time series

% Inputs
if nargin>=1
   T= varargin{1};
end
if nargin>=2
   randSeed=varargin{2};
end

rand('state',randSeed);

Thresh=0.9;
Nnodes=12;


x= zeros(Nnodes,T);

% Nodes in the network
RNR3=1;
CLN1=2;
SRO4=3;
RAD51=4;
CLB2=5;
MYO1=6;
ACE2=7;
ALK1=8;
MNN1=9;
CLN2=10;
SVS1=11;
CDC5=12;

% Initialization 
for n=1:Nnodes
    x(n,1)=RandBin;
end

% Dynamics
for t=1:T-1
    % Root nodes
    x(CLN2,t+1)= RandBin;
    x(ACE2,t+1)= RandBin;
    % Controlled by ACE2
    x(CDC5,t+1)= Activate(x(ACE2,t),Thresh);
    % Controlled by CLN2
    x(RAD51,t+1)= Activate(x(CLN2,t),Thresh);
    x(RNR3,t+1)=  Activate(x(CLN2,t),Thresh);
    x(CLN1,t+1)=  Inhibit(x(CLN2,t),Thresh);
    x(SRO4,t+1)=  Inhibit(x(CLN2,t),Thresh);
    % Controlled by CDC5
    x(ALK1,t+1)= Activate(x(CDC5,t),Thresh);
    x(CLB2,t+1)= Activate(x(CDC5,t),Thresh);
    x(MYO1,t+1)= Inhibit(x(CDC5,t),Thresh);
    % Jointly controlled by CLN2 and CDC5
    x(SVS1,t+1)= XOR(x(CLN2,t),x(CDC5,t),Thresh);
    % Controlled by SVS1 
    % The old program (before 6 Aug 2003) did't have this line!
    x(MNN1,t+1)= Inhibit(x(SVS1,t),Thresh);
end

% Output of data
data=x;

return

% -----------------------------

function y=RandBin
x0= 2*rand-1; % random number in [-1,1]
y= (x0>=0);
return

function y=Activate(x,Thresh)
if x==1 
   if rand<Thresh
      y=1;
   else
      y=0;
   end
elseif x==0
   if rand<Thresh
      y=0;
   else
      y=1;
   end
end
return 

function y=Inhibit(x,Thresh)
if x==1 
   if rand<Thresh
      y=0;
   else
      y=1;
   end
elseif x==0
   if rand<Thresh
      y=1;
   else
      y=0;
   end
end

function y=XOR(x1,x2,Thresh)
if x1+x2==1 
   if rand<Thresh
      y=0;
   else
      y=1;
   end
else
   if rand<Thresh
      y=1;
   else
      y=0;
   end
end
return










