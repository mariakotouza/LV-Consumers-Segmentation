function [limit1,limit2]=find_region_of_valley(total_plot,valley_index)
%% Input arguments
%total_plot->1xN array, where N=number of measurements. Contains the sum of 
%       the average plots of the
%valley_index->a vector that contains the indexes of the valleys of the total
%       plot
%
%% Output arguments
%limit1->vector that contains the indexes of the values of the total plot
%       that shows each point from where a valley region begins.
%limit2->vector that contains the indexes of the values of the total plot
%       that shows each point from where a valley region ends.
%
%% Description
%This function finds the region of each valley that is contained in vector valley_index

limit2=length(total_plot);
%Start from the valley value and check each next value of the total plot. If
%it is bigger than the threshold, break.
for i=valley_index+1:length(total_plot)-1
    if (total_plot(i)>1.15*total_plot(valley_index)) || (total_plot(i)>total_plot(i+1))
        limit2=i-1;
        break;
    end
end

%Start from the valley value and check each previous value of the total plot. If
%it is bigger than the threshold, break.
limit1=1;
for i=valley_index-1:-1:2
    if total_plot(i)>1.15*total_plot(valley_index) || (total_plot(i)>total_plot(i-1))
        limit1=i+1;
        break;
    end
end

    
end

