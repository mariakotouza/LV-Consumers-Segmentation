%% Import data from Dataset1
addpath c:/Users/media/Documents/matlab/01_Baseline

for i=1:42
    filename=sprintf('Household%dBaseLine.csv',i);
    set=importdata(filename);
    data1{:,i}=set(:,2);
    dates1{:,i}=set(:,1);
end

%% Import data from Dataset2
addpath c:/Users/media/Documents/matlab/PowerTac

%Households
for i=1:99
    filename=sprintf('Household%d.csv',i);
    set=importdata(filename);
    data2{1,i}=set.data;
    header=set.rowheaders;
    r=strrep(header,'-','');
    for j=1:length(r)
        temp(j,1)=str2num(r{j});
    end
    dates2{1,i}=temp;
end

%Offices
for i=1:49
    filename=sprintf('Office%d.csv',i);
    set=importdata(filename);
    data2{1,i+99}=set.data;
    header=set.rowheaders;
    r=strrep(header,'-','');
    for j=1:length(r)
        temp(j,1)=str2num(r{j});
    end
    dates2{1,i+99}=temp; 
end

%% Import data from Dataset3
set3=importdata('results.csv');

%Not normalized mean curves
average_plot3_not_norm=set3.data(:,2:end);

%Normalized mean curves
for i=1:size(average_plot3_not_norm,1)
    average_plot3(i,:)=average_plot3_not_norm(i,:)/max(average_plot3_not_norm(i,:));
end

%Create attributes for Dataset3
unit=size(average_plot3,2);
for i=1:size(average_plot3,1)
    attributes3(i,1)=mean(average_plot3(i,1:unit/4))/mean(average_plot3(i,:));
    attributes3(i,2)=mean(average_plot3(i,unit/4+1:unit/2))/mean(average_plot3(i,:));
    attributes3(i,3)=mean(average_plot3(i,unit/2+1:3*unit/4))/mean(average_plot3(i,:));
    attributes3(i,4)=mean(average_plot3(i,3*unit/4+1:unit))/mean(average_plot3(i,:));
    attributes3(i,5)=(std(average_plot3(i,1:unit/4))/attributes3(i,1)+std(average_plot3(i,unit/4+1:unit/2))/attributes3(i,2)+std(average_plot3(i,unit/2+1:3*unit/4))/attributes3(i,3)+std(average_plot3(i,3*unit/4+1:unit))/attributes3(i,4))/4;
    attributes3(i,5)=attributes3(i,5)/mean(average_plot3(i,:));
end
