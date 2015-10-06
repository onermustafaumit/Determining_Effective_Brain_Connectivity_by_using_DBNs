function drawCommonConn(conn1,mean1,std1,legend1,conn2,mean2,std2,legend2)
% conn1=conn_kb;
% conn2=conn_ka;
% mean1=necc_mean_kb;
% std1=necc_std_kb;
% mean2=necc_mean_ka;
% std2=necc_std_ka;
% legend1='Kontrol Before';
% legend2='Kontrol After';

new_mean1=[];
new_std1=[];
new_mean2=[];
new_std2=[];

union_set = union(conn1,conn2);

[Lia,Locb]=ismember(union_set,conn1);
for i=1:size(union_set,2)
    if Locb(i)==0
        new_mean1(i)=NaN;
        new_std1(i)=NaN;
    else
        new_mean1(i)=mean1(Locb(i));
        new_std1(i)=std1(Locb(i));
    end
end

[Lia,Locb]=ismember(union_set,conn2);
for i=1:size(union_set,2)
    if Locb(i)==0
        new_mean2(i)=NaN;
        new_std2(i)=NaN;
    else
        new_mean2(i)=mean2(Locb(i));
        new_std2(i)=std2(Locb(i));
    end
end

figure
errorbar(new_mean1,new_std1,'gd','MarkerFaceColor','g','LineWidth',5)
set(gca, 'XTick',1:size(union_set,2), 'XTickLabel',union_set) %,'ylim',[0 4])
hold on
errorbar(new_mean2,new_std2,'ro','MarkerFaceColor','r','LineWidth',2)
set(gca, 'XTick',1:size(union_set,2), 'XTickLabel',union_set) %,'ylim',[0 4])
legend(legend1, legend2)
title(['\mu ± \sigma for Connection Distances of ' legend1 ' and ' legend2])
%title(['\mu ± \sigma for K-fold ' legend1 ' and ' legend2])
%title(['\mu ± \sigma for Individual ' legend1 ' and ' legend2])



