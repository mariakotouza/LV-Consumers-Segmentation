function metrics_attr(attr,average_plot,start,numC,dataset_id)
%% Input arguments
%attr->Mx7 array, where M=number of consumers 
%       Contains the attributes that characterise the consumers of the dataset   
%start->the minimum number of clusters the experiments will create
%numC->the maximum number of clusters the experiments will create
%dataset_id->the id of the input data set (e.g. 1,2,3)
%
%% Description
%This function computes the values of 6 metrics for 5 clustering techniques
%and number of clusters from the value of variable-start till the value of
%variable-numC. The input data for the clustering algorithms are contained into 
%array-attr. To find more reliable results we run all the algorithms that
%have some randomness factor 10 times and take the average value for the
%metrics. The results are saved into .xls files

for i=start:numC

    %K-means
    for k=1:3
        [idx_temp] = kmeans(attr,i,'Replicates',80,'Options',statset('UseParallel',1));
        ci_temp=find_centers(average_plot,idx_temp);
        j_temp(k)=J(average_plot,idx_temp,ci_temp);
        mia_temp(k) = MIA(average_plot,idx_temp,ci_temp);
        cdi_temp(k) = CDI(average_plot,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(average_plot,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(average_plot,idx_temp,ci_temp);
    end    
    j(i,1) = mean(j_temp);
    mia(i,1) = mean(mia_temp);
    cdi(i,1) = mean(cdi_temp);
    smi(i,1) = mean(smi_temp);
    dbi(i,1) = mean(dbi_temp);
    wcbcr(i,1) = mean(wcbcr_temp);

    %Hierarchical 
    Y=pdist(attr);
    Z=linkage(Y,'average');
    idx=cluster(Z,'maxclust',i);
    ci=find_centers(average_plot,idx);
    j(i,2) = J(average_plot,idx,ci);
    mia(i,2) = MIA(average_plot,idx,ci);
    cdi(i,2) = CDI(average_plot,idx,ci);
    smi(i,2) = SMI(ci);
    dbi(i,2) = DBI(average_plot,idx,ci);
    wcbcr(i,2) = WCBCR(average_plot,idx,ci);    

    %Fuzzy c-means
    for k=1:3
        [idx_temp]=fuzzy(i,1.1,attr);
        ci_temp=find_centers(average_plot,idx_temp);
        while length(unique(idx_temp))~=i 
            [idx_temp]=fuzzy(i,1.1,average_plot);
            ci_temp=find_centers(average_plot,idx_temp);
        end
        j_temp(k)=J(average_plot,idx_temp,ci_temp);
        mia_temp(k) = MIA(average_plot,idx_temp,ci_temp);
        cdi_temp(k) = CDI(average_plot,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(average_plot,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(average_plot,idx_temp,ci_temp);
    end    
    j(i,3) = mean(j_temp);
    mia(i,3) = mean(mia_temp);
    cdi(i,3) = mean(cdi_temp);
    smi(i,3) = mean(smi_temp);
    dbi(i,3) = mean(dbi_temp);
    wcbcr(i,3) = mean(wcbcr_temp);
       

    %Biscending k-means
    for k=1:3
        [idx_temp] = bisecting(attr,i);
        ci_temp=find_centers(average_plot,idx_temp);
        j_temp(k)=J(average_plot,idx_temp,ci_temp);
        mia_temp(k) = MIA(average_plot,idx_temp,ci_temp);
        cdi_temp(k) = CDI(average_plot,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(average_plot,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(average_plot,idx_temp,ci_temp);
    end    
    j(i,4) = mean(j_temp);
    mia(i,4) = mean(mia_temp);
    cdi(i,4) = mean(cdi_temp);
    smi(i,4) = mean(smi_temp);
    dbi(i,4) = mean(dbi_temp);
    wcbcr(i,4) = mean(wcbcr_temp);
    
    %Som    
    for k=1:3
        [idx_temp] = som(attr,i,3,'hextop','boxdist'); 
        if length(unique(idx_temp))==i 
            ci_temp=find_centers(average_plot,idx_temp);
        end
        while length(unique(idx_temp))~=i 
            [idx_temp] = som(average_plot,i,3,'hextop','boxdist');
            ci_temp=find_centers(average_plot,idx_temp);
        end 
        j_temp(k)=J(average_plot,idx_temp,ci_temp);
        mia_temp(k) = MIA(average_plot,idx_temp,ci_temp);
        cdi_temp(k) = CDI(average_plot,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(average_plot,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(average_plot,idx_temp,ci_temp);
    end   
    j(i,5) = mean(j_temp);
    mia(i,5) = mean(mia_temp);
    cdi(i,5) = mean(cdi_temp);
    smi(i,5) = mean(smi_temp);
    dbi(i,5) = mean(dbi_temp);
    wcbcr(i,5) = mean(wcbcr_temp);     

end

cc=hsv(5);
figure
for i=1:5
    plot(start:numC,j(start:numC,i),'o-','color',cc(i,:))
    xlabel('Number of Clusters')
    title('J')
    hold on
end
legend('K-means','Hierarchical','Fuzzy C-means','Biscending k-means','Som','Location','southwest')

figure
for i=1:5
    plot(start:numC,mia(start:numC,i),'o-','color',cc(i,:))
    xlabel('Number of Clusters')
    title('MIA')
    hold on
end
legend('K-means','Hierarchical','Fuzzy C-means','Biscending k-means','Som','Location','southwest')

figure
for i=1:5
    plot(start:numC,cdi(start:numC,i),'o-','color',cc(i,:))
    xlabel('Number of Clusters')
    title('CDI')
    hold on
end
legend('K-means','Hierarchical','Fuzzy C-means','Biscending k-means','Som','Location','southwest')

figure
for i=1:5
    plot(start:numC,smi(start:numC,i),'o-','color',cc(i,:))
    xlabel('Number of Clusters')
    title('SMI')
    hold on
end
legend('K-means','Hierarchical','Fuzzy C-means','Biscending k-means','Som','Location','southwest')

figure
for i=1:5
    plot(start:numC,dbi(start:numC,i),'o-','color',cc(i,:))
    xlabel('Number of Clusters')
    title('DBI')
    hold on
end
legend('K-means','Hierarchical','Fuzzy C-means','Biscending k-means','Som','Location','southwest')

figure
for i=1:5
    plot(start:numC,wcbcr(start:numC,i),'o-','color',cc(i,:))
    xlabel('Number of Clusters')
    title('WCBCR')
    hold on
end
legend('K-means','Hierarchical','Fuzzy C-means','Biscending k-means','Som','K-means++','Location','southwest')

k=0;
for i=start:numC
   m(k+1:k+5,1)=(j(i,:))'; 
   m(k+1:k+5,2)=(mia(i,:))'; 
   m(k+1:k+5,3)=(cdi(i,:))'; 
   m(k+1:k+5,4)=(smi(i,:))'; 
   m(k+1:k+5,5)=(dbi(i,:))'; 
   m(k+1:k+5,6)=(wcbcr(i,:))'; 
   k=k+5;
end

filename = sprintf('results_attr%d.xlsx',dataset_id);
xlswrite(filename,m,1,'A1:F45')

filename = sprintf('j_attr%d.xlsx',dataset_id);
xlswrite(filename,j(start:numC,:),1,'A1:E9')

filename = sprintf('mia_attr%d.xlsx',dataset_id);
xlswrite(filename,mia(start:numC,:),1,'A1:E9')

filename = sprintf('cdi_attr%d.xlsx',dataset_id);
xlswrite(filename,cdi(start:numC,:),1,'A1:E9')

filename = sprintf('smi_attr%d.xlsx',dataset_id);
xlswrite(filename,smi(start:numC,:),1,'A1:E9')

filename = sprintf('dbi_attr%d.xlsx',dataset_id);
xlswrite(filename,dbi(start:numC,:),1,'A1:E9')

filename = sprintf('wcbcr_attr%d.xlsx',dataset_id);
xlswrite(filename,wcbcr(start:numC,:),1,'A1:E9')

end