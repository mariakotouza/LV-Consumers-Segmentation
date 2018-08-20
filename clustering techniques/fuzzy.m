function [idx,ci]=fuzzy(numC,ov,input_data)
%% Input arguments
%numC->number of clusters that we want to create
%ov->fuzzy factor
%input_data->
%       MxN array, where M=number of consumers 
%                         and N=number of measurements 
%       Contains the average plots of the consumers of the dataset 
%OR
%       Mx7 array, where M=number of consumers 
%       Contains the attributes that characterise the consumers of the dataset 
%
%% Description
%This function implements the fuzzy C-means clustering algorithm. The
%consumers are attributed to that cluster in which they belong more.

[ci,U] = fcm(input_data,numC,[ov 200 NaN 0]);
while ~isempty(find(isnan(U)))
   [ci,U] = fcm(input_data,numC,[ov 200 NaN 0]);
end
maxU=max(U);
for i=1:numC
    cl=find(U(i,:)==maxU);
    for j=1:length(cl)
        idx(cl(j),1)=i;
    end
end
    

for i=1:numC
    index=find(i==unique(idx));
    %If you find an empty cluster
    if isempty(index)
        %Find which clusters have more than 1 elements
        k=0;
        for j=1:numC
            sum_elem(j)=sum(find(j==unique(idx)));
            if sum_elem(j)>1
                k=k+1;
                available(k)=j;
            end
        end
        clear temp;
        new=[];
        for j=1:length(available)
            ind=find(idx==available(k));
            for l=1:length(ind)
                temp(l)=U(i,ind(l));
            end
            new=[new,temp];
        end
        idx(find(U(i,:)==max(temp)),1)=i; 
    end
end
end

    