function [limit1,limit2]=find_region_of_peak(total_plot,peak_index,factor)
%% Input arguments
%total_plot->1xN array, where N=number of measurements. Contains the sum of 
%       the average plots of the
%peak_index->a vector that contains the indexes of the peaks of the total
%       plot
%factor->percentage that sets the threshold for the peak region. We
%       assume that a point near to the peak belongs to the peak region if
%       its value is bigger than the threshold=factor*peak value
%
%% Output arguments
%limit1->vector that contains the indexes of the values of the total plot
%       that shows each point from where a peak region begins.
%limit2->vector that contains the indexes of the values of the total plot
%       that shows each point from where a peak region ends.
%
%% Description
%This function finds the region of each peak that is contained in vector peak_index

limit2=length(total_plot);
%Start from the peak value and check each next value of the total plot(peak_index). If
%it is smaller than the threshold, break.
for i=peak_index+1:length(total_plot)-1
    if (total_plot(i)<factor*total_plot(peak_index)) || (total_plot(i)<total_plot(i+1))
        limit2=i-1;
        break;
    end
end

%Start from the peak value and check each previous value of the total plot(peak_index). If
%it is smaller than the threshold, break.
limit1=1;
for i=peak_index-1:-1:2
    if total_plot(i)<factor*total_plot(peak_index) || (total_plot(i)<total_plot(i-1))
        limit1=i+1;
        break;
    end
end

    
end

