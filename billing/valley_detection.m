function [valley_list,valley_list_index] = valley_detection(total_plot)
%% Input arguments
%total_plot->1xN array, where N=number of measurements. Contains the sum of 
%       the average plots of the
%
%% Output arguments
%valley_list->a vector that contains the values of the valleys
%valley_list_index->a vector that contains the indexes of the valleys of the
%       total plot
%
%% Description
%This function finds the valley values of the total_plot

%Initialization
e=0.00001; %factor that is used to find out if a value is a topic minimum value
left=0;
middle=0;
right=0;
j=0;

%Find the topic minimum values of the total plot and save them to the variable
%valley_value
for i=1:length(total_plot)-2
    left=total_plot(i);
    middle=total_plot(i+1);
    right=total_plot(i+2);
    if (middle-left<e) && (middle-right<e)
        j=j+1;
        valley_index(j)=i+1;
        valley_value(j)=total_plot(i+1);
    end
end

%The minimum valley value is the min of the vector valley_value
min_valley=min(valley_value);
threshold=min_valley*1.15;
%Find which of the values that are contained into the vector valley_value is
%smaller than the threshold. These values are the valleys of the total_plot
valley_id=find(valley_value<threshold);
for i=1:length(valley_id)
    valley_list(i)=valley_value(valley_id(i));
    valley_list_index(i)=valley_index(valley_id(i));
end

end

