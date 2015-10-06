function [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold)
close all

%%
O1=1; O2=2; P3=3; P4=4; P7=5; P8=6; T7=7;
T8=8; C3=9; C4=10; F3=11; F4=12; F7=13; F8=14;

%%

% Construct Type1 posterior prob. table with one decimal point precision
type1_posterior=round(posterior*10)/10; 
drawDBNType1(type1_posterior,threshold);

%%
type2_posterior=posterior;

% P region on the left hemisphere 
type2_posterior(P3,:)=type2_posterior(P3,:)+type2_posterior(P7,:);
type2_posterior(:,P3)=type2_posterior(:,P3)+type2_posterior(:,P7);

% P region on the right hemisphere 
type2_posterior(P4,:)=type2_posterior(P4,:)+type2_posterior(P8,:);
type2_posterior(:,P4)=type2_posterior(:,P4)+type2_posterior(:,P8);

% F region on the left hemisphere 
type2_posterior(F3,:)=type2_posterior(F3,:)+type2_posterior(F7,:);
type2_posterior(:,F3)=type2_posterior(:,F3)+type2_posterior(:,F7);

% F region on the right hemisphere 
type2_posterior(F4,:)=type2_posterior(F4,:)+type2_posterior(F8,:);
type2_posterior(:,F4)=type2_posterior(:,F4)+type2_posterior(:,F8);

%Remove unnecessary rows and columns
type2_posterior(P7,:)=[];
type2_posterior(:,P7)=[];
type2_posterior(P8-1,:)=[];
type2_posterior(:,P8-1)=[];
type2_posterior(F7-2,:)=[];
type2_posterior(:,F7-2)=[];
type2_posterior(F8-3,:)=[];
type2_posterior(:,F8-3)=[];

% Construct Type2 posterior prob. table with one decimal point precision
type2_posterior=round(type2_posterior*10)/10;
drawDBNType2(type2_posterior,threshold);

%%
% Construct Type3 posterior prob. table with one decimal point precision
temp=zeros(10,10);
a=0;
for i=1:5
    temp(:,i)=type2_posterior(:,i+a);
    temp(:,i+5)=type2_posterior(:,i+1+a);
    a=a+1;
end
type3_posterior=zeros(10,10);
a=0;
for i=1:5
    type3_posterior(i,:)=temp(i+a,:);
    type3_posterior(i+5,:)=temp(i+1+a,:);
    a=a+1; 
end

drawDBNType3(type3_posterior,threshold);


