function m = J(xi,idx,ci)
%% Input arguments
%xi->MxN array, where M=number of consumers and N=number of measurements     
%       Contains the average plot of the consumers of the dataset   
%idx->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%
%% Output arguments
%m->the average square error of the clusters
%
%% Description
%This function computes the average square error of the clusters

C=size(ci,1) ; %number of clusters
N=length(idx); %number of elements

m=0;
for i=1:N
    m=m+(d(xi(i,:),ci(idx(i),:)))^2;
end

m=m/N;

end

