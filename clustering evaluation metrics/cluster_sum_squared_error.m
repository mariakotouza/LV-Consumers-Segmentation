function dist = cluster_sum_squared_error(cj,Wj)
%% Input arguments
%cj->the centre of the cluster
%Wj->contains the average plots of the consumers that belong to the current
%   cluster
%
%% Output arguments
%dist->the computed distance
%
%% Description
%This function computes the sum of squared error of a cluster.

Nj=size(Wj,1);
dist=0;
for i=1:Nj
    dist= dist+(d(cj,Wj(i,:))^2)/Nj;
end

dist=sqrt(dist);

end

