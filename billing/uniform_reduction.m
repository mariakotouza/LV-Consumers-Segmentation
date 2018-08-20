function [new_plot] = uniform_reduction(total_plot,bill,old_price,limits1,limits2,a,c)
%% Input arguments
%total_plot->1xN array, where N=number of measurements. Contains the sum of 
%       the average plots of the
%       consumers that belong to each cluster
%bill->1xN array that contains the new tariffs for each consumer
%old_price->the basic price before the application of the new tariff
%limits1->vector that contains the indexes of the values of the total plot
%       that shows each point from where a peak region begins.
%limits2->vector that contains the indexes of the values of the total plot
%       that shows each point from where a peak region ends.
%
%% Output arguments
%new_plot->the new average plot of the cluster that is created when all the
%       consumers that belong to the cluster have the behaviour 1
%
%% Description
%This function creates the new total plot of the cluster, assuming that all
%the consumers that belong to the cluster have the behaviour 1. According to 
%Behaviour 1, consumers uniformly allocate their load from the peak region 
%to any other regions.

unit=length(total_plot);
new_plot=zeros(1,unit);

%Find the number of elements of the total_plot that correspond to a peak
%area
peak_period=0;
for j=1:length(limits2)
    peak_period=peak_period+limits2(j)-limits1(j)+1;
end 

%Find the new values of the peak areas and compute the total reduction at the areas of
%peak

total_reduction=0;
for j=1:length(limits2)
    for k=1:limits2(j)-limits1(j)+1
        new_peak=(1 - a * c * (bill(limits1(j)+k-1) - old_price)/old_price)*total_plot(limits1(j)+k-1);
        new_plot(1,limits1(j)+k-1)=new_peak;
        total_reduction=total_reduction+total_plot(limits1(j)+k-1)-new_peak;
    end
    
end

%Allocate uniformly the value total_reduction to the not-peak areas
for i=1:length(total_plot)
    if new_plot(i)==0
       new_plot(i)= total_plot(i)+total_reduction/(unit-peak_period);
    end
end


end

