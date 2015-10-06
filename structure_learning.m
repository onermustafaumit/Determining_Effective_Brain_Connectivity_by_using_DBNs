clear all

%%
load disleksi_before
load disleksi_after
load kontrol_before
load kontrol_after
load mcmcPAR
threshold=0.2;


%% Dyslexia group individual analysis

% % Before stimulus analysis
% for i=1:10
%     close all
%     Results=DBmcmc_Application('data',disleksi_before{i},'mcmcPAR',mcmcPAR);
%     mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Disleksi_' num2str(i)])
%     cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Disleksi_' num2str(i)])
%     save(['Results_disleksi_before_' num2str(i) '.mat'],'Results','-mat');
%     h1=figure(1);
%     h2=figure(2);
%     h3=figure(3);
%     saveas(h1,['AcceptanceRatio_disleksi_before_' num2str(i) '.png'],'png'); 
%     saveas(h2,['NumOfEdges_disleksi_before_' num2str(i) '.png'],'png'); 
%     saveas(h3,['ProportionOfEdges_disleksi_before_' num2str(i) '.png'],'png');
%     cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
%     
%     % Posterior probabilities and their graphical representation
%     close all
%     posterior=Results{1}.INTERposterior;
%     [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
%     cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Disleksi_' num2str(i)])
%     dlmwrite(['PosteriorProbType1_disleksi_before_' num2str(i) '.txt'],type1_posterior,'delimiter','\t','precision',2)
%     dlmwrite(['PosteriorProbType2_disleksi_before_' num2str(i) '.txt'],type2_posterior,'delimiter','\t','precision',2)
%     dlmwrite(['PosteriorProbType3_disleksi_before_' num2str(i) '.txt'],type3_posterior,'delimiter','\t','precision',2)
%     h1=figure(1);
%     h2=figure(2);
%     h3=figure(3);
%     saveas(h1,['Type1Drawing_disleksi_before_' num2str(i) '.png'],'png'); 
%     saveas(h2,['Type2Drawing_disleksi_before_' num2str(i) '.png'],'png'); 
%     saveas(h3,['Type3Drawing_disleksi_before_' num2str(i) '.png'],'png');
%     cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
% end

% After stimulus analysis

for i=1:10
    close all
    Results=DBmcmc_Application('data',disleksi_after{i},'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Disleksi_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Disleksi_' num2str(i)])
    save(['Results_disleksi_after_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_disleksi_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Disleksi_' num2str(i)])
    dlmwrite(['PosteriorProbType1_disleksi_after_' num2str(i) '.txt'],type1_posterior,'delimiter','\t','precision',2)
    dlmwrite(['PosteriorProbType2_disleksi_after_' num2str(i) '.txt'],type2_posterior,'delimiter','\t','precision',2)
    dlmwrite(['PosteriorProbType3_disleksi_after_' num2str(i) '.txt'],type3_posterior,'delimiter','\t','precision',2)
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_disleksi_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end


%% Control group individual analysis

% Before stimulus analysis
for i=1:10
    close all
    Results=DBmcmc_Application('data',kontrol_before{i},'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kontrol_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kontrol_' num2str(i)])
    save(['Results_kontrol_before_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_kontrol_before_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kontrol_' num2str(i)])
    dlmwrite(['PosteriorProbType1_kontrol_before_' num2str(i) '.txt'],type1_posterior,'delimiter','\t','precision',2)
    dlmwrite(['PosteriorProbType2_kontrol_before_' num2str(i) '.txt'],type2_posterior,'delimiter','\t','precision',2)
    dlmwrite(['PosteriorProbType3_kontrol_before_' num2str(i) '.txt'],type3_posterior,'delimiter','\t','precision',2)
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_kontrol_before_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end

% After stimulus analysis

for i=1:10
    close all
    Results=DBmcmc_Application('data',kontrol_after{i},'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kontrol_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kontrol_' num2str(i)])
    save(['Results_kontrol_after_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_kontrol_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kontrol_' num2str(i)])
    dlmwrite(['PosteriorProbType1_kontrol_after_' num2str(i) '.txt'],type1_posterior,'delimiter','\t','precision',2)
    dlmwrite(['PosteriorProbType2_kontrol_after_' num2str(i) '.txt'],type2_posterior,'delimiter','\t','precision',2)
    dlmwrite(['PosteriorProbType3_kontrol_after_' num2str(i) '.txt'],type3_posterior,'delimiter','\t','precision',2)
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_kontrol_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end

