function data=DBmcmc_SampleData(bnet,N)
% SampleData: Sample data from a specified DAG
%
% INPUT
% bnet: bnet object with the known DAG
% N: sample size of the data 
%
% OUTPUT
% data: sampled data from the bnet
%
% INVOCATION
% data=SampleData(bnet,N)

% nNodes=length(bnet.dnodes)+length(bnet.cnodes);
nNodes=length(bnet.observed);

data_array= zeros(nNodes,N);
for n=1:N
	samples = sample_bnet(bnet);
	for m=1:nNodes
		data_array(m,n)=samples{m};
	end
end
data=num2cell(data_array);

