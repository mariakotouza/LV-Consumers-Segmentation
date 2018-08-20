set3=importdata('results.csv');
average_plot3_not_norm=set3.data(:,2:end);
for i=1:size(average_plot3_not_norm,1)
    average_plot3(i,:)=average_plot3_not_norm(i,:)/max(average_plot3_not_norm(i,:));
end

unit=size(average_plot3,2);
for i=1:size(average_plot3,1)
    attributes3(i,1)=mean(average_plot3(i,1:unit/4))/mean(average_plot3(i,:));
    attributes3(i,2)=mean(average_plot3(i,unit/4+1:unit/2))/mean(average_plot3(i,:));
    attributes3(i,3)=mean(average_plot3(i,unit/2+1:3*unit/4))/mean(average_plot3(i,:));
    attributes3(i,4)=mean(average_plot3(i,3*unit/4+1:unit))/mean(average_plot3(i,:));
    attributes3(i,5)=(std(average_plot3(i,1:unit/4))/attributes3(i,1)+std(average_plot3(i,unit/4+1:unit/2))/attributes3(i,2)+std(average_plot3(i,unit/2+1:3*unit/4))/attributes3(i,3)+std(average_plot3(i,3*unit/4+1:unit))/attributes3(i,4))/4;
    attributes3(i,6)=attributes3(i,5)/mean(average_plot3(i,:));
end


%clear j
%k=0;
%for i=26:35
%    [idx,ci] = kmeans(average_plot3,i,'Replicates',80,'Options',statset('UseParallel',1));
%    k=k+1;
%    j(k,1)=J(average_plot3,idx,ci);
%end

%figure
%plot(j);