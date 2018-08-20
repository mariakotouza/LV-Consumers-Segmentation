function [id,C] = bisecting(data,num_of_cl)
%% Input arguments
%data->MxN array, where M=number of consumers and N=number of measurements        
%num_of_cl->number of clusters that we want to create
%
%% Output arguments
%id->Mx1 vector. Contains the indexes of the cluster that each consumer
%       belongs to
%C->num_of_clxN array. Contains the centres of the clusters that are
%       created
%
%% Description
%This function implements the Biscending K-means clustering technique

k=2;
cl=data;
N=size(data,1);
id=ones(N,1);
indexes=1:N;
maxi=1;

while k<=num_of_cl
    %Call k-means to separate cl into 2 num_of_cl
    [idx,c,sumd]= kmeans(cl,2,'Replicates',80,'Options',statset('UseParallel',1));
    
    %Find the new cluster vector 
    ind2=find(idx==2);
    for i=1:length(indexes)
        if sum(ind2==i)==0
            idx(i)=maxi;
        else
            idx(i)=k;
        end
    end
    for i=1:length(indexes)
        id(indexes(i))=idx(i);
    end
    
    %Find the new vector-SUMD and the new centres-C
    SUMD(maxi)=sumd(1);
    SUMD(k)=sumd(2);
    C(maxi,:)=c(1,:);
    C(k,:)=c(2,:);

    %% Find the cluster that will be used for further clustering
    
    %Normalize SUMD
    for i=1:k
        norm_sumd(i)=SUMD(i)/sum(id==i);
    end

    norm_sumd=norm_sumd';

    %Find the id of the cluster with the maximum normalized SUMD
    [maxsumd,maxi]=max(norm_sumd);
    k=k+1;
    clear indexes;
    clear cl;
    
    %Find the elements that are at the cluster-maxi    
    indexes=find(maxi==id);
    for i=1:length(indexes)
        cl(i,:)=data(indexes(i),:);
    end
    if length(indexes)==0
        break;
    end
end



end

