function inter=DBmcmc_dag2inter(dag)
% DBmcmc_dag2inter: Transformation: dag --> inter
%
% Invocation
% inter= DBmcmc_dag2inter(dag)

N_dag= size(dag,1);

if N_dag~= size(dag,2)
     error('dag must be a quadratic matrix');
end
if mod(N_dag,2)~=0
   error('dag must have an even number of rows and cols.');
end

N_inter= N_dag/2;
inter= dag(1:N_inter,N_inter+1:2*N_inter);



