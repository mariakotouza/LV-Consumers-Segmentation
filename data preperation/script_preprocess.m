% In this script we make the preprocessing of the three Datasets and the creation of their attributes

%% Dataset1
attr_index=0;

for i=1:42
    
    %Preprocessing
    [a,b,c,average_plot_min1(i,:),average_plot_min1_mot_nomr(i,:)]=preprocess(data1{:,i},dates1{:,i},4);
    newdata1{:,i}=a;
    new_dates1{:,i}=b;
    day_id1{:,i}=c;
    
    % Create attributes
    attr_official1(i,:)=create_attributes(newdata1{:,i},new_dates1{:,i},day_id1{:,i},1440);
    attr = attr_official1(i,:);

    %No summer data. Remove the attribute winter vs summer
    attributes1(i,:)=[attr(:,1:5),attr(:,7)];
    
   
end

%% Dataset2 ~ Households
attr_index=0;
for i=1:99
    
    %Preprocessing
    [a,b,c,average_plot_hour2(i,:),average_plot_hour2_not_norm(i,:)]=preprocess(data2{1,i},dates2{:,i},6);
    newdata2{:,i}=a;
    new_dates2{:,i}=b;
    day_id2{:,i}=c;
    
    % Create attributes
    attr_official2(i,:)=create_attributes(newdata2{:,i},new_dates2{:,i},day_id2{:,i},24); 
    attr = attr_official2(i,:);
   
    %No summer data. Remove the attribute winter vs summer
    attributes2(i,:)=[attr(:,1:5),attr(:,7)];
    
end

%% Dataset2 ~ Offices
for i=1:49
    
    %Preprocessing
    [a,b,c,average_plot_hour2(i+99,:),average_plot_hour2_not_norm(i+99,:)]=preprocess(data2{1,i+99},dates2{:,i+99},6);
    newdata2{:,i+99}=a;
    new_dates2{:,i+99}=b;
    day_id2{:,i+99}=c;
    
    % Create attributes
    attr_official2(i+99,:)=create_attributes(newdata2{:,i+99},new_dates2{:,i+99},day_id2{:,i+99},24);
    attr = attr_official2(i+99,:);

    %no summer data~remove the attribute winter vs summer
    attributes2(i+99,:)=[attr(:,1:5),attr(:,7)];
   
end