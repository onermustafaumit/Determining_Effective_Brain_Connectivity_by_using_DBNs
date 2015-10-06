function varargout= SpellYeast(varargin)
% Output and (optionally) plot the yeast cell cycle data
%
% INPUT, MANDATORY
% 1) Gene name, string
%    ACE2, MYO1, CLB2, ALK1, CDC5, SVS1
%    MNN1, CLN2, RAD51, RNR3, CLN1, SRO4 
% 2) Time series, string:
%    alpha, cdc15, cdc28, elu 
% INPUT, OPTIONAL
% 3) Keyword 'discretize', followed by a flag variable
%    1 (yes) or 0 (no, which is the default).
%    Discretization by fitting a three-component Gaussian
%    mixture model with the EM algorithm to the data,
%    leaving the output weights uniform and constant to 
%    prevent overfitting and to enforce that all three 
%    categories (-1, 0, 1) have about the same size.
% 4) Keyword 'detrend', followed by one of the keywords
%    'none' (default), 'linear', or 'quadratic'.
%    Detrending by linear or quadratic interpolation.
%
% OUTPUT
% If no output variable is specified, the
% results will be plotted on the screen.
% Otherwise, they will be written out to
% the specified output variable.
%
% EXAMPLE
% SpellYeast('CLN2','alpha');
% SpellYeast('CLN2','alpha','detrend','linear');
% SpellYeast('CLN2','alpha','detrend','linear','discretize',1);

clf

% ----------------------------
%  Data
% ----------------------------

ACE2 = [ ...
0.5     -0.4     NaN    -0.22   1.97    NaN     -1.54   -0.14   -1.05   -1.16   -0.69   0.08    0.61    0.76    0.75    0.44    -0.24   -0.3    0.76    -0.22   0.17    0.37    0.93    0.45    NaN      0.23    -0.77   -0.67   0.64    -0.15   1.22    0.75    1.17    -0.27   0.05    -0.77   -0.81   -1.24   -0.39   -0.01   0.82    0.33    0.86    -0.42   0.29    -0.22   0.07    -0.39   -0.31    NaN     -0.92   -1.31   -0.96   -0.42   0.19    0.36    0.63    0.55    0.72    0.51    -0.31   -0.58   0.21     NaN     0.29    0.73    0.3     NaN    -0.9    -1      -0.9    -1.15   -0.6    -0.37   -0.32   0.52    0.72    0.89    0.86    0.93    0.9     0.42];


MYO1  = [ ...
0.57     NaN     NaN   NaN     1.68     NaN    -0.93   -0.86   -0.46   -1.19   -0.8    -0.26   0.55    0.73    0.99    0.64    0.34    0.15    -0.57   -0.39   0.45    0.63    0.14    0.83     NaN    -0.77   -0.86   -1.07   0.1     0.28    0.91    0.97    0.97    -0.18   -0.01   0.01    -0.22   -0.23   -0.39   -0.29   0.14    -0.07   -0.77   0.63    1.12    0.42    -0.13   -0.23   -0.31   NaN   -0.93   -1.29   -1.01   -0.99   -0.15   0.44    1.04    0.9     0.56    0.38    0.02    -0.23   -0.36     NaN   0.45    0.52    0.67     NaN   -1.1    -0.52   -0.32   -0.5    -0.32   -0.38   -0.13   0.29    0.6     0.61    0.54    0.7     -0.02   0.56];


CLB2 = [ ...
-1.09   -0.69    NaN     2.49    3.47    NaN     -2.36   NaN     -1.96   -2.29   -1.36   0.4     1.09    1.54    1.5     0.92    0.05    -0.23   -0.42   -0.29   0.12    0.73    1.35    1.2     NaN     0.55    -1.03   -1.74   0.42    0.71    0.25    1.15    1.24    0.72    -0.24   -1.24   -1.03   -1.15   -0.39   -0.15   0.64    0.56    0.93    0.66    1.2     -0.07   -0.17   -0.91   -0.91   NaN     -1.35   -0.57   -0.95   -0.7    0.14    0.57    1.06    1.24    0.84    0.01    -0.35   -0.64   -0.11   0.18    0.63    NaN     NaN     NaN     -1.75   -1.29   0.25    -1.29   -1.18   -0.55   0.63    0.54    0.37    0.95    1.08    0.79    0.85    0.61];


ALK1 = [ ...
0.83    -0.38   NaN     2.14    1.74    NaN     -1.04   -0.51   -1.39   -1.04   -0.78   0.23    1.03    0.95    0.95    0.39    -0.22   -0.49   -0.61   -0.25   0.4     0.64    1.16    0.58    NaN     -1.19   -0.13   -0.83   0.81    0.81    1.5     0.94    1.03    0.25    -0.43   -1.36   -0.59   -0.64   -0.21   -0.51   0.52    0.44    0.98    0.44    -0.13   -0.17   -0.46   -0.76   -0.32   NaN     -1.28   -1.02   -0.76   -0.65   0.02    0.5     0.89    0.8     0.59    -0.13   -0.54   -0.38   -0.03   0.68    NaN     0.88    0.41    NaN     -1.05   -0.83   -0.39   -1.3    -0.79   -0.39   0.28    0.52    0.88    0.7     0.73    1.01    0.47    0.17];


CDC5 = [ ...
-0.12   -0.32   NaN     2.47    2.41    NaN     -0.99   -1.19   -1.33   -1.59   -0.74   0.05    1.01    0.83    1.22    0.7     0.16    -0.21   -0.53   -0.21   0.32    0.7     1.11    0.7     NaN     0.03    -1.7    -1.2    0.98    0.44    0.64    0.17    1.54    0.05    -0.03   -1.3    -1.25   -1.7    0.03    -0.32   1.13    0.53    1.31    0.6     0.89    -0.46   0.2     -0.37   -0.23   NaN     -1.59   -1.29   -1.54   -0.75   -0.24   0.5     1.08    1.22    0.89    -0.12   -0.24   -0.36   0.32    0.33    NaN     0.94    0.86    NaN     -1.1    -0.98   -1.42   -0.9    -0.8    -0.39   -0.12   0.77    0.79    1.15    0.67    1.08    0.87    0.37];


SVS1 = [ ...
0.19    3.12    NaN     -2.64   -1.51   NaN     -2.42   -2.15   0.66    1.98    1.55    0.78    0.14    -0.94   -1.03   -1.5    -0.03   1.25    1.61    0.84    0.82    -0.09   -0.48   -0.97   NaN     -1.29   1.1     1.78    0.16    NaN     -0.61   0.87    -1.18    NaN    0.21    NaN     1.05    NaN     0.77    NaN     -0.87    NaN    -1.2    NaN     NaN     NaN     -0.22   -0.23   -0.34   NaN     -1.39   -0.51   1.37    1.07    0.37    0.15    -0.21   -0.54   -0.93   0.18    0.77    NaN     0.3     0.22    -0.18   -0.18   -0.48   NaN     -1.71   0.7     -1.02   -0.53   0.21    0.58    0.55    0.61    0.22    0.46    0.28    0.13    -0.63   0.15];


MNN1 = [ ...
-0.47   2.49    NaN     -1.6    -0.15   NaN     -2.29   NaN     0.77    1.6     0.53    0.55    -0.38   -0.54   -1.08   -0.94   0.07    1.35    1.02    1       0.2     -0.04   -0.97   -0.87   NaN     -0.88   0.25    1.23    0.79    0.36    -0.74   -1.23   -0.92   -1.23   -0.16   0.36    1.05    1.28    1.38    1.27    0.38    -0.09   -0.56   -0.88   -0.48   -0.67   -0.22   -0.2    -0.06   NaN     -1.05   0.22    0.82    0.7     0.76    0.16    -0.07   -0.49   -1      -0.84   0.17    0.5     0.54    NaN    0.04    -0.06   -0.4     NaN    -1.14   -0.14   0.07    -0.3    0.45    0.68    0.74    0.34    0.03    0.44    0.53    -0.43   -1.05   -0.19];

CLN2 = [ ...
1.98    2.76    NaN     -2.74   -2      NaN     -1.41   -0.69   1.39    1.98    0.74    0.21    -0.36   -1.32   -1.5    -1.07   0.35    1.57    1.1     0.56    0.18    -0.32   -0.38   -1.04    NaN    -1.26   1.6     1.54    0.31    -0.14   -0.88   -1.7    -1.88   -1.7    0.61    1.54    1.72    1.51    1.18    0.84    -0.26   -0.34   -1.03   -0.85   -0.85   -0.21   0.13    0.13    0        NaN     NaN    0.85    1.47    0.54    0.03    -0.15   -0.28   -0.5    -1.57   -0.18   0.52    0.86    NaN     -0.1    -0.39   -0.05   -1.05    NaN    -1.77   -1.77   0.17    0       0.4     0.68    0.57    0.6     0.27    0.6     0.4     -0.3    -0.55   0.68];


RAD51 = [ ...
2.17    0.12    NaN     -0.42   -0.49   NaN     -0.57   0.42    1.03    1.35    0.64    0.42    -0.4    -0.9    -0.73   -0.47   0.2     0.78    0.28    -0.05   -0.11   -0.13   -0.87   -0.9     NaN    -0.9    0.26    0.73    0.07    -0.05   -0.51   -0.75   -1.19   -0.66   0.49    1.02    1.34    1.09    0.51    0.52    -0.07   -0.2    -0.66   -0.8    -0.98   0.36    0.05    0.17    0.18    NaN     -0.87   0.18    0.68    0.45    0.04    -0.28   -0.51   -0.42   -0.38   0.43    0.56    0.58    0.33    NaN     -0.11   -0.13   -0.57   NaN    -1.51   -0.65   0.4     -0.4    0.01    0.52    0.46    0.66    0.19    0.19    0.18    -0.19   -0.01   0.16];


RNR3 = [ ...
1.58    1.14    NaN     -1.03   -0.67   NaN     -1.09   NaN     0.82    1.05    0.9     NaN     -0.21   -0.55   -0.68   -0.84   0.4     0.9     0.75    0.18    0.23    -0.07   -1.12   -0.66    NaN    -0.84   1.24    1.03    -0.56   -1.47   -1.14   -2.42   -1.21   -1.34   0.89    1.37    1.32    1.65    0.92    0.52    0       -0.01   -0.4    -0.08   0.07    -0.1    0.29    0.13    0.15     NaN    0.69    0.12    0.16    0.26    0.12    0.49    -0.01   -0.19   -0.01   -0.04   0.01    0.1     -0.21   -0.35   -0.11   -0.48   -0.54    NaN    -1.19   -0.72   -0.46   0.1     0.41    0.76    0.63    0.42    0.21    0.56    0.16    -0.27   -0.46   -0.13];

CLN1 = [ ...
1.17    0.65    NaN     -2      -1.32    NaN    -1.56   -0.93   1.29    NaN     0.94    0.48    0.07    -0.54   -1.11   -0.77   0.66    1.14    0.99    0.3     0.35    -0.02   -0.41   -0.88   NaN     -1.34   1.21    0.83    0.17    0.01    -0.59   -0.93   -1.31   -1.19   0.2     1.08    0.99    0.93    0.86    0.23    -0.5    2.22    -0.45   -0.58   -0.58   -0.28   -0.39   -0.31   -0.29    NaN    NaN     0.21    0.57    0.53    0.14    0.16    -0.34   -0.66   -1.49   0.35    1.05    0.62    NaN     0.25    -0.23   -0.56   -0.59   NaN     -0.51   -2.07   -0.96   -0.29   0.23    0.65    0.48    0.54    0.59    0.53    0.24    0.27    -0.03   0.3];

SRO4 = [...
1.61    2.79    NaN     -2.74   -2.12    NaN    -0.94   -0.54   NaN     1.23    0.75    0.32    -0.35   -0.69   -0.6    -0.54   0.04    1.2     0.78    0.13    0.17    -0.02   -0.11   -0.83    NaN    -1.86   0.83    1.77    0.31    0.18    -1.04   -0.81   -1.56   -0.86   0.26    1.67    1.59    1.66    0.9     0.69    -0.43   -0.3    -0.86   -0.78   -0.73   0.49    -0.14   -0.1    -0.86    NaN    -0.36   -0.47   1.46    1.21    0.43    0.13    -0.67   -1.12   -1.37   -0.38   0.7     0.99    0.76    0.07    NaN     -0.68   -0.7    NaN     -1.38   -1.18   1.05    -0.43   0.08    0.52    0.56    0.71    0.01    0.57    0.08    -0.2    -0.4    0.01];


% -----------------------------
% Imputing missing values
% -----------------------------

% --> alpha
CLB2(6+2)= -2.16;
MNN1(6+2)= -0.76;
RNR3(6+2)= -0.14;
RNR3(6+6)= 0.35;
CLN1(6+4)= 1.12;
SRO4(6+3)= 0.35;

% --> cdc14
SVS1(25+5)= -0.23;
SVS1(25+9)= -0.49;
SVS1(25+11)= 0.63;
SVS1(25+13)= 0.91;
SVS1(25+15)= -0.05;
SVS1(25+17)= -1.04;
SVS1(25+19)= -1.25;
SVS1(25+20)= -0.92;
SVS1(25+21)= -0.58;

% --> cdc28
ACE2(64)=0.71;
MYO1(64)=0.38;
CLB2(66)=0.55;
CLB2(67)=0.63;
ALK1(65)=0.70;
CDC5(65)=0.78;
SVS1(62)=0.79;
MNN1(64)=0.50;
CLN2(51)=0;
CLN2(63)=0.26;
RAD51(64)=0.20;
CLN1(51)=0;
CLN1(63)=0.13;
SRO4(65)=-0.40;

% ----------------------------
%  Mean and Median Signal
% ----------------------------
X=[ACE2; MYO1; CLB2; ALK1; CDC5; SVS1; ...
   MNN1; CLN2; RAD51; RNR3; CLN1; SRO4]; 
signal_mean= mean(X,1);
signal_median= median(X,1);

% ----------------------------
%  Input
% ----------------------------

flag_ACE2 = 0;
flag_MYO1 = 0;
flag_CLB2 = 0;
flag_ALK1 = 0;
flag_CDC5 = 0;
flag_SVS1 = 0;
flag_MNN1 = 0;
flag_CLN2 = 0;
flag_RAD51 = 0;
flag_RNR3 = 0;
flag_CLN1 = 0;
flag_SRO4 = 0;
flag_mean = 0;
flag_median= 0;

switch varargin{1},
      case 'ACE2'
            flag_ACE2=1;
      case 'MYO1'
            flag_MYO1=1;
      case 'CLB2'
            flag_CLB2=1;
      case 'ALK1'
            flag_ALK1=1;
      case 'CDC5'
            flag_CDC5=1;
      case 'SVS1'
            flag_SVS1=1; 
      case 'MNN1'
            flag_MNN1=1;
      case 'CLN2'
            flag_CLN2=1;
      case 'RAD51'
            flag_RAD51=1;
      case 'RNR3'
            flag_RNR3=1;
      case 'CLN1'
            flag_CLN1=1;
      case 'SRO4'
            flag_SRO4=1; 
      case 'mean'
            flag_mean=1; 
      case 'median'
            flag_median=1; 
      otherwise
            error('Wrong argument, possibly a mistyped keyword'); 
end

switch varargin{2}
      case 'alpha'
            timeSeries=7:24;
      case 'cdc15'
            timeSeries=26:49;
      case 'cdc28'
            timeSeries=51:67;
      case 'elu'
            timeSeries=69:82;
      otherwise
            error('Wrong argument, possibly a mistyped keyword'); 
end

flag_detrend=0;
flag_discretize=0;
for i=3:2:nargin
    switch varargin{i}
        case 'detrend'
             if strcmp(varargin{i+1},'none')
                flag_detrend=0;
             elseif strcmp(varargin{i+1},'linear')
                flag_detrend=1;
             elseif strcmp(varargin{i+1},'quadratic')
                flag_detrend=2;
             else
                error('Wrong argument, possibly a mistyped keyword');
             end
        case 'discretize'
	     flag_discretize= varargin{i+1};
        otherwise
            error('Wrong argument, possibly a mistyped keyword'); 
    end
end

% ----------------------------
%  Output
% ----------------------------

if flag_ACE2
   signal= ACE2(timeSeries);
elseif flag_MYO1
   signal= MYO1(timeSeries);
elseif flag_CLB2
   signal= CLB2(timeSeries);
elseif flag_ALK1
   signal= ALK1(timeSeries);
elseif flag_CDC5
   signal= CDC5(timeSeries);
elseif flag_SVS1
   signal= SVS1(timeSeries);
elseif flag_MNN1
   signal= MNN1(timeSeries);
elseif flag_CLN2
   signal= CLN2(timeSeries);
elseif flag_RAD51
   signal= RAD51(timeSeries);
elseif flag_RNR3
   signal= RNR3(timeSeries);
elseif flag_CLN1
   signal= CLN1(timeSeries);
elseif flag_SRO4
   signal= SRO4(timeSeries);
elseif flag_mean
   signal= signal_mean(timeSeries);
elseif flag_median
   signal= signal_median(timeSeries);
end

y_int_1= interpolate(signal,1);
y_int_2= interpolate(signal,2);

if flag_detrend==1
   signal= signal-y_int_1;
elseif flag_detrend==2
   signal= signal-y_int_2;
end

% Discretization
K=3; 
[signal_discretized,thresh_low,thresh_high]=...
Discretization(signal,K);
if flag_discretize
   signal=signal_discretized;
end

if nargout==0
   plot(signal,'b-','Linewidth',2)
   hold on
   if ~flag_detrend & ~flag_discretize
       plot(y_int_1,'g-','Linewidth',2)
       hold on
       plot(y_int_2,'g--','Linewidth',2)
       hold on
   end
   plot(signal,'rx','markersize',10,'Linewidth',3)
   hold on
   plot([0 length(timeSeries)],[0 0],'k-','Linewidth',1)
   hold on
   if ~flag_discretize
      plot([0 length(timeSeries)],[thresh_high thresh_high],'k--','Linewidth',1)
      hold on
      plot([0 length(timeSeries)],[thresh_low thresh_low],'k--','Linewidth',1)
   end
   set (gca, 'Fontsize', 10)
else
   varargout{1}=signal;
end
   

% -----------------------------------------------------
function y_int= interpolate(y,nDegree)
% -----------------------------------------------------
% linear (nDegree=1) or quadratic (nDegree=2)
% interpolation
% y - original function
% y_int - interpolated function

x= 1:length(y);
if nDegree==1
   % Linear interpolation
   polyPar=polyfit(x,y,1);
   y_int= polyPar(2)+polyPar(1)*x;
elseif nDegree==2
   % Quadratic interpolation
   polyPar=polyfit(x,y,2);
   y_int= polyPar(3)+polyPar(2)*x+polyPar(1)*x.*x;
else
   error('nDegree must be 1 or 2');
end


% -----------------------------------------------------
function y=Gauss(x,mu,sigma)
% -----------------------------------------------------
% Gaussian with mean mu
% INPUT
% x: vector
% sigma: scalar
% mu: scalar
% OUTPUT
% y: vector
x=x-mu;
arg= x.*x;
arg= arg./2;
arg= arg./(sigma^2);
arg= -arg;
Z= sqrt(2*pi)*sigma;
y= exp(arg)/Z;

% -----------------------------------------------------
function y=MixGauss(x,mu,sigma,a)
% -----------------------------------------------------
% Mixture of Gaussians
% INPUT
% x: vector
% mu: vector of means
% sigma: vector of standard deviations
% a: vector of weights= prior probabilities
% OUTPUT
% y: vector

K= length(mu);
if length(sigma)~=K | length(a)~=K
   error('mu, sigma, a must have the same lengths');
end
if sum(a)~=1
   a = a./sum(a);
end

y=zeros(1,length(x));
for k=1:K
    y= y+a(k)*Gauss(x,mu(k),sigma(k));
end

% -----------------------------------------------------
function posterior=Posterior(x,mu,sigma,a)
% -----------------------------------------------------
% Posterior probabilities
% INPUT
% x: vector
% mu: vector of means
% sigma: vector of standard deviations
% a: vector of weights= prior probabilities
% OUTPUT
% posterior: vector, posterior probability for first kernel
%            for all data points in vector x
K= length(mu);
if length(sigma)~=K | length(a)~=K
   error('mu, sigma, a must have the same lengths');
end
if sum(a)~=1
   a = a./sum(a);
end

N=length(x);
posterior= zeros(K,N);

for k=1:K
    posterior(k,:)= a(k)*Gauss(x,mu(k),sigma(k))./MixGauss(x,mu,sigma,a);
end

% -----------------------------------------------------
function [new_mu,new_sigma,new_a]=EMstep(x,mu,sigma,a)
% -----------------------------------------------------
% INPUT
% x: vector
% mu: vector of means
% sigma: vector of standard deviations
% a: vector of weights= prior probabilities
% OUTPUT
% New parameters
% new_mu
% new_sigma: vector with two elements
% new_a: scalar, prior probability for first kernel
K= length(mu);
if length(sigma)~=K | length(a)~=K
   error('mu, sigma, a must have the same lengths');
end
if sum(a)~=1
   a = a./sum(a);
end

N= length(x);
posterior=Posterior(x,mu,sigma,a);

for k=1:K
    new_a(k)= sum(posterior(k,:))/N;
    new_mu(k)= posterior(k,:)*x';
    new_mu(k)= new_mu(k)/(N*new_a(k)); 
    sum_of_squares=(x-mu(k)).*(x-mu(k));
    new_sigma(k)= posterior(k,:)*sum_of_squares';
    new_sigma(k)= new_sigma(k)/(N*new_a(k)); 
    new_sigma(k)= sqrt(new_sigma(k));
end


% -----------------------------------------------------
function [new_mu,new_sigma,new_a]=EM(x,mu,sigma,a,Nsteps,...
flag_mu,flag_sigma,flag_a)
% -----------------------------------------------------
% INPUT
% x: vector
% mu: vector of means
% sigma: vector of standard deviations
% a: vector of weights= prior probabilities
% Nsteps; EM training steps
% flag_X: Flag variables to indicate which parameters
%         shall be updated.
%          0 --> no update
%          1 --> flexible update
%         -1 --> constrained update: all parameters 
%                are the same (only makes sense for 
%                the sigmas) 
% OUTPUT
% New parameters
% new_mu: vector of means
% new_sigma: vector  of standard deviations
% new_a: vector of weights= prior probabilities
for n=1:Nsteps
    [new_mu,new_sigma,new_a]=EMstep(x,mu,sigma,a);
    if flag_mu
       mu= new_mu;   
    end
    if flag_sigma
       sigma= new_sigma; 
       if flag_sigma<0
          average_sigma= mean(sigma);
          sigma= average_sigma*ones(1,length(sigma));
       end 
    end
    if flag_a
       a= new_a;  
    end
end
new_mu=mu;
new_sigma=sigma;
new_a=a;

% -----------------------------------------------------
function varargout=Discretization(x,K)
% -----------------------------------------------------
% Discretizes signal x. mu, sigma and a are the parameters
% of the Gaussina mixture model, which can be retrained
% over N_train EM steps.
% INPUT
% x: vector
% mu: vector of means
% sigma: vector of standard deviations
% a: vector of weights= prior probabilities
% Ntrain: number of training steps. 
% OUTPUT
% class_labels: vector of class labels for all data
% -1: underexpressed
% 0: not differently expressed
% 1: overexpressed
% There are two modes: 
% K==2: fitting a two component Gaussian with means
%       constrained to 0. 
% K==3: Fitting a three component Gaussian with all
%       all parameters tied except for mu
%       (fuzzy K-means)

Ntrain=50; % Number of training steps
if K==2
   mu=[0 0];
   sigma=[0.25 1.0];
   a= [0.5 0.5];
   flag_mu=0;
   flag_sigma=1;
   flag_a=1; 
elseif K==3
   mu= [-0.5 0 0.5];
   %sigma= [0.3 0.3 0.3];
   sigma= [1 1 1]/3; 
   a= [1 1 1]/3;
   flag_mu=1;
   flag_sigma=-1;
   flag_a=0; 
else
   error('Can only deal with K=2,3'); 
end

if Ntrain>0
   [new_mu,new_sigma,new_a]=EM(x,mu,sigma,a,Ntrain,flag_mu,flag_sigma,flag_a);
   mu=new_mu;
   sigma=new_sigma;
   a= new_a;
end 
mu=new_mu
sigma=new_sigma
a= new_a

[thresh_low,thresh_high]=ClassBoundaries(mu,sigma,a);
class_labels= -(x<thresh_low)+(x>thresh_high);

varargout{1}=class_labels;
if nargout>1
   [thresh_low,thresh_high]=ClassBoundaries(mu,sigma,a);
   varargout{2}=thresh_low;
   varargout{3}=thresh_high;
end

% Diagnostic plot of mixture of Gaussians and 
% the posterior probability.
% Usually disabled to prevent the plot of too many
% figures on the screen.
if 0
   figure(2)
   clf
   PlotMixGaussPosterior(mu,sigma,a)
end

% -----------------------------------------------------------
function [thresh_low,thresh_high]=ClassBoundaries(mu,sigma,a)
% -----------------------------------------------------------
K= length(mu);
if length(sigma)~=K | length(a)~=K
   error('mu, sigma, a must have the same lengths');
end
if sum(a)~=1
   a = a./sum(a);
end

Bottom=-2;
Top= 2;
Step=0.01;
x=Bottom:Step:Top;
posterior=Posterior(x,mu,sigma,a);

if K==2
   [stercus,class_labels]=max(posterior,[],1);
   class_labels=class_labels-1;
   class_labels= class_labels.*sign(x);
   thresh_low= Bottom+Step*sum(class_labels==-1);
   thresh_high= Top-Step*sum(class_labels==1);
elseif K==3
    [stercus,class_labels]=max(posterior,[],1);
    class_labels=class_labels-2;
    thresh_low=Bottom;
    thresh_high=Top;
    n=1;
    while class_labels(n)==-1
          thresh_low=thresh_low+Step;
          n=n+1;
    end
    n= length(posterior);
    while class_labels(n)==1
          thresh_high=thresh_high-Step;
          n=n-1;
    end
else
    error('Can only deal with K=2,3'); 
end

% -----------------------------------------------------
function PlotMixGaussPosterior(mu,sigma,a)
% -----------------------------------------------------
% Plots mixture of Gaussians and the posterior
% probability for diagnostics.
% Invoke this function in function Discretization
x= -2:0.02:2;
posterior=Posterior(x,mu,sigma,a);

subplot(2,1,2)
plot(x,posterior(1,:),'r--','LineWidth',2);
hold on
plot(x,posterior(2,:),'b-.','LineWidth',2);
hold on
plot(x,posterior(3,:),'g-','LineWidth',2);
axis([-2 2 -0.1 1.1]); 

subplot(2,1,1)
a= 1/3*[1 0 0];
mixGauss=MixGauss(x,mu,sigma,a);
plot(x,mixGauss,'r--','LineWidth',2);
hold on
a= 1/3*[0 1 0];
mixGauss=MixGauss(x,mu,sigma,a);
plot(x,mixGauss,'b-.','LineWidth',2);
hold on
a= 1/3*[0 0 1];
mixGauss=MixGauss(x,mu,sigma,a);
plot(x,mixGauss,'g-','LineWidth',2);

