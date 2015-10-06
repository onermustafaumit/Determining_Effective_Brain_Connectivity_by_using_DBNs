
clear all
close all

%% quantize dyslexia group data
cd ('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DATA\disleksi')
for i=1:10
    load (['d',num2str(i)])
    disleksi{i}=[O1; O2; P3; P4; P7; P8; T7; T8; C3; C4; F3; F4; F7; F8];
    quan_disleksi{i}=zeros(14,2000);
    dis_mean{i}=mean(disleksi{i},2);
    dis_std{i}=std(disleksi{i},0,2);
    mean_minus_std=repmat((dis_mean{i}-dis_std{i}),1,2000);
    mean_plus_std=repmat((dis_mean{i}+dis_std{i}),1,2000);
    quan_disleksi{i}(disleksi{i}<mean_minus_std)=-1;
    quan_disleksi{i}(disleksi{i}>mean_plus_std)=1;
    disleksi_before{i}=quan_disleksi{i}(:,501:901); %data points between -500ms to -100ms
    disleksi_after{i}=quan_disleksi{i}(:,1101:1501); %data points between 100ms to 500ms
end

%% quantize control group data
cd ('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DATA\kontrol')
for i=1:10
    load (['k',num2str(i)])
    kontrol{i}=[O1; O2; P3; P4; P7; P8; T7; T8; C3; C4; F3; F4; F7; F8];
    quan_kontrol{i}=zeros(14,2000);
    kont_mean{i}=mean(kontrol{i},2);
    kont_std{i}=std(kontrol{i},0,2);
    mean_minus_std=repmat((kont_mean{i}-kont_std{i}),1,2000);
    mean_plus_std=repmat((kont_mean{i}+kont_std{i}),1,2000);
    quan_kontrol{i}(kontrol{i}<mean_minus_std)=-1;
    quan_kontrol{i}(kontrol{i}>mean_plus_std)=1;
    kontrol_before{i}=quan_kontrol{i}(:,501:901); %data points between -500ms to -100ms
    kontrol_after{i}=quan_kontrol{i}(:,1101:1501); %data points between 100ms to 500ms
end

%% go to home directory, and save the files
cd ('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
save('disleksi_before.mat','disleksi_before','-mat');
save('disleksi_after.mat','disleksi_after','-mat');
save('dis_mean.mat','dis_mean','-mat');
save('dis_std.mat','dis_std','-mat');
save('kontrol_before.mat','kontrol_before','-mat');
save('kontrol_after.mat','kontrol_after','-mat');
save('kont_mean.mat','kont_mean','-mat');
save('kont_std.mat','kont_std','-mat');
