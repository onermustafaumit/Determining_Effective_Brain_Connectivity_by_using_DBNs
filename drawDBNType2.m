function drawDBNType2(varargin)

dagPosterior=varargin{1};
if nargin>=2
   flag_threshold=1; 
   threshold=varargin{2};
else
   flag_threshold=0;
end

labels={'O', 'O', 'P', 'P','T', 'T', 'C', 'C','F','F'};
node_t=[1,0,1,0,1,0,1,0,1,0];
x=[0.3,0.7,0.3,0.7,0.3,0.7,0.3,0.7,0.3,0.7];
y=[0.9,0.9,0.74,0.74,0.58,0.58,0.42,0.42,0.26,0.26];

if flag_threshold
   figure
   dagThresh= dagPosterior>threshold;
   
   % Eliminate self connections
   temp1=diag(dagThresh);
   temp2=diag(temp1);
   dagThresh=dagThresh-temp2;
   %
   
   draw_graph(dagThresh,labels, node_t, x, y);
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
       
       draw_graph(dagThresh,labels, node_t, x, y);
       disp('Press any key to continue ...')
       pause
   end
end
