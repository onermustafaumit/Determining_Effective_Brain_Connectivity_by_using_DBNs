function DBmcmc_DrawThresholdedDag(varargin)
% DrawThresholdedDag: Draw DAG after thresholding
% If a threshold is provided in the argument list, a
% single graph is drawn after applying the specified
% threshold operation.
% If threshold is not provided, four graphs are drawn
% with fixed thresholds 0.2, 0.4, 0.6, 0.8
%
% INPUT
% dagPosterior: averaged DAG from an MCMC simulation,
% whose elements give the posterior probabilities of the edges
% threshold: all edges below the treshold are discarded
%
% INVOCATION
% DBmcmc_DrawThresholdedDag(dagPosterior,threshold)

dagPosterior=varargin{1};
if nargin>=2
   flag_threshold=1; 
   threshold=varargin{2};
else
   flag_threshold=0;
end

if flag_threshold
   dagThresh= dagPosterior>threshold;
   %draw_layout(dagThresh);
   draw_graph(dagThresh);
else
   for i=2:2:8
       threshold=i/10
       clf
       dagThresh= dagPosterior>threshold;
       %draw_layout(dagThresh);
       draw_graph(dagThresh);
       disp('Press any key to continue ...')
       pause
   end
end
