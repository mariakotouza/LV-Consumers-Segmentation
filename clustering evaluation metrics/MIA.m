function m = MIA(xi,idx,ci)
%% Input arguments
%xi->MxN array, where M=number of consumers and N=number of measurements     
%       Contains the average plot of the consumers of the dataset   
%idx->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%
%% Output arguments
%m->the Mean Index Adequacy of the clusters
%
%% Description
%This function computes the Mean Index Adequacy of the clusters

C=size(ci,1) ; %number of clusters
m=0;
for i=1:C
    index=find(idx==i);
    for j=1:length(index)
        Wj(j,:)=xi(index(j),:);
    end
    m=m+cluster_sum_squared_error(ci(i,:),Wj)^2;
    clear Wj
    clear index
end

m=sqrt(m/C);

end

