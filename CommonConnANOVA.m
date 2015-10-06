function CommonConnANOVA(conn1,data_matrix1,label1,conn2,data_matrix2,label2)
% conn1=conn_kb;
% conn2=conn_ka;
% data_matrix1=kontrol_before;
% data_matrix2=disleksi_after;

global connections;
global connections2;
global dirname;

intersection_set = intersect(conn1,conn2);

[Lia,Locb]=ismember(intersection_set,connections);
for i=1:size(intersection_set,2)
    if Locb(i)==0
    else
        [p,table,stats] = anova1([data_matrix1(:,Locb(i)), data_matrix2(:,Locb(i))],[],'off');
        cd(dirname)
        xlswrite(['ANOVA Table for CC between ' label1 ' and ' label2],table,connections2{Locb(i)})
%         close
%         infigh=gcf;
%         h = findobj(infigh, 'Tag', 'Heading');
%         set(h, 'string', ['ANOVA Table for CC ' connections{Locb(i)} ' between ' label1 ' and ' label2]);
%         saveas(infigh,['ANOVA_Table_for_CC_' connections2{Locb(i)} '_between_' label1 '_and_' label2 '.png'],'png');
        cd ..
    end
end