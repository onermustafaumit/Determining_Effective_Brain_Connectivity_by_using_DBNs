function DBmcmc_PlotResults(varargin)
%function DBmcmc_PlotResults(t_sampled,accept_ratio,num_edges,INTERposterior,DAGtrue)
% PlotResults: Plots the results
% 
% INPUTS, mandatory
% Results - Output matrix, written out by function
%           DBmcmc_Application
%
% INPUTS, optional
% Precede each optional argument with its keyword in
% inverted commas, e.g., 'DAGtrue',DAGtrue
% threshold - Threshold parameter for plotting the predicted
%             DAG; only edges with posterior probability
%             larger than threshold will be plotted.
%             Default: 0.5; 
% nSimu - specify this number for loading the results
%         from the [nSimu]th simulation, assuming the structure
%         Results.mat contains the results of at least
%         nSimu simulations.
%         Default: 1
% DAGtrue - true DAG, plottted for comparison with the 
%           predicted 
% flag_onlyDAG - Set this flag if you want to suppress
%                all plots except for the predicted DAG 
% 
% EXAMPLES
% DBmcmc_PlotResults(Results)
%    Plots the results in structure Results.mat
% DBmcmc_PlotResults(Results,'DAGtrue',DAGtrue)
%     In addition, plots the true DAG
% DBmcmc_PlotResults(Results,'threshold',0.8)
%    Plots only edges with posterior probability 
%    greater than 0.8. 
% DBmcmc_PlotResults(Results,'nSimu',3)
%    Plots the results of the 3rd simulation

% --------------------------------------------------
% Input parameters 
% --------------------------------------------------
Results= varargin{1};
nargs = length(varargin);
nSimu=1;
threshold=0.5;
flag_DAGtrue=0;
flag_onlyDAG=0;
for i=2:2:nargs
   switch varargin{i},
      case 'threshold'
            threshold = varargin{i+1};
      case 'nSimu'
            nSimu = varargin{i+1};
      case 'DAGtrue'
            DAGtrue= varargin{i+1};
            flag_DAGtrue=1;
      case 'flag_onlyDAG'
            flag_onlyDAG = varargin{i+1};
      otherwise
            error('Wrong argument, possibly a mistyped keyword'); 
   end
end

if ~flag_onlyDAG
   t_sampled= Results{nSimu}.t_sampled;
   accept_ratio= Results{nSimu}.accept_ratio;
   num_edges= Results{nSimu}.num_edges;
end
INTERposterior= Results{nSimu}.INTERposterior;

% --------------------------------------------------
% Plots
% --------------------------------------------------

if ~flag_onlyDAG
   figure(1)
   clf
   plot(t_sampled, accept_ratio);
   xlabel('MCMC steps')
   ylabel('Acceptance ratio')
   grid on
   figure(2)
   clf
   plot(t_sampled, num_edges);
   xlabel('MCMC steps')
   ylabel('Number of edges')
   grid on
end

% figure(3)
% clf
% DBmcmc_DrawThresholdedDag(INTERposterior,threshold)
% grid on

% Compare with true network
if flag_DAGtrue
   figure(4)
   clf
   draw_layout(DBmcmc_dag2inter(DAGtrue));
   draw_graph(DBmcmc_dag2inter(DAGtrue));
end

