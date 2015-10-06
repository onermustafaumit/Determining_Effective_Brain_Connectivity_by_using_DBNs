function dag=DBmcmc_inter2dag(inter)
% DBmcmc_inter2dag: Transformation: inter --> dag
%
% Invocation
% inter= DBmcmc_dag2inter(dag)

N_inter= size(inter,1);
if N_inter~= size(inter,2)
   error('inter must be a quadratic matrix')
end
N_dag=2*N_inter;

dag=zeros(N_dag);
dag(1:N_inter,N_inter+1:2*N_inter)=inter;



