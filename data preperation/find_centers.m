function ci=find_centers(average_plot,idx)
%% Input arguments
%average_plot->MxN array, where M=number of consumers and N=number of measurements     
%       Contains the average plot of the consumers of the dataset   
%idx->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%
%% Output arguments
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%
%% Description
%This function computes the centres of the num_of_cl of the data set.

%Find the number of clusters that we have
num_of_cl=length(unique(idx));

%Repeat for each cluster
for k=1:num_of_cl
    
    clear index
    clear elem
    
    %Find the elements of cluster-i
    index=find(idx==k);
    for n=1:length(index)
        elem(n,:)=average_plot(index(n),:);
    end
    
    %Find the centre of cluster-i. The centre is the mean value of the
    %elements that the cluster contains.
    if size(elem,1)==1
        ci(k,:)=elem;
    else
        ci(k,:)=mean(elem);
    end
end

end

