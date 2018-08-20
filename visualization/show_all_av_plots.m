figure;
cc=hsv(42);
for i=1:42
   plot(average_plot(i,:),'color',cc(i,:));
   hold on;
end