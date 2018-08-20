function m = DBI(xi,idx,ci)
%% Input arguments
%xi->MxN array, where M=number of consumers and N=number of measurements     
%       Contains the average plot of the consumers of the dataset   
%idx->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%
%% Output arguments
%m->the Davies Bouldin Index of the clusters
%
%% Description
%This function computes the Davies Bouldin Index of the clusters

C=size(ci,1) ; %number of clusters
m=0;
k=0;
for p=1:C
    for q=1:C
        if p~=q
            index=find(idx==p);
            for j=1:length(index)
                Wp(j,:)=xi(index(j),:);
            end
            clear index;
            index=find(idx==q);
            for j=1:length(index)
                Wq(j,:)=xi(index(j),:);
            end
            clear index;
            k=k+1;
            elem(k)=(cohesion(Wq)+cohesion(Wp))/d(ci(p,:),ci(q,:));
        end
        clear Wp
        clear Wq
    end
    m=m+max(elem);
end

m=m/C;

end

