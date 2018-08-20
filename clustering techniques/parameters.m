%In this script we parameterize the algorithms k-means, fuzzy C-means som and Hierarchical in
%order to find the best parameters for each input array that is used for each one of the three
%Datasets.

kmeans_param(average_plot_min1,1,2,10,0);
kmeans_param_initial_centers(average_plot_min1,1,2,10,0);
fuzzy_param(average_plot_min1,1,2,10,0);
som_param(average_plot_min1,1,2,10,0);
hierarchical(average_plot_min1,1,2,10,0);
hierarchical_linkage_dist(average_plot_min1,1,2,10,0);

kmeans_param(average_plot_hour2,2,6,14,0);
kmeans_param_initial_centers(average_plot_hour2,2,6,14,0);
fuzzy_param(average_plot_hour2,2,6,14,0);
som_param(average_plot_hour2,2,6,14,0);
hierarchical(average_plot_hour2,2,6,14);
hierarchical_linkage_dist(average_plot_hour2,2,6,14);

kmeans_param(average_plot3,3,4,12,0);
kmeans_param_initial_centers(average_plot3,3,4,12,0);
fuzzy_param(average_plot3,3,4,12,0);
som_param(average_plot3,3,4,12,0);
hierarchical(average_plot3,3,4,12,0);
hierarchical_linkage_dist(average_plot3,3,4,12,0);

kmeans_param(attributes1,1,2,10,1);
kmeans_param_initial_centers(attributes1,1,2,10,1);
fuzzy_param(attributes1,1,2,10,1);
som_param(attributes1,1,2,10,1);
hierarchical(attributes1,1,2,10,1);
hierarchical_linkage_dist(attributes1,1,2,10,1);

kmeans_param(attributes2,2,6,14,1);
kmeans_param_initial_centers(attributes2,2,6,14,1);
fuzzy_param(attributes2,2,6,14,1);
som_param(attributes2,2,6,14,1);
hierarchical(average_plot_hour2,2,6,14,1);
hierarchical_linkage_dist(attributes2,2,6,14,1);

kmeans_param(attributes3,3,4,12,1);
kmeans_param_initial_centers(attributes3,3,4,12,1);
fuzzy_param(attributes3,3,4,12,1);
som_param(attributes3,3,4,12,1);
hierarchical(attributes3,3,4,12,1);
hierarchical_linkage_dist(attributes3,3,4,12,1);
metrics_attr(attributes3,average_plot3,4,12,3)