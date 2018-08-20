function [peak_list,peak_list_index] = peak_detection(total_plot,factor)
%% Input arguments
%total_plot->1xN array, where N=number of measurements. Contains the sum of 
%       the average plots of the
%factor->percentage that sets the threshold for the peak detection. We
%       assume that a topic maximum value of the total plot is a peak when it
%       is bigger than the threshold=factor*max_peak
%
%% Output arguments
%peak_list->a vector that contains the values of the peaks
%peak_list_index->a vector that contains the indexes of the peaks of the
%       total plot
%
%% Description
%This function finds the peak values of the total_plot

%Initialization
e=0.00001; %factor that is used to find out if a value is a topic maximum value
left=0;
middle=0;
right=0;
j=0;

%Find the topic maximum values of the total plot and save them to the variable
%peak_value
for i=1:length(total_plot)-2
    left=total_plot(i);
    middle=total_plot(i+1);
    right=total_plot(i+2);
    if (middle-left>e) && (middle-right>e)
        j=j+1;
        peak_index(j)=i+1;
        peak_value(j)=total_plot(i+1);
    end
end

%The maximum peak value is the max of the vector peak_value
max_peak=max(peak_value);
threshold=max_peak*factor;
%Find which of the values that are contained into the vector peak_value is
%bigger than the threshold. These values are the peaks of the total_plot
peak_id=find(peak_value>threshold);
for i=1:length(peak_id)
    peak_list(i)=peak_value(peak_id(i));
    peak_list_index(i)=peak_index(peak_id(i));
end

end

