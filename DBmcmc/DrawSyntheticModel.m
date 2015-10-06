function inter=DrawSyntheticModel
% Draws and writes out the inter matrix of the true network
% INPUT
% none
%
% OUTPUT
% inter= inter matrix
%
% INVOCATION
% inter= DrawSyntheticModel
% 

clf

% --------------------------------------------------
% Make true architectur
% --------------------------------------------------

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

Names={'RNR3','CLN1','SRO4','RAD51','CLB2','MYO1','ACE2','ALK1','MNN1','CLN2','SVS1','CDC5'};

nNodes=12;
inter= zeros(nNodes,nNodes);

inter(CLN2,[RNR3,CLN1,SRO4,RAD51,SVS1])=1;
inter(SVS1,MNN1)=1;
inter(ACE2,CDC5)=1;
inter(CDC5,[SVS1,CLB2,MYO1,ALK1])=1;

draw_layout(inter);

