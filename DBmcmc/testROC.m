% Solution to Problem sheet 4, exercise 1
% Dirk Husmeier, 26 May 2003

clear

% ---------------------------------------------
% 1) Solution 'by hand'
% ---------------------------------------------
% TP --> true positives, absolute values
% FP --> false postives, absolute value
% NTP --> total number of true positives
% NFP --> total number of false positives
% pTP --> true positives, proportions
% pFP --> false postives, proprtions

NTP= 2;
NFP= 7;

% Threshold 1.0
TP(1)=0;
FP(1)=0;
% Threshold 0.75
TP(2)=1;
FP(2)=1;
% Threshold 0.5
TP(3)=1;
FP(3)=3;
% Threshold 0.25
TP(4)=2;
FP(4)=4;
% Threshold 0.0
TP(5)=2;
FP(5)=7;

pTP=TP/NTP;
pFP=FP/NFP;

% ---------------------------------------------
% Plot the ROC curve
% ---------------------------------------------
figure(1)
clf
plot([0,1],[0,1],'g--','LineWidth',2)
hold on
plot(pFP,pTP,'b-','LineWidth',3);
axis('square')
axis([-0.02 1.02 -0.02 1.02])
set (gca, 'Fontsize', 15)
xlabel('False positives')
ylabel('True positives')

% ---------------------------------------------
% 2) Use DBmcmc to plot the ROC curve
% ---------------------------------------------
figure(2)
clf
INTERtrue= [0 0 1; 0 0 1; 0 0 0];
INTERposterior= [0 0.75 0.75; 0.5 0.5 0.25; 0 0 0.25];
Results{1}.INTERposterior=INTERposterior;
DBmcmc_ROC(INTERtrue,Results)
