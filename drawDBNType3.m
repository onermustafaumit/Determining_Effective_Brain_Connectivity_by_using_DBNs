function drawDBNType3(varargin)

dagPosterior=varargin{1};
if nargin>=2
   flag_threshold=1; 
   threshold=varargin{2};
   if nargin==3
      label=varargin{3};
   end
else
   flag_threshold=0;
end

labels={'O_l', 'P_l', 'T_l', 'C_l','F_l','O_r','P_r','T_r', 'C_r','F_r','O_l', 'P_l', 'T_l', 'C_l','F_l','O_r','P_r','T_r', 'C_r','F_r'};
node_t=cat(1,ones(10,1),zeros(10,1));
x=[0.095:0.09:0.905,0.095:0.09:0.905];
y=[0.8*ones(1,10),0.2*ones(1,10)];

if flag_threshold
   figure
   dagThresh= dagPosterior>threshold;
   % Eliminate self connections
   temp1=diag(dagThresh);
   temp2=diag(temp1);
   dagThresh=dagThresh-temp2;
   %
   dbn_adj=DBmcmc_inter2dag(dagThresh);
   draw_graph(dbn_adj,labels, node_t, x, y);
   title(label)
else
   for i=2:1:5
       threshold=i/10;
       figure
       dagThresh= dagPosterior>threshold;
       % Eliminate self connections
       temp1=diag(dagThresh);
       temp2=diag(temp1);
       dagThresh=dagThresh-temp2;
       %
       dbn_adj=DBmcmc_inter2dag(dagThresh);
       draw_graph(dbn_adj,labels, node_t, x, y);
       disp('Press any key to continue ...')
       pause
   end
end
