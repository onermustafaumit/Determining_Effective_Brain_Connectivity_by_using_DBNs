function distance=bfs(adj_matrix,start_node)

n=size(adj_matrix,1);
d=-1*ones(n,1); %distances to other 
% pred=zeros(1,n); %predecessors of the node
sq=zeros(n,1);
sqt=0;
sqh=0; % search queue and search queue tail/head

% start bfs at start_node
sqt=sqt+1;
sq(sqt)=start_node;
d(start_node)=0;
while sqt-sqh>0
    sqh=sqh+1;
    v=sq(sqh); % pop v off the head of the queue
    ind = find(adj_matrix(v,:));
    for w=ind;
        if d(w)<0
            sqt=sqt+1;
            sq(sqt)=w;
            d(w)=d(v)+1;
%           pred(w)=v; 
        end
    end
end
distance=d;
