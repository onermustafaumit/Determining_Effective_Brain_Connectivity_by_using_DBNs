function VisualizeSpellData
% VisualizeSpellData - visualizes Spellman's yeast data
% 
% USAGAGE
% VisualizeSpellData
% You will be asked interactively which time series
% of which gene you want to see.
%
% INVOCATION
% SpellYeast.m
% 

flag_gene= input('ACE2(1),MYO1(2),CLB2(3),ALK1(4),CDC5(5),SVS1(6),MNN1(7),CLN2(8),RAD51(9),RNR3(10),CLN1(11),SRO4(12)');

if flag_gene==1
   gene='ACE2'
elseif flag_gene==2
   gene='MYO1'
elseif flag_gene==3
   gene='CLB2'
elseif flag_gene==4
   gene='ALK1'
elseif flag_gene==5
   gene='CDC5'
elseif flag_gene==6
   gene='SVS1'
elseif flag_gene==7
   gene='MNN1'
elseif flag_gene==8
   gene='CLN2'
elseif flag_gene==9
   gene='RAD51'
elseif flag_gene==10
   gene='RNR3'
elseif flag_gene==11
   gene='CLN1'
elseif flag_gene==12
   gene='SRO4'
else
   error('Wrong input')
end

flag_series= input('alpha:1, cdc15:2, cdc28:3, elu:4');
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

figure(1)
clf
SpellYeast(gene,series,'detrend','none')
figure(2)
clf
SpellYeast(gene,series,'detrend','linear')
figure(3)
clf
SpellYeast(gene,series,'detrend','quadratic')
%figure(3)
%clf
%SpellYeast(gene,series,'detrend','linear','discretize',1)

