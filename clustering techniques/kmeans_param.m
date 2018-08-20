function kmeans_param(input_data,dataset_id,start,numC,attr)    
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
%parameter 'Distance' of the clustering algorithm K-means and computes the 
%values of the 6 metrics for the value of variable-start till the value of 
%variable-numC. To find more reliable results we run all the algorithms that 
%have some randomness factor 10 times and take the average values of the 
%metrics. The results are saved into .xls files

for i=start:numC
    
    for k=1:10
        [idx_temp,ci_temp] = kmeans(input_data,i,'Distance','sqeuclidean','Replicates',80,'Options',statset('UseParallel',1));
        j_temp(k)=J(input_data,idx_temp,ci_temp);
        mia_temp(k) = MIA(input_data,idx_temp,ci_temp);
        cdi_temp(k) = CDI(input_data,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(input_data,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(input_data,idx_temp,ci_temp);
    end    
    j(i,1) = mean(j_temp);
    mia(i,1) = mean(mia_temp);
    cdi(i,1) = mean(cdi_temp);
    smi(i,1) = mean(smi_temp);
    dbi(i,1) = mean(dbi_temp);
    wcbcr(i,1) = mean(wcbcr_temp);

    for k=1:10
        [idx_temp,ci_temp] = kmeans(input_data,i,'Distance','correlation','Replicates',80,'Options',statset('UseParallel',1));
        j_temp(k)=J(input_data,idx_temp,ci_temp);
        mia_temp(k) = MIA(input_data,idx_temp,ci_temp);
        cdi_temp(k) = CDI(input_data,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(input_data,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(input_data,idx_temp,ci_temp);
    end      
    j(i,2) = mean(j_temp);
    mia(i,2) = mean(mia_temp);
    cdi(i,2) = mean(cdi_temp);
    smi(i,2) = mean(smi_temp);
    dbi(i,2) = mean(dbi_temp);
    wcbcr(i,2) = mean(wcbcr_temp);
    
    for k=1:10
        [idx_temp,ci_temp] = kmeans(input_data,i,'Distance','cityblock','Replicates',80,'Options',statset('UseParallel',1));
        j_temp(k)=J(input_data,idx_temp,ci_temp);
        mia_temp(k) = MIA(input_data,idx_temp,ci_temp);
        cdi_temp(k) = CDI(input_data,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(input_data,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(input_data,idx_temp,ci_temp);
    end    
    j(i,3) = mean(j_temp);
    mia(i,3) = mean(mia_temp);
    cdi(i,3) = mean(cdi_temp);
    smi(i,3) = mean(smi_temp);
    dbi(i,3) = mean(dbi_temp);
    wcbcr(i,3) = mean(wcbcr_temp);
    
    for k=1:10
        [idx_temp,ci_temp] = kmeans(input_data,i,'Distance','cosine','Replicates',80,'Options',statset('UseParallel',1));
        j_temp(k)=J(input_data,idx_temp,ci_temp);
        mia_temp(k) = MIA(input_data,idx_temp,ci_temp);
        cdi_temp(k) = CDI(input_data,idx_temp,ci_temp);
        smi_temp(k) = SMI(ci_temp);
        dbi_temp(k) = DBI(input_data,idx_temp,ci_temp);
        wcbcr_temp(k) = WCBCR(input_data,idx_temp,ci_temp);
    end    
    j(i,4) = mean(j_temp);
    mia(i,4) = mean(mia_temp);
    cdi(i,4) = mean(cdi_temp);
    smi(i,4) = mean(smi_temp);
    dbi(i,4) = mean(dbi_temp);
    wcbcr(i,4) = mean(wcbcr_temp);
    
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

%% Save the results into .xls files
if attr==0
    filename = sprintf('kmeans%d_dist.xlsx',dataset_id);
    xlswrite(filename,all_metrics,1,'A1:D54')

    filename = sprintf('kmeans%d_dist_j.xlsx',dataset_id);
    xlswrite(filename,j(start:numC,:),1,'A1:F9')
else
    filename = sprintf('kmeans_attr%d_dist.xlsx',dataset_id);
    xlswrite(filename,all_metrics,1,'A1:D54')

    filename = sprintf('kmeans_attr%d_dist_j.xlsx',dataset_id);
    xlswrite(filename,j(start:numC,:),1,'A1:F9')
end

end

