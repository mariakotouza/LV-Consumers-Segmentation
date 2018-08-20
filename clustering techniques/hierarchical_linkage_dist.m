function hierarchical_linkage_dist(average_plot,dataset_id,start,numC,attr)    
%% Input arguments
%input_data->
%       MxN array, where M=number of consumers 
%                         and N=number of measurements 
%       Contains the average plots of the consumers of the dataset 
%OR
%       Mx7 array, where M=number of consumers 
%       Contains the attributes that characterise the consumers of the dataset  
%dataset_id->the id of the input data set (e.g. 1,2,3)
%start->the minimum number of clusters the experiments will create
%numC->the maximum number of clusters the experiments will create
%attr->shows if the clusters have been computed using the 7 average load
%       profiles or using the 7 attributes that characterises each consumer.
%
%% Description
%This function makes experiments trying all the possible values of the 
%parameter 'linkage distance' of the Hierarchical clustering algorithms and computes the 
%values of the 6 metrics for the value of variable-start till the value of 
%variable-numC. The results are saved into .xls files 

for i=start:numC
    Y=pdist(average_plot,'euclidean');
    Y=squareform(Y);
    Z=linkage(Y,'ward','euclidean');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,1) = J(average_plot,idx,ci);
    mia(i,1) = MIA(average_plot,idx,ci);
    cdi(i,1) = CDI(average_plot,idx,ci);
    smi(i,1) = SMI(ci);
    dbi(i,1) = DBI(average_plot,idx,ci);
    wcbcr(i,1) = WCBCR(average_plot,idx,ci);  
 
    Y=pdist(average_plot,'seuclidean');
    Y=squareform(Y);
    Z=linkage(Y,'ward','seuclidean');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,2) = J(average_plot,idx,ci);
    mia(i,2) = MIA(average_plot,idx,ci);
    cdi(i,2) = CDI(average_plot,idx,ci);
    smi(i,2) = SMI(ci);
    dbi(i,2) = DBI(average_plot,idx,ci);
    wcbcr(i,2) = WCBCR(average_plot,idx,ci); 

    Y=pdist(average_plot,'jaccard');
    Y=squareform(Y);
    Z=linkage(Y,'ward','jaccard');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,3) = J(average_plot,idx,ci);
    mia(i,3) = MIA(average_plot,idx,ci);
    cdi(i,3) = CDI(average_plot,idx,ci);
    smi(i,3) = SMI(ci);
    dbi(i,3) = DBI(average_plot,idx,ci);
    wcbcr(i,3) = WCBCR(average_plot,idx,ci);     
    
    Y=pdist(average_plot,'cityblock');
    Y=squareform(Y);
    Z=linkage(Y,'ward','cityblock');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,4) = J(average_plot,idx,ci);
    mia(i,4) = MIA(average_plot,idx,ci);
    cdi(i,4) = CDI(average_plot,idx,ci);
    smi(i,4) = SMI(ci);
    dbi(i,4) = DBI(average_plot,idx,ci);
    wcbcr(i,4) = WCBCR(average_plot,idx,ci); 

    Y=pdist(average_plot,'minkowski');
    Y=squareform(Y);
    Z=linkage(Y,'ward','minkowski');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,5) = J(average_plot,idx,ci);
    mia(i,5) = MIA(average_plot,idx,ci);
    cdi(i,5) = CDI(average_plot,idx,ci);
    smi(i,5) = SMI(ci);
    dbi(i,5) = DBI(average_plot,idx,ci);
    wcbcr(i,5) = WCBCR(average_plot,idx,ci); 

    Y=pdist(average_plot,'chebychev');
    Y=squareform(Y);
    Z=linkage(Y,'ward','chebychev');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,6) = J(average_plot,idx,ci);
    mia(i,6) = MIA(average_plot,idx,ci);
    cdi(i,6) = CDI(average_plot,idx,ci);
    smi(i,6) = SMI(ci);
    dbi(i,6) = DBI(average_plot,idx,ci);
    wcbcr(i,6) = WCBCR(average_plot,idx,ci); 
    
    Y=pdist(average_plot,'hamming');
    Y=squareform(Y);
    Z=linkage(Y,'ward','hamming');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,7) = J(average_plot,idx,ci);
    mia(i,7) = MIA(average_plot,idx,ci);
    cdi(i,7) = CDI(average_plot,idx,ci);
    smi(i,7) = SMI(ci);
    dbi(i,7) = DBI(average_plot,idx,ci);
    wcbcr(i,7) = WCBCR(average_plot,idx,ci); 
       
    Y=pdist(average_plot,'cosine');
    Y=squareform(Y);
    Z=linkage(Y,'ward','cosine');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,8) = J(average_plot,idx,ci);
    mia(i,8) = MIA(average_plot,idx,ci);
    cdi(i,8) = CDI(average_plot,idx,ci);
    smi(i,8) = SMI(ci);
    dbi(i,8) = DBI(average_plot,idx,ci);
    wcbcr(i,8) = WCBCR(average_plot,idx,ci); 
    
    Y=pdist(average_plot,'correlation');
    Y=squareform(Y);
    Z=linkage(Y,'ward','correlation');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,9) = J(average_plot,idx,ci);
    mia(i,9) = MIA(average_plot,idx,ci);
    cdi(i,9) = CDI(average_plot,idx,ci);
    smi(i,9) = SMI(ci);
    dbi(i,9) = DBI(average_plot,idx,ci);
    wcbcr(i,9) = WCBCR(average_plot,idx,ci); 
    
    Y=pdist(average_plot,'spearman');
    Y=squareform(Y);
    Z=linkage(Y,'ward','spearman');
    idx=cluster(Z,'maxclust',i);
    for k=1:i
        clear index
        clear elem
        index=find(idx==k);
        for n=1:length(index)
            elem(n,:)=average_plot(index(n),:);
        end
        if size(elem,1)==1
            ci(k,:)=elem;
        else
            ci(k,:)=mean(elem);
        end
    end
    j(i,10) = J(average_plot,idx,ci);
    mia(i,10) = MIA(average_plot,idx,ci);
    cdi(i,10) = CDI(average_plot,idx,ci);
    smi(i,10) = SMI(ci);
    dbi(i,10) = DBI(average_plot,idx,ci);
    wcbcr(i,10) = WCBCR(average_plot,idx,ci);     
    
end

k=0;
for i=start:numC
    all_metrics(k+1,:)=j(i,:);
    all_metrics(k+2,:)=mia(i,:);
    all_metrics(k+3,:)=cdi(i,:);
    all_metrics(k+4,:)=smi(i,:);
    all_metrics(k+5,:)=dbi(i,:);
    all_metrics(k+6,:)=wcbcr(i,:);
    k=k+6;
end

if attr==0
    filename = sprintf('hierarchical%d_linkage_dist.xlsx',dataset_id);
    xlswrite(filename,all_metrics,1,'A1:J54')

    filename = sprintf('hierarchical%d_linkage_dist_j.xlsx',dataset_id);
    xlswrite(filename,j(start:numC,:),1,'A1:J9')
else
    filename = sprintf('hierarchical_attr%d_linkage_dist.xlsx',dataset_id);
    xlswrite(filename,all_metrics,1,'A1:J54')

    filename = sprintf('hierarchical_attr%d_linkage_dist_j.xlsx',dataset_id);
    xlswrite(filename,j(start:numC,:),1,'A1:J9')
end

end

