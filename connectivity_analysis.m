clear all
close all

global connections;
global connections2;
global dirname;

nodes={'Ol','Pl','Tl','Cl','Fl','Or','Pr','Tr','Cr','Fr'};

for i=1:10
   for j=1:10
      connections{1,(i-1)*10+j}=strcat(nodes{i},'*',nodes{j});
      connections2{1,(i-1)*10+j}=strcat(nodes{i},nodes{j});
   end
end

disleksi_before = xlsread('connectivity_distances.xls','dyslexia_before','A1:CV10');
disleksi_after = xlsread('connectivity_distances.xls','dyslexia_after','A1:CV10');
kontrol_before = xlsread('connectivity_distances.xls','control_before','A1:CV10');
kontrol_after = xlsread('connectivity_distances.xls','control_after','A1:CV10');

%%
threshold='02';
coeff=5;       %set threshold to choose a reachable edge as common if it exists in coeff=<# number of subjects
mean_threshold=0; %1*(coeff/10);   % set threshold to mean of reachable connection distances to draw DBN
dist_upper_limit=5;     % set upper limit on the distance to connect two nodes, connection two nodes connected wtih less than dist_upper_limit is valid
foldername=strcat('Common_Reachable_Connections_by_',num2str(coeff),'_10th_of_subjects_threshold_',threshold);
mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\' foldername])
dirname=strcat('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\',foldername);

% %% remove self-connections
% self_conn_indices=[1,12,23,34,45,56,67,78,89,100];
% kontrol_before(:,self_conn_indices)=0;
% kontrol_after(:,self_conn_indices)=0;
% disleksi_before(:,self_conn_indices)=0;
% disleksi_after(:,self_conn_indices)=0;

%% kontrol before (kb)
num_of_common_conn_kb=sum(kontrol_before>0 & kontrol_before<dist_upper_limit);
index_kb=find(num_of_common_conn_kb<coeff);
num_of_common_edges_kb=100-size(index_kb,2);
modified_kb=kontrol_before;
modified_kb(:,index_kb)=0;
modified_kb(modified_kb==-1)=0;
mean_modified_kb=mean(modified_kb);

type3_posterior_kb=[];
for i=1:10
    type3_posterior_kb=[type3_posterior_kb;mean_modified_kb(1,(i-1)*10+1:i*10);];
end
label=['Reachable Connections in ' num2str(coeff) '/10 of Control Before Subjects'];
drawDBNType3(type3_posterior_kb,mean_threshold,label);
h1=gcf;

necc_mean_kb=mean_modified_kb;
necc_mean_kb(:,index_kb)=[];
std_modified_kb=std(modified_kb);
necc_std_kb=std_modified_kb;
necc_std_kb(:,index_kb)=[];
conn_kb=connections;
conn_kb(:,index_kb)=[];

h2=figure;
errorbar(necc_mean_kb,necc_std_kb,'d','MarkerFaceColor','g','LineWidth',2)
set(gca, 'XTick',1:size(conn_kb,2), 'XTickLabel',conn_kb,'ylim',[0 4])
title('\mu±\sigma for Control Before Distances')

%% kontrol after (ka)
num_of_common_conn_ka=sum(kontrol_after>0 & kontrol_after<dist_upper_limit);
index_ka=find(num_of_common_conn_ka<coeff);
num_of_common_edges_ka=100-size(index_ka,2);
modified_ka=kontrol_after;
modified_ka(:,index_ka)=0;
modified_ka(modified_ka==-1)=0;
mean_modified_ka=mean(modified_ka);

type3_posterior_ka=[];
for i=1:10
    type3_posterior_ka=[type3_posterior_ka;mean_modified_ka(1,(i-1)*10+1:i*10);];
end 
label=['Reachable Connections in ' num2str(coeff) '/10 of Control After Subjects'];
drawDBNType3(type3_posterior_ka,mean_threshold,label);
h3=gcf;

necc_mean_ka=mean_modified_ka;
necc_mean_ka(:,index_ka)=[];
std_modified_ka=std(modified_ka);
necc_std_ka=std_modified_ka;
necc_std_ka(:,index_ka)=[];
conn_ka=connections;
conn_ka(:,index_ka)=[];

h4=figure;
errorbar(necc_mean_ka,necc_std_ka,'d','MarkerFaceColor','r','LineWidth',2)
set(gca, 'XTick',1:size(conn_ka,2), 'XTickLabel',conn_ka,'ylim',[0 4])
title('\mu±\sigma for Control After Distances')

%% disleksi before (db)
num_of_common_conn_db=sum(disleksi_before>0 & disleksi_before<dist_upper_limit);
index_db=find(num_of_common_conn_db<coeff);
num_of_common_edges_db=100-size(index_db,2);
modified_db=disleksi_before;
modified_db(:,index_db)=0;
modified_db(modified_db==-1)=0;
mean_modified_db=mean(modified_db);

type3_posterior_db=[];
for i=1:10
    type3_posterior_db=[type3_posterior_db;mean_modified_db(1,(i-1)*10+1:i*10);];
end
label=['Reachable Connections in ' num2str(coeff) '/10 of Dyslexia Before Subjects'];
drawDBNType3(type3_posterior_db,mean_threshold,label);
h5=gcf;

necc_mean_db=mean_modified_db;
necc_mean_db(:,index_db)=[];
std_modified_db=std(modified_db);
necc_std_db=std_modified_db;
necc_std_db(:,index_db)=[];
conn_db=connections;
conn_db(:,index_db)=[];

h6=figure;
errorbar(necc_mean_db,necc_std_db,'d','MarkerFaceColor','g','LineWidth',2)
set(gca, 'XTick',1:size(conn_db,2), 'XTickLabel',conn_db,'ylim',[0 4])
title('\mu±\sigma for Dyslexia Before Distances')

%% disleksi after (da)
num_of_common_conn_da=sum(disleksi_after>0 & disleksi_after<dist_upper_limit);
index_da=find(num_of_common_conn_da<coeff);
num_of_common_edges_da=100-size(index_da,2);
modified_da=disleksi_after;
modified_da(:,index_da)=0;
modified_da(modified_da==-1)=0;
mean_modified_da=mean(modified_da);

type3_posterior_da=[];
for i=1:10
    type3_posterior_da=[type3_posterior_da;mean_modified_da(1,(i-1)*10+1:i*10);];
end
label=['Reachable Connections in ' num2str(coeff) '/10 of Dyslexia After Subjects'];
drawDBNType3(type3_posterior_da,mean_threshold,label);
h7=gcf;

necc_mean_da=mean_modified_da;
necc_mean_da(:,index_da)=[];
std_modified_da=std(modified_da);
necc_std_da=std_modified_da;
necc_std_da(:,index_da)=[];
conn_da=connections;
conn_da(:,index_da)=[];

h8=figure;
errorbar(necc_mean_da,necc_std_da,'d','MarkerFaceColor','r','LineWidth',2)
set(gca, 'XTick',1:size(conn_da,2), 'XTickLabel',conn_da,'ylim',[0 4])
title('\mu±\sigma for Dyslexia After Distances')

%% Cross Connection Weights

drawCommonConn(conn_kb,necc_mean_kb,necc_std_kb,'Control Before',conn_ka,necc_mean_ka,necc_std_ka,'Control After');
h9=gcf;
drawCommonConn(conn_db,necc_mean_db,necc_std_db,'Dyslexia Before',conn_da,necc_mean_da,necc_std_da,'Dyslexia After');
h10=gcf;
drawCommonConn(conn_kb,necc_mean_kb,necc_std_kb,'Control Before',conn_db,necc_mean_db,necc_std_db,'Dyslexia Before');
h11=gcf;
drawCommonConn(conn_ka,necc_mean_ka,necc_std_ka,'Control After',conn_da,necc_mean_da,necc_std_da,'Dyslexia After');
h12=gcf;

% CommonConnANOVA(conn_kb,kontrol_before,'KB',conn_ka,kontrol_after,'KA');
% CommonConnANOVA(conn_db,disleksi_before,'DB',conn_da,disleksi_after,'DA');
% CommonConnANOVA(conn_kb,kontrol_before,'KB',conn_db,disleksi_before,'DB');
% CommonConnANOVA(conn_ka,kontrol_after,'KA',conn_da,disleksi_after,'DA');

%% Save Figures
set(findobj('Type','figure'),'Units','normalized','OuterPosition',[0 0 1 1]);
cd(dirname)
saveas(h1,'Reachable_Connections_DBN_for_Control_Before_Models.bmp','bmp');
saveas(h2,'Distances_for_Control_Before_Models.bmp','bmp');
saveas(h3,'Reachable_Connections_DBN_for_Control_After_Models.bmp','bmp');
saveas(h4,'Distances_for_Control_After_Models.bmp','bmp'); 
saveas(h5,'Reachable_Connections_DBN_for_Dyslexia_Before_Models.bmp','bmp');
saveas(h6,'Distances_for_Dyslexia_Before_Models.bmp','bmp');
saveas(h7,'Reachable_Connections_DBN_for_Dyslexia_After_Models.bmp','bmp');
saveas(h8,'Distances_for_Dyslexia_After_Models.bmp','bmp');
saveas(h9,'Distances_for_CB_and_CA_Models.bmp','bmp');
saveas(h10,'Distances_for_DB_and_DA_Models.bmp','bmp');
saveas(h11,'Distances_for_CB_and_DB_Models.bmp','bmp');
saveas(h12,'Distances_for_CA_and_DA_Models.bmp','bmp');
cd ..




