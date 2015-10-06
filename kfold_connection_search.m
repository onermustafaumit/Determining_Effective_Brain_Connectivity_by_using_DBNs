clear all
close all

currentFolder = pwd;

temp1=zeros(10,100);
temp2=zeros(10,100);
temp3=zeros(10,100);
temp4=zeros(10,100);
threshold=0.9;

for i=1:10
   temp=[];
   fprintf(1,'\nDyslexia Group - Before Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Kfold_Disleksi_' num2str(i)])
   adj_matrix=xlsread(['kfold_disleksi_before_' num2str(i)],'PosteriorProbType3','A1:J10');
   adj_matrix=(adj_matrix>=threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp1(i,:)=temp;
   
   temp=[];
   fprintf(1,'\nDyslexia Group - After Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Kfold_Disleksi_' num2str(i)])
   adj_matrix=xlsread(['kfold_disleksi_after_' num2str(i)],'PosteriorProbType3','A1:J10');
   adj_matrix=(adj_matrix>=threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp2(i,:)=temp;
   
   temp=[];
   fprintf(1,'\nControl Group - Before Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kfold_Kontrol_' num2str(i)])
   adj_matrix=xlsread(['kfold_kontrol_before_' num2str(i)],'PosteriorProbType3','A1:J10');
   adj_matrix=(adj_matrix>=threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp3(i,:)=temp;
   
   temp=[];
   fprintf(1,'\nControl Group - After Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kfold_Kontrol_' num2str(i)])
   adj_matrix=xlsread(['kfold_kontrol_after_' num2str(i)],'PosteriorProbType3','A1:J10');
   adj_matrix=(adj_matrix>=threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp4(i,:)=temp;
     
end

xlswrite('kfold_connectivity_distances',temp1,'dyslexia_before')
xlswrite('kfold_connectivity_distances',temp2,'dyslexia_after')
xlswrite('kfold_connectivity_distances',temp3,'control_before')
xlswrite('kfold_connectivity_distances',temp4,'control_after')
   
   
   