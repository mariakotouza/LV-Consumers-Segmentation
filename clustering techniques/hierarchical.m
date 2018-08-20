function hierarchical(average_plot,dataset_id,start,numC,attr)    
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
%parameter 'linkage algorithm' of the Hierarchical clustering algorithms and computes the 
%values of the 6 metrics for the value of variable-start till the value of 
%variable-numC. The results are saved into .xls files

for i=start:numC
    Y=pdist(average_plot);
    Z=linkage(Y,'average');
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

    Y=pdist(average_plot);
    Z=linkage(Y,'centroid');
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
 
    Y=pdist(average_plot);
    Z=linkage(Y,'single');
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

    Y=pdist(average_plot);
    Z=linkage(Y,'ward');
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

    Y=pdist(average_plot);
    Z=linkage(Y,'weighted');
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

    Y=pdist(average_plot);
    Z=linkage(Y,'complete');
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
    filename = sprintf('hierarchical%d_linkage.xlsx',dataset_id);
    xlswrite(filename,all_metrics,1,'A1:F54')

    filename = sprintf('hierarchical%d_linkage_j.xlsx',dataset_id);
    xlswrite(filename,j(start:numC,:),1,'A1:F9')
else
    filename = sprintf('hierarchical_attr%d_linkage.xlsx',dataset_id);
    xlswrite(filename,all_metrics,1,'A1:F54')

    filename = sprintf('hierarchical_attr%d_linkage_j.xlsx',dataset_id);
    xlswrite(filename,j(start:numC,:),1,'A1:F9')   
end

end

