function show_results(average_plot,idx)
%% Input arguments
%average_plot->MxN array, where M=number of consumers and N=number of 
%       measurements
%       Contains the average normalized plots of the Dataset
%
%This function creates one figure for each cluster that contains all the
%average plots of the consumers that belong to this cluster and one figure
%for each cluster that contains the mean average plot of this cluster. It
%also creates one figure that shows all the projection of all plots in two 
%dimensions. The plots that belong to the same cluster are shown with the
%same color.

num_of_clusters=unique(idx);

%Create one figure for each cluster that contains all the
%average plots of the consumers that belong to this cluster
figure 
for i=1:length(num_of_clusters)
    %Find the plots that belong to cluster-i
    clusteri=find(idx==i);
    %Use different colours
    cc=hsv(length(clusteri));
    %Create the sub-plots
    subplot(4,3,i)
    for j=1:length(clusteri)
        plot(average_plot(clusteri(j),:),'color',cc(j,:));
        axis([1 size(average_plot,2) 0 1])
        hold on
    end
    clear clusteri;
end

%Creates one figure for each cluster that contains the mean average plot 
%of this cluster
figure
for i=1:length(num_of_clusters)
    %Find the plots that belong to cluster-i
    clusteri=find(idx==i);
    %Use different colours
    cc=hsv(length(clusteri));
    %Create the sub-plots
    subplot(4,3,i)
    for j=1:length(clusteri)
        a(j,:)=average_plot(clusteri(j),:);
    end
    if length(clusteri)>1
        b=mean(a);
    else
        b=a;
    end
    plot(b);
    axis([1 size(average_plot,2) 0 1])
    clear clusteri;
    clear a;
end

%Create a figure that shows the projection of all plots in two dimensions.
%The plots that belong to the same cluster are shown with the same color.
%The projection can be done using PCA and holding the 2 more significant
%elements for each plot
[COEFF,SCORE] = princomp(average_plot);
X=SCORE(:,1:2);
cc=hsv(num_of_clusters);

figure
for i=1:num_of_clusters
    plot(X(idx==i,1),X(idx==i,2),'k*','color',cc(i,:),'MarkerSize',12)
    hold on
end
%legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Cluster 7','Cluster 8','Cluster 9','Cluster 10','Location','NW')

end