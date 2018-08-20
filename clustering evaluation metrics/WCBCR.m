function m = WCBCR(xi,idx,ci)
%% Input arguments
%xi->MxN array, where M=number of consumers and N=number of measurements     
%       Contains the average plot of the consumers of the dataset   
%idx->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%
%% Output arguments
%m->the Ratio of within cluster sum of squares to between cluster variation 
%       of the clusters
%
%% Description
%This function computes the Ratio of within cluster sum of squares to between 
%cluster variation of the clusters

C=size(ci,1) ; %number of clusters
numerator=0;
denominator=0;
for j=1:C
    index=find(idx==j);
    for i=1:length(index)
        Wj(i,:)=xi(index(i),:);
        numerator=numerator+d(Wj(i,:),ci(j,:))^2;
    end
    clear index
    clear Wj
end

for p=1:C
    for q=1:C
        if q<p
            denominator=denominator+d(ci(p,:),ci(q,:))^2;
        end
    end
end

m=numerator/denominator;

end

