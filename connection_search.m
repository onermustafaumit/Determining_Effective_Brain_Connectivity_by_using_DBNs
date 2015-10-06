clear all
close all

currentFolder = pwd;

temp1=zeros(10,100);
temp2=zeros(10,100);
temp3=zeros(10,100);
temp4=zeros(10,100);
threshold=0.2;

for i=1:10
   temp=[];
   fprintf(1,'\nDyslexia Group - Before Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\BeforeStimulus\Disleksi_' num2str(i)])
   adj_matrix=dlmread(['PosteriorProbType3_disleksi_before_' num2str(i) '.txt'],'\t');
   adj_matrix=(adj_matrix>threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp1(i,:)=temp;
   
   temp=[];
   fprintf(1,'\nDyslexia Group - After Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\DyslexiaGroup\AfterStimulus\Disleksi_' num2str(i)])
   adj_matrix=dlmread(['PosteriorProbType3_disleksi_after_' num2str(i) '.txt'],'\t');
   adj_matrix=(adj_matrix>threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp2(i,:)=temp;
   
   temp=[];
   fprintf(1,'\nControl Group - Before Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\BeforeStimulus\Kontrol_' num2str(i)])
   adj_matrix=dlmread(['PosteriorProbType3_kontrol_before_' num2str(i) '.txt'],'\t');
   adj_matrix=(adj_matrix>threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp3(i,:)=temp;
   
   temp=[];
   fprintf(1,'\nControl Group - After Stimulus - Subject%d  \n',i);
   cd(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\ControlGroup\AfterStimulus\Kontrol_' num2str(i)])
   adj_matrix=dlmread(['PosteriorProbType3_kontrol_after_' num2str(i) '.txt'],'\t');
   adj_matrix=(adj_matrix>threshold);
   cd(currentFolder)
   for start_node=1:10
       distance=bfs(adj_matrix,start_node);
       temp=[temp,distance'];
   end
   temp4(i,:)=temp;
     
end

xlswrite('connectivity_distances',temp1,'dyslexia_before')
xlswrite('connectivity_distances',temp2,'dyslexia_after')
xlswrite('connectivity_distances',temp3,'control_before')
xlswrite('connectivity_distances',temp4,'control_after')
   
   
   