    %Hierarchical 
    Y=pdist(attributes3);
    Z=linkage(Y,'average');
    idx=cluster(Z,'maxclust',10);
    ci3=find_centers(average_plot3,idx);
    