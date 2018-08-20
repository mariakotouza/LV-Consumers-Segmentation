function [cl,elem,percentage] = histo(average_plot,idx,ci,dataset_id,attr)
%% Input arguments
%average_plot->MxN array, where M=number of consumers and N=number of measurements     
%       Contains the average plot of the consumers of the dataset   
%idx->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%dataset_id->the id of the input data set (e.g. 1,2,3)
%attr->shows if the clusters have been computed using the 7 average load
%       profiles or using the 7 attributes that characterises each consumer.
%
%% Output arguments
%cl->Cx1 vector that contains the ids of the clusters that we have in the
%       dataset
%elem->Cx1 vector that contains the number of the consumers that belong to
%       each cluster
%percentage->Cx1 vector that contains the percentage of the consumers that 
%       belong to each cluster 
%
%% Description
%This function saves in an .xls file all the information that we need to
%create an histogram for the elements of the clusters of the dataset.

%Find the elements that belong to cluster-i
for i=1:size(ci,1)
    clusteri=find(idx==i);
    elem(i,1)=length(clusteri);
    percentage(i,1)=elem(i,1)/size(average_plot,1);
    clear clusteri;
end

cl=unique(idx);
h=[cl,elem,percentage];

%Write the output of the function into an .xls file
if attr==0
    filename = sprintf('histo%d.xlsx',dataset_id);
    xlswrite(filename,h);
else
    filename = sprintf('histo%d_attr.xlsx',dataset_id);
    xlswrite(filename,h);
end

end

