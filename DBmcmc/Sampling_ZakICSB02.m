function data_sampled= Sampling_ZakICSB02(data,timePoints)
% Sample the data from Zak's ICSB paper.
% Dirk Husmeier, 8 July 2003
% INPUT
% data: Data from Zak's simulation
%    This assumes that data(:,17) represents time.
% timePoints: a vector of discrete time points for
%    which the data are read in from "data" and copied
%    into "data_discretized".
% OUTPUT
% data_sampled: sampled data, that is, the vectors
%    of matrix data at the specified time points.
% INVOCATION
% data_sampled= Sampling_ZakICSB02(data,timePoints)

t= data(:,17);
Number_of_sampled_timePoints= length(timePoints);

if max(timePoints)>max(t)
   error('Sampled time points out of range: max(timePoints)>max(t)')
end
if min(timePoints)<0
   error('Sampled time points negative?!')
end

N= length(t);

for n=1:Number_of_sampled_timePoints
    sampledIndex= sum(t<timePoints(n));
    data_sampled(n,:)= data(sampledIndex,:);
end
