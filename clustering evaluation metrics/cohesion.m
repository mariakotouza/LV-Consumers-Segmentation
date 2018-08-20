function coh = cohesion(Wj)
%% Input arguments
%Wj->MjxN array, where Mj=number of consumers of cluster-j 
%                and N=number of measurements 
%       Contains the average plots of the consumers of cluster-j    
%
%% Output arguments
%coh->the cohesion of the given cluster
%
%% Description
%This function computes the cohesion of the given cluster

Nj=size(Wj,1);
coh=0;

for i=1:Nj
   coh=coh+cluster_sum_squared_error(Wj(i,:),Wj)^2; 
end

coh=sqrt(coh/(2*Nj));

end

