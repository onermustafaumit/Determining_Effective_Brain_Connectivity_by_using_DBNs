function varargout=SpellYeastMakeTrainingData(varargin)
% Training set:  rows are genes and columns are time points.
% Genes are includes in the following order, from top
% to bottom:
% ACE2, MYO1, CLB2, ALK1, CDC5, SVS1
% MNN1, CLN2, RAD51, RNR3, CLN1, SRO4 
%
% INPUT
% None --> Parameters set interactively
% OR
% flag_series ('alpha:1, cdc15:2, cdc28:3, elu:4')
% flag_detrend ('Detrend: none(0), linear(1), quadratic(2)')
%
% OUTPUT
% If an output argument is specified, the data will be written
% out to it, otherwise they will be written out to file.
%
% EXAMPLE
% MakeTrainingData OR x=MakeTrainingData OR
% MakeTrainingData(flag_series,flag_detrend)

if nargin==0
   % No argument: inputs obtained interactively
   flag_series= input('alpha:1, cdc15:2, cdc28:3, elu:4');
   flag_detrend= input('Detrend: none(0), linear(1), quadratic(2)');
elseif nargin==2
   flag_series=varargin{1};
   flag_detrend=varargin{2};
else
   error('Wrong number of arguments')
end

% --> Series
if flag_series==1
   series='alpha';
elseif flag_series==2
   series='cdc15';
elseif flag_series==3
   series='cdc28';
elseif flag_series==4
   series='elu';
else
   error('Wrong input')
end

% --> Detrending
if flag_detrend==0
   detrend_option='none';
elseif flag_detrend==1
   detrend_option='linear';
elseif flag_detrend==2
   detrend_option='quadratic';
else
   error('Wrong detrend option');
end

x(1,:)=SpellYeast('ACE2',series,'detrend',detrend_option,'discretize',1);
x(2,:)=SpellYeast('MYO1',series,'detrend',detrend_option,'discretize',1);
x(3,:)=SpellYeast('CLB2',series,'detrend',detrend_option,'discretize',1);
x(4,:)=SpellYeast('ALK1',series,'detrend',detrend_option,'discretize',1);
x(5,:)=SpellYeast('CDC5',series,'detrend',detrend_option,'discretize',1);
x(6,:)=SpellYeast('SVS1',series,'detrend',detrend_option,'discretize',1);
x(7,:)=SpellYeast('MNN1',series,'detrend',detrend_option,'discretize',1);
x(8,:)=SpellYeast('CLN2',series,'detrend',detrend_option,'discretize',1);
x(9,:)=SpellYeast('RAD51',series,'detrend',detrend_option,'discretize',1);
x(10,:)=SpellYeast('RNR3',series,'detrend',detrend_option,'discretize',1);
x(11,:)=SpellYeast('CLN1',series,'detrend',detrend_option,'discretize',1);
x(12,:)=SpellYeast('SRO4',series,'detrend',detrend_option,'discretize',1);

if nargout==0
   save train.mat x;
else
   varargout{1}=x;
end
