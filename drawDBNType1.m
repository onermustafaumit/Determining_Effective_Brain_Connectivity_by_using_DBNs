function drawDBNType1(varargin)

dagPosterior=varargin{1};
if nargin>=2
   flag_threshold=1; 
   threshold=varargin{2};
else
   flag_threshold=0;
end

labels={'O1', 'O2', 'P3', 'P4', 'P7','P8', 'T7', 'T8', 'C3', 'C4','F3','F4','F7', 'F8','O1', 'O2', 'P3', 'P4', 'P7', 'P8', 'T7', 'T8', 'C3', 'C4', 'F3', 'F4', 'F7', 'F8'};
node_t=cat(1,ones(14,1),zeros(14,1));
x=[0.097:0.062:0.903,0.097:0.062:0.903];
y=[0.8*ones(1,14),0.2*ones(1,14)];

if flag_threshold
   figure
   dagThresh= dagPosterior>threshold;
   dbn_adj=DBmcmc_inter2dag(dagThresh);
   draw_graph(dbn_adj,labels, node_t, x, y);
else
   for i=2:1:5
       threshold=i/10;
       figure
       dagThresh= dagPosterior>threshold;
       dbn_adj=DBmcmc_inter2dag(dagThresh);
       draw_graph(dbn_adj,labels, node_t, x, y);
       disp('Press any key to continue ...')
       pause
   end
end
