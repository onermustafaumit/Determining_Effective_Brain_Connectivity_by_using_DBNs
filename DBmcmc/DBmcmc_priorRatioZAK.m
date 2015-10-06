function prior_factor=DBmcmc_priorRatioZAK(dag,new_dag)

% For the ZAK study, where information on sequence motifs
% in the promoter region is used

weight_priorTFbindingSites= 2; 
NactiveNodes=9;

inter=DBmcmc_dag2inter(dag);
new_inter=DBmcmc_dag2inter(new_dag);
inter= inter(1:NactiveNodes,1:NactiveNodes);
new_inter=new_inter(1:NactiveNodes,1:NactiveNodes);

A=1; B=2; C=3; D=4; E=5; F=6; G=7; H=8; J=9;

INTERtrue= zeros(NactiveNodes);
INTERtrue(A,[A,B,C])=1; 
INTERtrue(C,[D,G])=1;
INTERtrue(D,[C,E])=1;
INTERtrue(F,[B,D])=1;
INTERtrue(G,[H,J])=1;

old_matches=sum(sum(inter.*INTERtrue));
new_matches=sum(sum(new_inter.*INTERtrue));

if new_matches>old_matches
   prior_factor=weight_priorTFbindingSites;
elseif new_matches<old_matches
   prior_factor=1/weight_priorTFbindingSites;
else
   prior_factor=1;
end

