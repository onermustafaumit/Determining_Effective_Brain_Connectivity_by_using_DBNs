clear all
close all

temp1=zeros(10,100);
temp2=zeros(10,100);
temp3=zeros(10,100);
temp4=zeros(10,100);
threshold=0.9;

for i=1:10
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Kfold_Disleksi_' num2str(i)])
   temp=xlsread(['kfold_disleksi_before_' num2str(i)],'PosteriorProbType3','A1:J10');
   temp=temp.*(temp>=threshold);
   for j=1:10
       temp1(i,(j-1)*10+1:j*10)=temp(j,:);
   end
   
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Kfold_Disleksi_' num2str(i)])
   temp=xlsread(['kfold_disleksi_after_' num2str(i)],'PosteriorProbType3','A1:J10');
   temp=temp.*(temp>=threshold);
   for j=1:10
       temp2(i,(j-1)*10+1:j*10)=temp(j,:);
   end
      
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kfold_Kontrol_' num2str(i)])
   temp=xlsread(['kfold_kontrol_before_' num2str(i)],'PosteriorProbType3','A1:J10');
   temp=temp.*(temp>=threshold);
   for j=1:10
       temp3(i,(j-1)*10+1:j*10)=temp(j,:);
   end
      
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kfold_Kontrol_' num2str(i)])
   temp=xlsread(['kfold_kontrol_after_' num2str(i)],'PosteriorProbType3','A1:J10');
   temp=temp.*(temp>=threshold);
   for j=1:10
       temp4(i,(j-1)*10+1:j*10)=temp(j,:);
   end
   
end

cd('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project')
xlswrite('kfold_data',temp1,'disleksi_before')
xlswrite('kfold_data',temp2,'disleksi_after')
xlswrite('kfold_data',temp3,'kontrol_before')
xlswrite('kfold_data',temp4,'kontrol_after')
   