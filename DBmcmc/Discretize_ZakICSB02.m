function data_discretized= Discretize_ZakICSB02(data)
% Discretize the data from Zak's ICSB paper.
% Dirk Husmeier, 8 July 2003
% INPUT
% data: Data from Zak's simulation
%    This assumes that data(:,17) represents time.
% OUTPUT
% data_discretized: discretized data, that is, the vectors
%    of matrix "data" at the specified time points.
% INVOCATION
% data_discretized= Discretize_ZakICSB02(data)

[N,Ncomponents]= size(data);
t= data(:,Ncomponents); % last component --> time

for n=1:Ncomponents-1 
    data_discretized(:,n)=do_discretize(data(:,n));
end
data_discretized(:,Ncomponents)= data(:,Ncomponents);

% ----------------------------------------
function y_discretized= do_discretize(y)
% ----------------------------------------
% discretize a vector
ymin= min(y);
ymax= max(y);
d= ymax-ymin;
thresh_low= d/3;
thresh_high= 2*d/3;
y = y-ymin;
y= (y>thresh_low) + (y>thresh_high);
y= y-1;
y_discretized= y;
