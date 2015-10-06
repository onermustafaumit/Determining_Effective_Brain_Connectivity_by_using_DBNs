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

disleksi_before = xlsread('kfold_data.xls','disleksi_before','A1:CV10');
disleksi_after = xlsread('kfold_data.xls','disleksi_after','A1:CV10');
kontrol_before = xlsread('kfold_data.xls','kontrol_before','A1:CV10');
kontrol_after = xlsread('kfold_data.xls','kontrol_after','A1:CV10');

%%
threshold='09';
coeff=5;       %set threshold to choose an edge as common if it exists in coeff=<# number of k-fold models
std_corr_coeff=9/(coeff-1);
std_offset_corr_coeff=(10-coeff)/(coeff-1);

foldername=strcat('DBNs_Shared_by_',num2str(coeff),'_10th_of_models_threshold_',threshold);
exist_return=exist(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\' foldername],'dir');
if (exist_return==7)
    rmdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\' foldername],'s'); 
end
mkdir(['C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\' foldername])
dirname=strcat('C:\Users\Balista Elektronik\Dropbox\Akademik\2014-Fall\EE732\project\',foldername);

%% remove self-connections
self_conn_indices=[1,12,23,34,45,56,67,78,89,100];
kontrol_before(:,self_conn_indices)=0;
kontrol_after(:,self_conn_indices)=0;
disleksi_before(:,self_conn_indices)=0;
disleksi_after(:,self_conn_indices)=0;

%% kontrol before (kb)
num_of_common_conn_kb=sum(kontrol_before>0);
index_kb=find(num_of_common_conn_kb<coeff);
num_of_common_edges_kb=100-size(index_kb,2);
modified_kb=kontrol_before;
modified_kb(:,index_kb)=0;
mean_modified_kb=(10/coeff)*mean(modified_kb);

type3_posterior_kb=[];
for i=1:10
    type3_posterior_kb=[type3_posterior_kb;mean_modified_kb(1,(i-1)*10+1:i*10);];
end
label=['DBN Connections Common in ' num2str(coeff) '/10 of K-fold Control Before Models'];
drawDBNType3(type3_posterior_kb,0,label);
h1=gcf;

necc_mean_kb=mean_modified_kb;
std_modified_kb=std_corr_coeff*std(modified_kb) - std_offset_corr_coeff*(necc_mean_kb.^2);
necc_std_kb=std_modified_kb;
necc_mean_kb(:,index_kb)=[];
necc_std_kb(:,index_kb)=[];
conn_kb=connections;
conn_kb(:,index_kb)=[];

h2=figure;
errorbar(necc_mean_kb,necc_std_kb,'d','MarkerFaceColor','g','LineWidth',2)
set(gca, 'XTick',1:size(conn_kb,2), 'XTickLabel',conn_kb,'ylim',[0 4])
title('\mu±\sigma for K-fold Control Before Data')

%% kontrol after (ka)
num_of_common_conn_ka=sum(kontrol_after>0);
index_ka=find(num_of_common_conn_ka<coeff);
num_of_common_edges_ka=100-size(index_ka,2);
modified_ka=kontrol_after;
modified_ka(:,index_ka)=0;
mean_modified_ka=(10/coeff)*mean(modified_ka);

type3_posterior_ka=[];
for i=1:10
    type3_posterior_ka=[type3_posterior_ka;mean_modified_ka(1,(i-1)*10+1:i*10);];
end 
label=['DBN Connections Common in ' num2str(coeff) '/10 of K-fold Control After Models'];
drawDBNType3(type3_posterior_ka,0,label);
h3=gcf;

necc_mean_ka=mean_modified_ka;
std_modified_ka=std_corr_coeff*std(modified_ka) - std_offset_corr_coeff*(necc_mean_ka.^2);
necc_std_ka=std_modified_ka;
necc_mean_ka(:,index_ka)=[];
necc_std_ka(:,index_ka)=[];
conn_ka=connections;
conn_ka(:,index_ka)=[];

h4=figure;
errorbar(necc_mean_ka,necc_std_ka,'d','MarkerFaceColor','r','LineWidth',2)
set(gca, 'XTick',1:size(conn_ka,2), 'XTickLabel',conn_ka,'ylim',[0 4])
title('\mu±\sigma for K-fold Control After Data')

%% disleksi before (db)
num_of_common_conn_db=sum(disleksi_before>0);
index_db=find(num_of_common_conn_db<coeff);
num_of_common_edges_db=100-size(index_db,2);
modified_db=disleksi_before;
modified_db(:,index_db)=0;
mean_modified_db=(10/coeff)*mean(modified_db);

type3_posterior_db=[];
for i=1:10
    type3_posterior_db=[type3_posterior_db;mean_modified_db(1,(i-1)*10+1:i*10);];
end
label=['DBN Connections Common in ' num2str(coeff) '/10 of K-fold Dyslexia Before Models'];
drawDBNType3(type3_posterior_db,0,label);
h5=gcf;

necc_mean_db=mean_modified_db;
std_modified_db=std_corr_coeff*std(modified_db) - std_offset_corr_coeff*(necc_mean_db.^2);
necc_std_db=std_modified_db;
necc_mean_db(:,index_db)=[];
necc_std_db(:,index_db)=[];
conn_db=connections;
conn_db(:,index_db)=[];

h6=figure;
errorbar(necc_mean_db,necc_std_db,'d','MarkerFaceColor','g','LineWidth',2)
set(gca, 'XTick',1:size(conn_db,2), 'XTickLabel',conn_db,'ylim',[0 4])
title('\mu±\sigma for K-fold Dyslexia Before Data')

%% disleksi after (da)
num_of_common_conn_da=sum(disleksi_after>0);
index_da=find(num_of_common_conn_da<coeff);
num_of_common_edges_da=100-size(index_da,2);
modified_da=disleksi_after;
modified_da(:,index_da)=0;
mean_modified_da=(10/coeff)*mean(modified_da);

type3_posterior_da=[];
for i=1:10
    type3_posterior_da=[type3_posterior_da;mean_modified_da(1,(i-1)*10+1:i*10);];
end
label=['DBN Connections Common in ' num2str(coeff) '/10 of K-fold Dyslexia After Models'];
drawDBNType3(type3_posterior_da,0,label);
h7=gcf;

necc_mean_da=mean_modified_da;
std_modified_da=std_corr_coeff*std(modified_da) - std_offset_corr_coeff*(necc_mean_da.^2);
necc_std_da=std_modified_da;
necc_mean_da(:,index_da)=[];
necc_std_da(:,index_da)=[];
conn_da=connections;
conn_da(:,index_da)=[];

h8=figure;
errorbar(necc_mean_da,necc_std_da,'d','MarkerFaceColor','r','LineWidth',2)
set(gca, 'XTick',1:size(conn_da,2), 'XTickLabel',conn_da,'ylim',[0 4])
title('\mu±\sigma for K-fold Dyslexia After Data')

%% Cross Connection Weights

drawCommonConn(conn_kb,necc_mean_kb,necc_std_kb,'Control Before',conn_ka,necc_mean_ka,necc_std_ka,'Control After');
h9=gcf;
drawCommonConn(conn_db,necc_mean_db,necc_std_db,'Dyslexia Before',conn_da,necc_mean_da,necc_std_da,'Dyslexia After');
h10=gcf;
drawCommonConn(conn_kb,necc_mean_kb,necc_std_kb,'Control Before',conn_db,necc_mean_db,necc_std_db,'Dyslexia Before');
h11=gcf;
drawCommonConn(conn_ka,necc_mean_ka,necc_std_ka,'Control After',conn_da,necc_mean_da,necc_std_da,'Dyslexia After');
h12=gcf;

CommonConnANOVA(conn_kb,kontrol_before,'KB',conn_ka,kontrol_after,'KA');
CommonConnANOVA(conn_db,disleksi_before,'DB',conn_da,disleksi_after,'DA');
CommonConnANOVA(conn_kb,kontrol_before,'KB',conn_db,disleksi_before,'DB');
CommonConnANOVA(conn_ka,kontrol_after,'KA',conn_da,disleksi_after,'DA');

%% Save Figures
set(findobj('Type','figure'),'Units','normalized','OuterPosition',[0 0 1 1]);
cd(dirname)
saveas(h1,'Common_DBN_for_Control_Before_Models.bmp','bmp');
saveas(h2,'Connection_Weights_for_Control_Before_Models.bmp','bmp');
saveas(h3,'Common_DBN_for_Control_After_Models.bmp','bmp');
saveas(h4,'Connection_Weights_for_Control_After_Models.bmp','bmp'); 
saveas(h5,'Common_DBN_for_Dyslexia_Before_Models.bmp','bmp');
saveas(h6,'Connection_Weights_for_Dyslexia_Before_Models.bmp','bmp');
saveas(h7,'Common_DBN_for_Dyslexia_After_Models.bmp','bmp');
saveas(h8,'Connection_Weights_for_Dyslexia_After_Models.bmp','bmp');
saveas(h9,'Connection_Weights_for_CB_and_CA_Models.bmp','bmp');
saveas(h10,'Connection_Weights_for_DB_and_DA_Models.bmp','bmp');
saveas(h11,'Connection_Weights_for_CB_and_DB_Models.bmp','bmp');
saveas(h12,'Connection_Weights_for_CA_and_DA_Models.bmp','bmp');
cd ..




