function [sampled_graphs, accept_ratio, num_edges, t_sampled] = DBmcmc_learn_struct_mcmc(data, ns, varargin)
% DBMCMC_LEARN_STRUCT_MCMC Monte Carlo Markov Chain search over DAGs assuming fully observed data
% [sampled_graphs, accept_ratio, num_edges, t_sampled] = DBmcmc_learn_struct_mcmc(data, ns, ...)
% t_sampled are the sampled time points of the MCMC trajectory
% (useful to have for plotting the trajectories). 
% This function is based on learn_struct_mcmc_tdh odf the BNT package.
% Note that in the current implementation the Hastings factor is assumed to be 1,
% hence call DBmcmc_proposalMove(dag) rather then DBmcmc_proposalMove(dag,maxFanIn)
% for the proposal move (see  DBmcmc_proposalMove for an explanation.
% 
% data(i,m) is the value of node i in case m.
% ns(i) is the number of discrete values node i can take on.
%
% sampled_graphs{m} is the m'th sampled graph.
% This is and INTER rather than a DAG matrix 
% (that is, is has already been out through dag2inter)
% accept_ratio(t) = acceptance ratio at iteration t
% num_edges(t) = number of edges in model at iteration t
%
% The following optional arguments can be specified in the form of name/value pairs:
% [default value in brackets]
% 
% maxFanIn - maximum fan-in to a node [none]
% EmaxNodeFanOut - Expected prior number of active source nodes with non-zero fan-out [2]
% scoring_fn - 'bayesian' or 'bic' [ 'bayesian' ]
%              Currently, only networks with all tabular nodes support Bayesian scoring.
% type       - type{i} is the type of CPD to use for node i, where the type is a string
%              of the form 'tabular', 'noisy_or', 'gaussian', etc. [ all cells contain 'tabular' ]
% params     - params{i} contains optional arguments passed to the CPD constructor for node i,
%              or [] if none.  [ all cells contain {'prior', 1}, meaning use uniform Dirichlet priors ]
% discrete   - the list of discrete nodes [ 1:N ]
% clamped    - clamped(i,m) = 1 if node i is clamped in case m [ zeros(N, ncases) ]
% nsamples   - number of samples to draw from the chain after burn-in [ 100*N ]
% delta_samples - interval between two consecutive samples from the chain after burn-in [1]
% burnin     - number of steps to take before drawing samples [ 5*N ]
% init_dag   - starting point for the search [ zeros(N,N) ]
%
% e.g., samples = my_learn_struct_mcmc(data, ns, 'nsamples', 1000);
%

[n ncases] = size(data);

% set default params
maxFanIn=0; % no restriction on max fan-in
EmaxNodeFanOut=2; 
% Prior expectation value for the number of nodes with
% non-zero fan-out.
type = cell(1,n);
params = cell(1,n);
for i=1:n
 type{i} = 'tabular';
 %params{i} = { 'prior', 1};
 params{i} = { 'prior_type', 'dirichlet', 'dirichlet_weight', 1 };
end
scoring_fn = 'bayesian';
discrete = 1:n;
clamped = zeros(n, ncases);
nsamples = 100*n;
delta_samples=1;
burnin = 5*n;
dag = zeros(n);

args = varargin;
nargs = length(args);
for i=1:2:nargs
 switch args{i},
  case 'maxFanIn',   maxFanIn = args{i+1};
  case 'EmaxNodeFanOut', EmaxNodeFanOut= args{i+1};
  case 'nsamples',   nsamples = args{i+1};
  case 'delta_samples',   delta_samples = args{i+1};
  case 'burnin',     burnin = args{i+1};
  case 'init_dag',   dag = args{i+1};
  case 'scoring_fn', scoring_fn = args{i+1};
  case 'type',       type = args{i+1}; 
  case 'discrete',   discrete = args{i+1}; 
  case 'clamped',    clamped = args{i+1}; 
  case 'params',     if isempty(args{i+1}), params = cell(1,n); else params = args{i+1};  end
  otherwise, error('Wrong argument, possibly a mistyped keyword'); 
 end
end

num_accepts = 1;
num_rejects = 1;
T = burnin + nsamples;
accept_ratio = zeros(1, T);
num_edges = zeros(1, T);
sampled_graphs = cell(1, ceil(nsamples/delta_samples)); 

n=0;
for t=1:T
 if ~mod(t,floor(T/10)), t, end % Output to screen for monitoring
 [dag, accept] = take_step(dag, ns, data, clamped, scoring_fn, discrete, type, params, maxFanIn, EmaxNodeFanOut);
 num_edges(t) = sum(dag(:));
 num_accepts = num_accepts + accept;
 num_rejects = num_rejects + (1-accept);
 accept_ratio(t) =  num_accepts/(num_accepts+num_rejects);
 if t > burnin & mod(t,delta_samples)==0  % TDH
   n=n+1;
   sampled_graphs{n} = DBmcmc_dag2inter(dag);  
 end
end

% TDH: thinning
if delta_samples>1
   t_sampled= [1,delta_samples:delta_samples:T];
   accept_ratio= accept_ratio(t_sampled);
   num_edges= num_edges(t_sampled);
else
   t_sampled=1:T;
end


%%%%%%%%%


function [new_dag, accept] = ...
take_step(dag, ns, data, clamped, scoring_fn, discrete, type, params, maxFanIn, EmaxNodeFanOut)

old_prior= DBmcmc_prior(dag,maxFanIn,EmaxNodeFanOut);
if old_prior<=0
   error('old_prior<=0?!'); 
end
[new_dag,nodes,op]= DBmcmc_proposalMove(dag);
new_prior=  DBmcmc_prior(new_dag,maxFanIn,EmaxNodeFanOut);

if new_prior>0
   bf =  bayes_factor(dag, new_dag, op, nodes(1), nodes(2), ns, data, clamped, scoring_fn, discrete, type, params);
   R = bf * (new_prior / old_prior);  % Hastings ratio assumed to be 1 
else
   R=0;
end
u = rand(1,1);
if u >= min(1,R) % reject the move
   accept = 0;
   new_dag = dag;
else
   accept = 1;
end


%%%%%%%%%

function bfactor = bayes_factor(old_dag, new_dag, op, i, j, ns, data, clamped, scoring_fn, discrete, type, params)

u = find(clamped(j,:)==0);
LLnew = score_family(j, parents(new_dag, j), type{j}, scoring_fn, ns, discrete, data(:,u), params{j});
LLold = score_family(j, parents(old_dag, j), type{j}, scoring_fn, ns, discrete, data(:,u), params{j});
bf1 = exp(LLnew - LLold);

if strcmp(op, 'rev')  % must also multiply in the changes to i's family
 u = find(clamped(i,:)==0);
 LLnew = score_family(i, parents(new_dag, i), type{i}, scoring_fn, ns, discrete, data(:,u), params{i});
 LLold = score_family(i, parents(old_dag, i), type{i}, scoring_fn, ns, discrete, data(:,u), params{i});
 bf2 = exp(LLnew - LLold);
else
 bf2 = 1;
end
bfactor = bf1 * bf2;


