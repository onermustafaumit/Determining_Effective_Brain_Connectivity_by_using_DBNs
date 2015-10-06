clear all

%%
load disleksi_before
load disleksi_after
load kontrol_before
load kontrol_after
load mcmcPAR
threshold=0.2;


%% Dyslexia group k-fold analysis

% Before stimulus analysis
for i=1:10
    close all
    kfold_data=[];
    for j=1:10
        if j~=i
            kfold_data=[kfold_data,disleksi_before{i}];
        end
    end
    Results=DBmcmc_Application('data',kfold_data,'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Kfold_Disleksi_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Kfold_Disleksi_' num2str(i)])
    save(['Results_kfold_disleksi_before_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_kfold_disleksi_before_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_kfold_disleksi_before_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_kfold_disleksi_before_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Kfold_Disleksi_' num2str(i)])
    xlswrite(['kfold_disleksi_before_' num2str(i)],type1_posterior,'PosteriorProbType1')
    xlswrite(['kfold_disleksi_before_' num2str(i)],type2_posterior,'PosteriorProbType2')
    xlswrite(['kfold_disleksi_before_' num2str(i)],type3_posterior,'PosteriorProbType3')
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_kfold_disleksi_before_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_kfold_disleksi_before_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_kfold_disleksi_before_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end

% After stimulus analysis

for i=1:10
    close all
    kfold_data=[];
    for j=1:10
        if j~=i
            kfold_data=[kfold_data,disleksi_after{i}];
        end
    end
    Results=DBmcmc_Application('data',kfold_data,'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Kfold_Disleksi_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Kfold_Disleksi_' num2str(i)])
    save(['Results_kfold_disleksi_after_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_kfold_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_kfold_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_kfold_disleksi_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Kfold_Disleksi_' num2str(i)])
    xlswrite(['kfold_disleksi_after_' num2str(i)],type1_posterior,'PosteriorProbType1')
    xlswrite(['kfold_disleksi_after_' num2str(i)],type2_posterior,'PosteriorProbType2')
    xlswrite(['kfold_disleksi_after_' num2str(i)],type3_posterior,'PosteriorProbType3')
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_kfold_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_kfold_disleksi_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_kfold_disleksi_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end


%% Control group k-fold analysis

% Before stimulus analysis
for i=1:10
    close all
    kfold_data=[];
    for j=1:10
        if j~=i
            kfold_data=[kfold_data,kontrol_before{i}];
        end
    end
    Results=DBmcmc_Application('data',kfold_data,'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kfold_Kontrol_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kfold_Kontrol_' num2str(i)])
    save(['Results_kfold_kontrol_before_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_kfold_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_kfold_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_kfold_kontrol_before_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kfold_Kontrol_' num2str(i)])
    xlswrite(['kfold_kontrol_before_' num2str(i)],type1_posterior,'PosteriorProbType1')
    xlswrite(['kfold_kontrol_before_' num2str(i)],type2_posterior,'PosteriorProbType2')
    xlswrite(['kfold_kontrol_before_' num2str(i)],type3_posterior,'PosteriorProbType3')
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_kfold_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_kfold_kontrol_before_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_kfold_kontrol_before_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end

% After stimulus analysis

for i=1:10
    close all
    kfold_data=[];
    for j=1:10
        if j~=i
            kfold_data=[kfold_data,kontrol_after{i}];
        end
    end
    Results=DBmcmc_Application('data',kfold_data,'mcmcPAR',mcmcPAR);
    mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kfold_Kontrol_' num2str(i)])
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kfold_Kontrol_' num2str(i)])
    save(['Results_kfold_kontrol_after_' num2str(i) '.mat'],'Results','-mat');
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['AcceptanceRatio_kfold_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['NumOfEdges_kfold_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['ProportionOfEdges_kfold_kontrol_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
    
    % Posterior probabilities and their graphical representation
    close all
    posterior=Results{1}.INTERposterior;
    [type1_posterior, type2_posterior, type3_posterior]=analysis(posterior,threshold);
    cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kfold_Kontrol_' num2str(i)])
    xlswrite(['kfold_kontrol_after_' num2str(i)],type1_posterior,'PosteriorProbType1')
    xlswrite(['kfold_kontrol_after_' num2str(i)],type2_posterior,'PosteriorProbType2')
    xlswrite(['kfold_kontrol_after_' num2str(i)],type3_posterior,'PosteriorProbType3')
    h1=figure(1);
    h2=figure(2);
    h3=figure(3);
    saveas(h1,['Type1Drawing_kfold_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h2,['Type2Drawing_kfold_kontrol_after_' num2str(i) '.png'],'png'); 
    saveas(h3,['Type3Drawing_kfold_kontrol_after_' num2str(i) '.png'],'png');
    cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
end

