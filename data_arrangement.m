clear all
close all

temp1=zeros(10,100);
temp2=zeros(10,100);
temp3=zeros(10,100);
temp4=zeros(10,100);
threshold=0.2;

for i=1:10
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Disleksi_' num2str(i)])
   temp=dlmread(['PosteriorProbType3_disleksi_before_' num2str(i) '.txt'],'\t');
   temp=temp.*(temp>threshold);
   xlswrite(['disleksi_before_' num2str(i)],temp,'PosteriorProbType3')
   for j=1:10
       temp1(i,(j-1)*10+1:j*10)=temp(j,:);
   end
   
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Disleksi_' num2str(i)])
   temp=dlmread(['PosteriorProbType3_disleksi_after_' num2str(i) '.txt'],'\t');
   temp=temp.*(temp>threshold);
   xlswrite(['disleksi_after_' num2str(i)],temp,'PosteriorProbType3')
   for j=1:10
       temp2(i,(j-1)*10+1:j*10)=temp(j,:);
   end
  
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kontrol_' num2str(i)])
   temp=dlmread(['PosteriorProbType3_kontrol_before_' num2str(i) '.txt'],'\t');
   temp=temp.*(temp>threshold);
   xlswrite(['kontrol_before_' num2str(i)],temp,'PosteriorProbType3')
   for j=1:10
       temp3(i,(j-1)*10+1:j*10)=temp(j,:);
   end
   
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kontrol_' num2str(i)])
   temp=dlmread(['PosteriorProbType3_kontrol_after_' num2str(i) '.txt'],'\t');
   temp=temp.*(temp>threshold);
   xlswrite(['kontrol_after_' num2str(i)],temp,'PosteriorProbType3')
   for j=1:10
       temp4(i,(j-1)*10+1:j*10)=temp(j,:);
   end
   
end

cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
xlswrite('individual_data',temp1,'disleksi_before')
xlswrite('individual_data',temp2,'disleksi_after')
xlswrite('individual_data',temp3,'kontrol_before')
xlswrite('individual_data',temp4,'kontrol_after')
   
   